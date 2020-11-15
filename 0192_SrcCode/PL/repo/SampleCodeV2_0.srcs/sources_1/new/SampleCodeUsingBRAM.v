`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/06 16:17:46
// Design Name: 
// Module Name: SampleCodeUsingBRAM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SampleCodeUsingBRAM(
    input clka,//端口A时钟65MHz
    input clkb,//端口B时钟100MHz
	input rst,//复位信号
	
    input[11:0] AD_Data_in,//AD输入
	input[11:0] TR_Data_in,//TR输入
    input wr_start_first,//第一次写信号
	input wr_start_second,//第二次写信号
    input burst_delay_flag,//AXI Burst之间延时信号，作为读使能信号
    
    output wire [31:0] Data_out,//输出
	output reg half_full_flag = 'b0,//半满信号
    output reg rd_en = 'b0//全满信号
    );
	
	reg [1:0] CLKA_DIV_COUNTER = 'b0;
	reg CLKA_DIV = 'b0;
	always@(posedge clka)
	begin
		if(CLKA_DIV_COUNTER==2'b11)
		begin
			CLKA_DIV_COUNTER<='b0;
			CLKA_DIV<=~CLKA_DIV;
		end
		else
		begin
			CLKA_DIV_COUNTER<=CLKA_DIV_COUNTER+'b1;
			CLKA_DIV<=CLKA_DIV;
		end
	end
	
	reg full_flag = 'b0;
	
	//12位AD输入扩展为32位数据
	wire [31:0] Data_in;
	reg  [15:0] AD_Data_in_16 = 'b0;
	reg  [15:0] TR_Data_in_16 = 'b0;
	always@(posedge clka)
	begin
		AD_Data_in_16[11:0] <= AD_Data_in;
		TR_Data_in_16[11:0] <= TR_Data_in;
	end
	assign Data_in[15:0] = AD_Data_in_16;
	assign Data_in[31:16]= TR_Data_in_16;
    
    reg PORTA_WEA = 1;//A端口写入
    reg PORTB_WEB = 0;//B端口读出
    
    reg PORTA_EN = 0;//写使能
	
	reg [12:0] addra=0;//PortA地址(写地址)
	reg [12:0] addrb=0;//PortB地址(读地址)
	
	//产生第一个写使能脉冲与第二个写使能脉冲
	reg init_wr_ff=0;
	reg init_wr_ff2=0;
	reg init_wr2_ff=0;
	reg init_wr2_ff2=0;
	wire init_wr_pulse;
	wire init_wr2_pulse;
	assign init_wr_pulse = init_wr_ff&&(!init_wr_ff2);
	assign init_wr2_pulse = init_wr2_ff&&(!init_wr2_ff2);
	always@(posedge clka or posedge rst)
	begin
		if(rst==1)
		begin
			init_wr_ff<='b0;
			init_wr_ff2<='b0;
			init_wr2_ff<='b0;
			init_wr2_ff2<='b0;
		end
		else begin
			init_wr_ff<=wr_start_first;
			init_wr_ff2<=init_wr_ff;
			init_wr2_ff<=wr_start_second;
			init_wr2_ff2<=init_wr2_ff;
		end
	end
	
	//写地址增加
	always@(posedge clka or posedge rst)
	begin
		if(rst==1)
		begin
			addra<=0;
		end
		else
		begin
			if(PORTA_EN==1)
			begin
				addra<=addra+'b1;
			end
			else
			begin
				if(addra==13'b1_1111_1111_1111)
				begin
					addra<='b0;
				end
				else
					addra<=addra;
			end
		end
	end
	
	//读地址增加
	always@(posedge clkb or posedge rst)
	begin
		if(rst==1)
		begin
			addrb<=0;
		end
		else
		begin
			if(burst_delay_flag==1)
			begin
				addrb<=addrb+'b1;
			end
			else
			begin
				addrb<=addrb;
			end
		end
	end
	
	//采集模块状态机设计
	reg [2:0] status='b0;
	parameter IDLE = 0;
	parameter FIRST_WR = 1;
	parameter WR_WAITING = 2;
	parameter SECOND_WR = 3;
	parameter WR_DONE = 4;
	
	always@(posedge clka or posedge rst)
	begin
		if(rst==1)begin
			status<=IDLE;
			PORTA_EN<=0;
			full_flag<=0;
			half_full_flag<=0;
		end
		else begin
			case(status)
				IDLE://初始状态，检测写使能脉冲
				begin
					if(init_wr_pulse==1)begin
						status<=FIRST_WR;
						PORTA_EN<=1;
					end
					else begin
						status<=status;
						PORTA_EN<=0;
						half_full_flag<=0;
					end
				end
				
				FIRST_WR://采集第一组回波信号，检测写地址
				begin
					if(addra==13'b0_1111_1111_1111)begin
						status<=WR_WAITING;
						PORTA_EN<=0;
						full_flag<=0;
						half_full_flag<=1;
					end
					else begin
						status<=status;
					end
				end
				
				WR_WAITING://等待状态，检测第二个写使能脉冲
				begin
					if(init_wr2_pulse==1)begin
						status<=SECOND_WR;
						PORTA_EN<=1;
					end
					else begin
						status<=status;
					end
				end
				
				SECOND_WR://采集第二组回波信号，检测写地址
				begin
					if(addra==13'b1_1111_1111_1111)begin
						status<=WR_DONE;
						PORTA_EN<=0;
						full_flag<=1;
						half_full_flag<=0;
					end
					else begin
						status<=status;
					end
				end
				
				WR_DONE://写完成，转向初始状态
				begin
					status<=IDLE;
				end
				
				default:;
			endcase
		end
	end
	
	always@(posedge CLKA_DIV or posedge rst)
	begin
		if(rst==1)
		begin
			rd_en<='b0;
		end
		else begin
			if(full_flag==1)
			begin
				rd_en<=1;
			end
			else
			begin
				rd_en<=0;
			end
		end
	end
	
	//例化BRAM
	blk_mem_gen_0 u_blk_mem_gen_0(
	.clka(clka),
	.ena(PORTA_EN),
	.wea(PORTA_WEA),
	.addra(addra),
	.dina(Data_in),
	.douta(),
	
	.clkb(clkb),
	.enb(burst_delay_flag),
	.web(PORTB_WEB),
	.addrb(addrb),
	.dinb(),
	.doutb(Data_out)
	);
    
endmodule
