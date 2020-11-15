`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/09 16:53:40
// Design Name: 
// Module Name: vtf_i2c_test
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
module vtf_i2c_test;
reg rst;
reg clk;
wire    sda;
wire    scl;

initial begin
clk = 0;
forever #10 clk=~clk;
end

initial begin
rst = 1;
#100 rst=0;
#100 rst=1;
end

i2c_MCP4725 utt(
    .rst    (rst),
    .clk    (clk),
    .sda    (sda),
    .scl    (scl)
);    

endmodule
