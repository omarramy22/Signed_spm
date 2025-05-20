`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 02:23:55 PM
// Design Name: 
// Module Name: Binary_To_Seg
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
module Binary_To_Seg(
 input clk, rst, button1, button2, [15:0] bin, 
 output [6:0] display ,[3:0] en
    );
    
    reg [1:0] state, nextstate;
  

    wire clk2;
    wire clk_sec;
    wire b1_out, b2_out;
    
    wire [1:0]selector;
    
    reg [3:0]num;

     clockDivider c(.clk(clk), .rst(rst), .clk_out(clk2));
     
     
     PushButton_Detector B_L(.clk(clk2), .w(button1), .z(b1_out)); //Left
     PushButton_Detector B_R(.clk(clk2), .w(button2), .z(b2_out)); //Right 
     
     wire [18:0] bcd;
     wire [14:0] newBin;
     
 assign newBin = (bin[15] == 1) ? (~bin[14:0] + 1'b1) : bin[14:0];
     
      binary_to_bcd_DD b(.bin(newBin), .bcd(bcd));
      
      clockDivider #(250000)  cd(.clk(clk), .rst(rst), .clk_out(clk_sec));

      counterModN #(2,4) TwoCounter(.clk(clk_sec), .En(1), .reset(rst), .count(selector));

      seg7 displayer(.en(selector),.num2(num),.anode_active(en), .segments(display));

        
        parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
        
        always @(*) begin
    nextstate = state;  
    case(state)
     
        A: if(b2_out == 1)
            nextstate = B;

       
         
       B: if(b2_out == 1)
            nextstate = C;
            else if(b1_out == 1)
            nextstate = A;
           
        C: if(b2_out == 1)
            nextstate = C;
            else if(b1_out == 1)
            nextstate = B;
        
        default: nextstate = A;
        
    endcase
  end
 
always @(posedge clk2, posedge rst) begin
if(rst) 
    state <= A;
else
    state <= nextstate;

end


      always @ (*) begin

       case(selector)
        2'b00:
        if(state == A) 
         num = bcd[11:8];
        else if(state == B)
        num = bcd[7:4];
        else if(state == C)
        num = bcd[3:0];
        2'b01:
         if(state == A) 
         num = bcd[15:12];
        else if(state == B)
        num = bcd[11:8];
        else if(state == C)
        num = bcd[7:4];
        2'b10:
        if(state == A) 
         num = bcd[18:16];
        else if(state == B)
        num = bcd[15:12];
        else if(state == C)
        num = bcd[11:8];
        2'b11:
         num = (bin[15] == 1') ? (4'b1111) : 4'b0000;
        default: num = 4'b0000;
        endcase
        end


        






endmodule

