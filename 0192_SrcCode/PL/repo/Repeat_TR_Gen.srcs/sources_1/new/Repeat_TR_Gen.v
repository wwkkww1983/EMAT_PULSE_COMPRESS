`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/12 13:32:51
// Design Name: 
// Module Name: Repeat_TR_Gen
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


module Repeat_TR_Gen(
	input clk,//50MHz
	input key_value,//按键信号，上升沿有效
	input rst,//复位信号，上升沿有效
	
	output wire TR_signal//输出触发信号，上升沿有效
    );
	
	reg TR_FLAG = 'b0;//触发为1，不触发为0
	always@(posedge key_value or posedge rst)
	begin
		if(rst==1)
		begin
			TR_FLAG<=0;
		end
		if(key_value==1)
		begin
			TR_FLAG<=~TR_FLAG;
		end
	end
	
	reg TR_LEVEL = 'b0;
	//50000000Hz分成0.125Hz
	parameter CLK_DIV = 32'h17D7_8400;
	//test
	//parameter CLK_DIV = 32'h8400;
	reg [31:0] CLK_DIV_COUNTER = 'b0;
	always@(posedge clk or posedge rst)
	begin
		if(rst==1)
		begin
			TR_LEVEL<=0;
			CLK_DIV_COUNTER<=0;
		end
		else
		begin
			if(TR_FLAG==1)
			begin
				if(CLK_DIV_COUNTER<=10)
				begin
					CLK_DIV_COUNTER<=CLK_DIV_COUNTER+'b1;
					TR_LEVEL<=1;
				end
				else if(CLK_DIV_COUNTER==CLK_DIV)
				begin
					CLK_DIV_COUNTER<=0;
					TR_LEVEL<=0;
				end
				else
				begin
					CLK_DIV_COUNTER<=CLK_DIV_COUNTER+'b1;
					TR_LEVEL<=0;
				end
			end
			else
			begin
				CLK_DIV_COUNTER<=0;
				TR_LEVEL<=0;
			end
		end
	end
	
	assign TR_signal = TR_LEVEL;
	
endmodule
















