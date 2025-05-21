`timescale 1ns / 1ps

module signed_serial_parallel_multiplier_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // 10ns = 100MHz

    // Testbench signals
    reg clk;
    reg rst;
    reg start;
    reg [7:0] a;
    reg [7:0] b;
    wire [15:0] product;
    wire done;
    
    // Expected result for verification
    reg [15:0] expected_product;
    integer errors = 0;
    integer test_count = 0;

    // Instantiate the Unit Under Test (UUT)
    signed_serial_parallel_multiplier uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .a(a),
        .b(b),
        .product(product),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Test case procedure
    task run_test;
        input [7:0] operand_a;
        input [7:0] operand_b;
        begin
            test_count = test_count + 1;
            a = operand_a;
            b = operand_b;
            expected_product = $signed(operand_a) * $signed(operand_b);
            
            // Start the multiplication
            @(posedge clk);
            start = 1;
            
            // Wait for done signal
            @(posedge done);
            @(posedge clk); // Allow one more clock cycle for stability
            
            // Verify result
            if (product !== expected_product) begin
                $display("ERROR: Test %0d failed!", test_count);
                $display("  a = %d (0x%h), b = %d (0x%h)", 
                         $signed(operand_a), operand_a, $signed(operand_b), operand_b);
                $display("  Expected: %d (0x%h), Got: %d (0x%h)", 
                         $signed(expected_product), expected_product, $signed(product), product);
                errors = errors + 1;
            end else begin
                $display("Test %0d passed: %d * %d = %d", 
                         test_count, $signed(operand_a), $signed(operand_b), $signed(product));
            end
            
            // Deassert start signal
            @(posedge clk);
            start = 0;
            
            // Wait for module to return to IDLE state
            repeat(3) @(posedge clk);
        end
    endtask

    // Test stimulus
    initial begin
        // Initialize Inputs
        rst = 1;
        start = 0;
        a = 0;
        b = 0;
        
        // Reset pulse
        #(CLK_PERIOD*2);
        rst = 0;
        #(CLK_PERIOD*2);
        
        // Test Case 1: Positive * Positive
        run_test(8'd10, 8'd15);       // 10 * 15 = 150
        
        // Test Case 2: Positive * Negative
        run_test(8'd5, 8'b11111101);  // 5 * (-3) = -15
        
        // Test Case 3: Negative * Positive
        run_test(8'b11111001, 8'd6);  // (-7) * 6 = -42
        
        // Test Case 4: Negative * Negative
        run_test(8'b11110111, 8'b11111100);  // (-9) * (-4) = 36
        
        // Test Case 5: Zero * Nonzero
        run_test(8'd0, 8'd25);        // 0 * 25 = 0
        
        // Test Case 6: Nonzero * Zero
        run_test(8'b11110100, 8'd0);  // (-12) * 0 = 0
        
        // Test Case 7: Largest positive numbers
        run_test(8'd127, 8'd127);     // 127 * 127 = 16129
        
        // Test Case 8: Smallest negative numbers
        run_test(8'b10000000, 8'b10000000);  // (-128) * (-128) = 16384
        
        // Test Case 9: Mixed extremes
        run_test(8'd127, 8'b10000000);  // 127 * (-128) = -16256
        
        // Display test summary
        #(CLK_PERIOD*5);
        $display("\n--- Test Summary ---");
        $display("Total tests: %0d", test_count);
        $display("Passed tests: %0d", test_count - errors);
        $display("Failed tests: %0d", errors);
        if (errors == 0)
            $display("All tests PASSED!");
        else
            $display("Some tests FAILED!");
        
        // End simulation
        #(CLK_PERIOD*2);
        $finish;
    end

endmodule