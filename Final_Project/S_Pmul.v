`timescale 1ns / 1ps

// Signed serial-parallel multiplier using CSA approach
module signed_serial_parallel_multiplier (
    input  wire clk, rst, start, input  wire [7:0] a, input  wire [7:0] b, 
    output reg  [15:0] product, output reg  done);
    // Internal signals
    wire [7:0] a_tc, b_tc;
    reg  sign_result;
    reg [7:0]  multiplicand;
    reg [7:0]  multiplier;
    
    reg [15:0] partial_sum;
    reg [15:0] partial_carry;
    wire [15:0] current_pp;
    wire [15:0] csa_sum_out;
    wire [15:0] csa_carry_out;
    wire [15:0] final_result;
    reg [3:0]  bit_count;
    
    twos_complement #(.N(8)) tc_a (.in(a),.out(a_tc));
    twos_complement #(.N(8)) tc_b (.in(b),.out(b_tc));
    
    assign current_pp = multiplier[0] ? ({8'b0, multiplicand} << bit_count) : 16'b0;
    
    // Carry-Save Adder instance
    carry_save_adder csa (.a(partial_sum), .b({partial_carry[14:0], 1'b0}), // Left shift carry input
        .c_in(current_pp), .sum(csa_sum_out), .carry(csa_carry_out));
    
    // Final Carry-Propagate Adder
    carry_propagate_adder cpa (.sum(partial_sum), .carry(partial_carry), .result(final_result));
    
    // FSM states
    parameter IDLE = 3'd0,
              INIT = 3'd1,
              MULT = 3'd2,
              FINAL = 3'd3,
              DONE = 3'd4;
    reg [2:0] state;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            done <= 0;
            product <= 0;
            partial_sum <= 0;
            partial_carry <= 0;
            bit_count <= 0;
            multiplicand <= 0;
            multiplier <= 0;
            sign_result <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    //done <= 0;
                    if (start) begin
                        state <= INIT;
                    end
                end
                
                INIT: begin
                    sign_result <= a[7] ^ b[7];
                    
                    // Get absolute values, handle special case of -128
                    if (a == 8'b10000000) // -128 in two's complement
                        multiplicand <= 8'b10000000; // Keep as is, will be handled correctly
                    else
                        multiplicand <= a[7] ? a_tc : a;
                    
                    if (b == 8'b10000000) // -128 in two's complement  
                        multiplier <= 8'b10000000; // Keep as is, will be handled correctly
                    else
                        multiplier <= b[7] ? b_tc : b;
                    
                    partial_sum <= 0;
                    partial_carry <= 0;
                    bit_count <= 0;
                    state <= MULT;
                end
                
                MULT: begin
                    if (bit_count < 8) begin
                        partial_sum <= csa_sum_out;
                        partial_carry <= csa_carry_out;
                        
                        multiplier <= multiplier >> 1;
                        bit_count <= bit_count + 1;
                    end
                    else begin
                        state <= FINAL;
                    end
                end
                
                FINAL: begin
                    if (sign_result)
                        product <= (~final_result) + 1'b1; // Two's complement of result
                    else
                        product <= final_result;
                        
                    state <= DONE;
                end
                
                DONE: begin
                    done <= 1;
                    if (!start)
                        state <= IDLE;
                end
            endcase
        end
    end
endmodule