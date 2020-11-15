`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/29 09:55:44
// Design Name: 
// Module Name: TOP_TEST
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


module TOP_TEST(

    );
    wire H1;
    wire H2;
    wire L1;
    wire L2;
	wire POWER_EN;
    
    reg clk=0;
    reg tr=0;
	reg tr2=0;
    reg rst=0;
    
    initial
    forever
    begin
        #10
        clk<=~clk;
    end
    
    initial
    begin
        #1000
        tr<=1;
        #1000
        tr<=0;
		#100000
		tr2<=1;
		#1000
		tr2<=0;
    end
    
    Top u_Top(
    .clk(clk),
    .tr(tr),
	.tr2(tr2),
    .rst(rst),
    
    .H1(H1),
    .H2(H2),
    .L1(L1),
    .L2(L2),
	.POWER_EN(POWER_EN)
    );
endmodule
