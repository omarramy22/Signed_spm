`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2025 10:15:21 PM
// Design Name: 
// Module Name: Top_Module
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


module Top_Module (
    input clk,
    input btnC,
    input btnU,
    input [15:0] SW,
    output [15:0] LED
);

    wire rst = btnU;
    wire start = btnC;
    wire [7:0] multiplicand = SW[7:0];
    wire [7:0] multiplier = SW[15:8];
    wire [15:0] product;
    wire done;

    signed_serial_parallel_multiplier U1 (
        .clk(clk),
        .rst(rst),
        .start(start),
        .a(multiplicand),
        .b(multiplier),
        .product(product),
        .done(done)
    );

    assign LED = product;

endmodule
