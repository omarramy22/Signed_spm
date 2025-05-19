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
module serial_parallel_multiplier(input clk, rst, start, input signed [7:0] multiplicand, multiplier, output reg signed [15:0] product,output reg done);
    reg signed [7:0] A;
    reg signed [7:0] B;
    reg signed [15:0] P;
    reg [3:0] count;
    reg active;
    reg B_sign;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            A <= 0;
            B <= 0;
            P <= 0;
            product <= 0;
            count <= 0;
            active <= 0;
            done <= 0;
            B_sign <= 0;
        end else if (start && !active) begin
            B_sign <= multiplier[7];
            A <= multiplicand[7] ? -multiplicand : multiplicand;
            B <= multiplier[7] ? -multiplier : multiplier;
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
                P <= B[0] ? P + (A << count) : P;
                
                if (multiplicand[7] ^ B_sign) begin
                    product <= -(B[0] ? P + (A << count) : P);
                end else begin
                    product <= B[0] ? P + (A << count) : P;
                end
                active <= 0;
                done <= 1;
            end
        end
    end
endmodule