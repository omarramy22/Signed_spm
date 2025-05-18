`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2025 09:20:33 AM
// Design Name: 
// Module Name: Top_module
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


module top_module (
    input clk,
    input btnC,
    input btnU,
    input [15:0] SW,
    output [15:0] LED
);

    wire rst = btnC;
    wire start = btnU;
    wire [7:0] multiplicand = SW[7:0];
    wire [7:0] multiplier = SW[15:8];
    wire [15:0] product;
    wire done;

    serial_parallel_multiplier U1 (
        .clk(clk),
        .rst(rst),
        .start(start),
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product),
        .done(done)
    );

    assign LED = product;

endmodule

