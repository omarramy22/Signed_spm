`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 02:27:48 PM
// Design Name: 
// Module Name: PushButton_Detector
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

module PushButton_Detector(
input clk, w,output z
    );
    
 wire clk2;
 wire d_out;
 wire s_out;
 
 assign clk2 = clk;
 
 debouncer d(.clk(clk2), .rst(0), .in(w), .out(d_out));
 
 synch s(.clk(clk2), .D1(d_out), .Q2(s_out));
 
 rising_edge r(.clk(clk2), .rst(0), .w(s_out), .z(z));
 
endmodule

