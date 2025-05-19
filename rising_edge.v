`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 02:27:17 PM
// Design Name: 
// Module Name: rising_edge
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



module rising_edge(
input clk, rst, w, output z
    );
    
reg [1:0] state, nextstate;

parameter [1:0] A = 2'b00, B = 2'b01, C=2'b10;



always @ (*) begin

case(state)

A: nextstate = (w == 1) ? B : A;
B: nextstate = (w == 1) ? C : A;
C: nextstate = (w == 1) ? C : A;
default: nextstate = A;

endcase
    end
 
always @ (posedge clk) begin
if(rst) state <= A;

else
state <=nextstate;

end

assign z = (rst == 0 && state == B);

endmodule

