`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2025 10:03:02 PM
// Design Name: 
// Module Name: CSADD
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


module carry_save_adder(input wire [15:0] a, [15:0] b, [15:0] c_in, output wire [15:0] sum, [15:0] carry);
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : csa_bit
            assign sum[i] = a[i] ^ b[i] ^ c_in[i];
            assign carry[i] = (a[i] & b[i]) | (a[i] & c_in[i]) | (b[i] & c_in[i]);
        end
    endgenerate
endmodule
