`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 02:26:36 PM
// Design Name: 
// Module Name: synch
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

module synch(
input clk, D1, output reg Q2);

reg D2;
reg Q1;

always @ (posedge clk)begin

Q1 <=D1;
D2 <= Q1;
Q2<=D2;


end

endmodule
