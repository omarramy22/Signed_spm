`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2025 09:39:42 AM
// Design Name: 
// Module Name: Muliplier
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
module serial_parallel_multiplier(input clk, rst, start, input [7:0] multiplicand, multiplier, output reg [15:0] product, output reg done);
    reg [7:0] A;
    reg [7:0] B;
    reg [15:0] P;
    reg [3:0] count;
    reg active;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            A <= 0;
            B <= 0;
            P <= 0;
            product <= 0;
            count <= 0;
            active <= 0;
            done <= 0;
        end else if (start && !active) begin
            A <= multiplicand;
            B <= multiplier;
            P <= 0;
            count <= 0;
            active <= 1;
            done <= 0;
        end else if (active) begin
            if (B[0]) begin
                P <= P + (A << count);
            end

            B <= B >> 1;
            
            count <= count + 1;
            
            if (count == 7) begin
                product <= B[0] ? P + (A << count) : P;
                active <= 0;
                done <= 1;
            end
        end
    end
endmodule