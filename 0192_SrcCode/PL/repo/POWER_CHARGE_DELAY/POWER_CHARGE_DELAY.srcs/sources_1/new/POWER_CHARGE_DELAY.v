`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 10:08:04
// Design Name: 
// Module Name: POWER_CHARGE_DELAY
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
/*
主要功能：TR按下后，先使能两个电源POWER1和POWER2一段时间充电
之后关闭两个电源，发送一个TR1高脉冲
*/

module POWER_CHARGE_DELAY(
	input TR,
	input rst,
	input clk,//100MHz
	
	output wire POWER1_EN,
	output wire POWER2_EN,
	output wire TR1,
	output wire RST_ALWAYS_HIGH
    );
	
	assign RST_ALWAYS_HIGH = 1;
	
	wire init_tr_pulse;
	reg init_tr_ff = 0;
	reg init_tr_ff2 = 0;
	always@(posedge clk or posedge rst)
	begin
		if(rst==1)
		begin
			init_tr_ff<=0;
			init_tr_ff2<=0;
		end
		else
		begin
			init_tr_ff<=TR;
			init_tr_ff2<=init_tr_ff;
		end
	end
	assign init_tr_pulse = init_tr_ff&&(!init_tr_ff2);
	
	//状态机设计
	reg [2:0] status=0;
	parameter IDLE = 0;//初始状态
	parameter POWER_CHARGE = 1;//充电
	parameter TOP_TR = 2;//发射
	parameter HV_CLOSE_DELAY = 4;//关闭延时
	
	reg [28:0] POWER_CHARGE_COUNTER = 'b0;
	reg [7:0] TOP_TR_COUNTER = 'b0;
	reg [17:0] POWER_CLOSE_DELAY_COUNTER = 'b0;
	
	always@(posedge clk or posedge rst)
	begin
		if(rst==1)
		begin
			POWER_CHARGE_COUNTER<=0;
			TOP_TR_COUNTER<=0;
			POWER_CLOSE_DELAY_COUNTER<=0;
			status<=0;
		end
		else
		begin
			case(status)
			IDLE:
			begin
				if(init_tr_pulse==1)
				begin
					status<=POWER_CHARGE;
					POWER_CHARGE_COUNTER<=0;
					TOP_TR_COUNTER<=0;
				end
				else
				begin
					status<=status;
				end
			end
			
			POWER_CHARGE:
			begin
				if(POWER_CHARGE_COUNTER==28'hfff_ffff)
				begin
					status<=HV_CLOSE_DELAY;
					POWER_CHARGE_COUNTER<=0;
				end
				else
				begin
					POWER_CHARGE_COUNTER<=POWER_CHARGE_COUNTER+'b1;
				end
			end
			
			HV_CLOSE_DELAY:
			begin
				if(POWER_CLOSE_DELAY_COUNTER==17'h1_ffff)
				begin
					status<=TOP_TR;
					POWER_CLOSE_DELAY_COUNTER<=0;
				end
				else
				begin
					POWER_CLOSE_DELAY_COUNTER<=POWER_CLOSE_DELAY_COUNTER+'b1;
				end
			end
			
			TOP_TR:
			begin
				if(TOP_TR_COUNTER==8'hff)
				begin
					status<=IDLE;
					TOP_TR_COUNTER<=0;
				end
				else
				begin
					TOP_TR_COUNTER<=TOP_TR_COUNTER+'b1;
				end
			end
		endcase
	end
	end
	
	assign POWER2_EN = status[0:0];
	assign POWER1_EN = ~POWER2_EN;
	assign TR1 = status[1:1];
	
endmodule





















