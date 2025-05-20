`timescale 1ns / 1ps

module Full_SPM(
input clk, rst, start, button1, button2, input signed [7:0] multiplicand, input signed [7:0] multiplier, output done, output [6:0] display ,output [3:0] en);
    
 

 wire[15:0] prod;
    
signed_serial_parallel_multiplier s(clk, rst, start, multiplicand, multiplier, prod, done);
 
 
 Binary_To_Seg b(clk, rst, button1, button2, prod, display, en);
 

 endmodule