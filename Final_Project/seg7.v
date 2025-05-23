`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 02:28:23 PM
// Design Name: 
// Module Name: seg7
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



module seg7(input[1:0] en,
input [3:0] num2,
output reg [6:0] segments,
output reg [3:0] anode_active);



always @ (*) begin

case(en)
2'b00: anode_active = 4'b1110;
2'b01: anode_active = 4'b1101;
2'b10: anode_active = 4'b1011;
2'b11: anode_active = 4'b0111;


default: anode_active = 4'b1111;
endcase

case(num2)
4'b0000: segments = 7'b0000001;
4'b0001: segments = 7'b1001111;
4'b0010: segments = 7'b0010010;
4'b0011: segments = 7'b0000110;
4'b0100: segments = 7'b1001100;
4'b0101: segments = 7'b0100100;
4'b0110: segments = 7'b0100000;
4'b0111: segments = 7'b0001111;
4'b1000: segments = 7'b0000000;
4'b1001: segments = 7'b0000100;

4'b1010: segments = 7'b0001000;
4'b1011: segments = 7'b1100000;
4'b1100: segments = 7'b0110001;
4'b1101: segments = 7'b1000010;
4'b1110: segments = 7'b0110000;
4'b1111: segments = 7'b1111110;

default: segments = 7'b1111111;

endcase
end
endmodule
