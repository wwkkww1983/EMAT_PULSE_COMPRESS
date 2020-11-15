`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/12 15:00:18
// Design Name: 
// Module Name: Repeat_Sim
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


module Repeat_Sim(

    );
	
	reg clk=0;
	reg rst=0;
	reg key_value=0;
	
	wire TR_signal;
	
	initial
    forever
    begin
        #10
        clk<=~clk;
    end
	
	initial
    begin
        #1000
        key_value<=1;
        #1000
        key_value<=0;
    end
	
	Repeat_TR_Gen u_Repeat_TR_Gen(
	.clk(clk),
	.rst(rst),
	.key_value(key_value),
	.TR_signal(TR_signal)
	);

endmodule
