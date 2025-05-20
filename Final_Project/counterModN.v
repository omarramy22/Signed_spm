`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 02:25:19 PM
// Design Name: 
// Module Name: counterModN
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
module counterModN #(parameter x = 3, n = 6)
(input clk, En, reset, output reg[x-1:0] count);



always @(posedge clk, posedge reset) begin
if (reset == 1) 
count <= 0; // non-blocking assignment
// initialize flip flop here
else if(En == 1) begin
 if (count == n-1)
count <= 0; // non-blocking assignment
// reach count end and get back to zero
else
count <= count + 1; // non-blocking assignment
// normal operation
end
end
endmodule

