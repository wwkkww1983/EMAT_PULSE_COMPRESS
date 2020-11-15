`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/22 21:09:30
// Design Name: 
// Module Name: AD_Sample
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


module AD_Sample(
     clk,
     din
    );
    input clk;
    output reg [11:0] din = 0;
    
    always@(posedge clk)
    begin
        din <= din + 'b1;
    end
endmodule
