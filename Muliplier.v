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


module serial_parallel_multiplier(input clk, input rst, input start, input [7:0] A, input B_bit, output reg [15:0] product, output reg done);

    reg [2:0] bit_count;
    reg [7:0] multiplicand;
    reg [15:0] temp_product;
    reg [15:0] shifted_A;
    reg busy;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            product <= 0;
            temp_product <= 0;
            bit_count <= 0;
            multiplicand <= 0;
            busy <= 0;
            done <= 0;
        end else begin
            if (start && !busy) begin
                multiplicand <= A;
                temp_product <= 0;
                bit_count <= 0;
                busy <= 1;
                done <= 0;
            end else if (busy) begin
                if (B_bit)
                    temp_product <= temp_product + (multiplicand << bit_count);

                bit_count <= bit_count + 1;

                if (bit_count == 3'd7) begin
                    busy <= 0;
                    product <= temp_product + (B_bit ? (multiplicand << 7) : 0);
                    done <= 1;
                end
            end else begin
                done <= 0;
            end
        end
    end
endmodule

