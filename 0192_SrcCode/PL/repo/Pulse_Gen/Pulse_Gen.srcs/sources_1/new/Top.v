`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/28 15:07:55
// Design Name: 
// Module Name: Top
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


module Top(
    input clk,//脉冲发射部分时钟 100MHz
    input tr,//第一个发射信号
	input tr2,//第二个发射信号
    input rst,//复位信号
	//input HV_EN_KEY,//高电压充能按键
    output wire H1,//1上桥臂
    output wire H2,//2上桥臂
    output wire L1,//1下桥臂
    output wire L2,//2下桥臂
	output wire POWER_EN//电源使能
	//output wire HV_EN//高电压使能
	//output reg [15:0] TR_SAMPLE = 'b0
    );
	parameter BI_PHASE_CODE = 64'hEDE2ED1DEDE212E2;
	parameter BI_PHASE_CODE_COMP = 64'hEDE2ED1D121DED1DEDE212E2;
	parameter CODE_LENGTH   = 64;
	wire CODE;
	/*
	always@(posedge clk or posedge rst)
	begin
		if(rst==1)
		begin
			TR_SAMPLE<=0;
		end
		else begin
			if(CODE==1)begin
				TR_SAMPLE<=16'b1111_1111_1111_1111;
			end
			else begin
				TR_SAMPLE<='b0;
			end
		end
	end
	*/
	
	/*
	reg HV_Charge_Flag = 1;
	wire HV_Charge_init;
	reg HV_Charge_ff = 'b0;
	reg HV_Charge_ff2 = 'b0;
	always@(posedge clk_4MHz or posedge rst)
	begin
		if(rst==1)begin
			HV_Charge_ff <= 0;
			HV_Charge_ff2 <= 0;
		end
		else
		begin
			HV_Charge_ff <=  HV_EN_KEY;
			HV_Charge_ff2 <= HV_Charge_ff;
		end
	end
	assign HV_Charge_init = HV_Charge_ff&&(!HV_Charge_ff2);
	
	always@(posedge HV_Charge_init)begin
		HV_Charge_Flag <= ~HV_Charge_Flag;
	end
	
	assign HV_EN = HV_Charge_Flag;
	*/

    //分频系数
    parameter CLK_DIV = 25;
    reg [4:0] CLK_DIV_COUNTER = 'b0;
    reg clk_4MHz = 'b0;
    
    always@(posedge clk or posedge rst)
    begin
        if(rst==1)begin
            clk_4MHz<='b0;
            CLK_DIV_COUNTER<='b0;
        end
        else
        begin
            if (CLK_DIV_COUNTER==CLK_DIV-1) begin
                CLK_DIV_COUNTER<='b0;
                clk_4MHz<=~clk_4MHz;
            end
            else
            begin
                CLK_DIV_COUNTER<=CLK_DIV_COUNTER+'b1;
                clk_4MHz<=clk_4MHz;
            end
        end
    end
	
    wire init_tr_pulse;
	wire init_tr2_pulse;
    reg init_tr_ff = 'b0;
    reg init_tr_ff2 = 'b0;
	reg init_tr2_ff = 'b0;
    reg init_tr2_ff2 = 'b0;
    assign init_tr_pulse = init_tr_ff && (!init_tr_ff2);
	assign init_tr2_pulse = init_tr2_ff && (!init_tr2_ff2);
	
    always @(posedge clk_4MHz or posedge rst)
    begin
        if (rst==1) begin
            init_tr_ff <= 1'b0;
	   	    init_tr_ff2 <= 1'b0;
			init_tr2_ff <= 1'b0;
	   	    init_tr2_ff2 <= 1'b0;
        end
        else begin
            init_tr_ff<=tr;
            init_tr_ff2<=init_tr_ff;
			init_tr2_ff<=tr2;
            init_tr2_ff2<=init_tr2_ff;
        end
    end

    //发射4MHz二相编码序列

	//parameter BI_PHASE_CODE = 32'b1110_1101_1110_0010_1110_1101_0001_1101;
    //parameter BI_PHASE_CODE_COMP = 32'b1110_1101_1110_0010_0001_0010_1110_0010;
	//parameter BI_PHASE_CODE = 16'b1110_1101_1110_0010;
	//parameter BI_PHASE_CODE_COMP = 16'bb1110_1101_0001_1101;
   
   
    //发射4MHz二相编码序列
    reg [CODE_LENGTH-1:0] BI_PHASE_CODE_REG;//二相码值寄存器
    reg [12:0] CODE_LENGTH_COUNTER = 'b0;//码长计数器
    assign CODE = BI_PHASE_CODE_REG[0:0];//由低位到高位依次发射

    reg [2:0] TR_STATUS = 1'b0;
    parameter TR_WAIT = 0;
    parameter TR_ING  = 1;
    parameter TR_DONE = 2;

    always @(posedge clk_4MHz or posedge rst) begin
        if (rst == 1) begin
            CODE_LENGTH_COUNTER<=0;
            BI_PHASE_CODE_REG<=0;
        end
        else
        begin
            case (TR_STATUS)
                TR_WAIT://等待状态，检测两个触发脉冲
                begin
                    if (init_tr_pulse==1) begin
                        TR_STATUS<=TR_ING;
						BI_PHASE_CODE_REG<=BI_PHASE_CODE;
                    end
					else if(init_tr2_pulse==1)begin
						TR_STATUS<=TR_ING;
						BI_PHASE_CODE_REG<=BI_PHASE_CODE_COMP;
					end
                    else begin
                        TR_STATUS<=TR_STATUS;
                        CODE_LENGTH_COUNTER<=0;
                        BI_PHASE_CODE_REG<=BI_PHASE_CODE_REG;
                    end
                end
				
                TR_ING://发送状态，检测已发送编码数量
                begin
                    if (CODE_LENGTH_COUNTER==CODE_LENGTH-1) begin
                        TR_STATUS<=TR_DONE;
                        CODE_LENGTH_COUNTER<=0;
                        BI_PHASE_CODE_REG<=0;
                    end
                    else
                    begin
                        TR_STATUS<=TR_STATUS;
                        CODE_LENGTH_COUNTER<=CODE_LENGTH_COUNTER+1;
                        BI_PHASE_CODE_REG<=BI_PHASE_CODE_REG>>1;
                    end
                end

                TR_DONE://结束状态，自动转向等待状态
                begin
                    TR_STATUS<=TR_WAIT;
                    CODE_LENGTH_COUNTER<=0;
                    BI_PHASE_CODE_REG<=0;
                end
                default:;
            endcase
        end
    end

    assign H1 = (TR_STATUS[0:0]&&clk_4MHz&&CODE)||(TR_STATUS[0:0]&&~clk_4MHz&&~CODE);
    assign L1 = ~H1;
    assign H2 = (TR_STATUS[0:0]&&~H1)||(~TR_STATUS[0:0]&&H1);
    assign L2 = ~H2;
	assign POWER_EN = TR_STATUS[0:0];//发射时打开
	
	
    
endmodule
