`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2025 09:56:02 PM
// Design Name: 
// Module Name: tcmp
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


module twos_complement #(parameter N = 8)(input  wire [N-1:0] in, output wire [N-1:0] out);
    assign out = (~in) + 1'b1;
endmodule

