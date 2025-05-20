`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2025 12:13:36 AM
// Design Name: 
// Module Name: carry_propagate
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


module carry_propagate_adder(input  wire [15:0] sum, [15:0] carry, output wire [15:0] result);
    assign result = sum + {carry[14:0], 1'b0}; // Left shift carry by 1 position
endmodule
