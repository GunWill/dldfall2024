`timescale 1ns/1ps
module stimulus;

    parameter MSG_SIZE = 120;   

    // Signals
    logic [MSG_SIZE-1:0] message;   
    logic [255:0] hashed;
    logic [255:0] golden;

    logic clk, reset, start;
    logic [31:0] errors;

    // Instantiate DUT
    top #(MSG_SIZE, 512) dut (
        .message(message),
        .clk(clk),
        .reset(reset),
        .start(start),
        .hashed(hashed)
    );

    // Initialize signals
    initial begin
        clk = 1'b0;
        reset = 1'b1;
        start = 1'b0;
        errors = 32'b0;
        #10 reset = 1'b0; // Deassert reset after 10ns
    end

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    // Test procedure
    initial begin
        // Test vector 1: "Hello, SHA-256!"
        wait_for_done(
            120'h48656c6c6f2c205348412d32353621, // Message
            256'hd0e8b8f11c98f369016eb2ed3c541e1f01382f9d5b3104c9ffd06b6175a46271 // Expected hash
        );

        // Test vector 2: "Onomonopea!!!!!"
        wait_for_done(
            120'h4f6e6f6d6f6e6f7065612121212121,
            256'ha9981acfc95bdf6639b1179a70958217cc691d7fe12cac70d02406798a4af676
        );

        // Test vector 3: "SassySasquatch!"
        wait_for_done(
            120'h536173737953617371756174636821,
            256'h6c71746ce552f1640cfb0eaf52cef686c9e45e4cdd7150def1a5da11ee7a3b25
        );

        // Test vector 4: "LiloAndStitch!!"
        wait_for_done(
            120'h4c696c6f416e645374697463682121,
            256'h5ed99fcb5cda7939fd089fe1435860638fe1af435e4d1710f705bdcb743f6262
        );

        // Test vector 5: "OSU Rocks !!!!!!"
        wait_for_done(
            120'h4f535520526f636b73212121212121,
            256'hbad9a6c7eff030cb83b1e45e78cae5c7b29df3c1c035424fb592f93877357828
        );

        // Display final results
        $display("Total Errors: %d", errors);
        $finish;
    end

    // Task to apply test vectors and wait for hashing to complete
    task wait_for_done(input logic [MSG_SIZE-1:0] msg, input logic [255:0] expected_hash);
        begin
            message = msg;
            golden = expected_hash;
            start = 1'b1; // Start hashing
            @(posedge clk); // Wait for one clock cycle
            start = 1'b0;

            // Wait for done signal to be asserted
            wait (dut.hashed == expected_hash);
            
            // Verify the result
            @(negedge clk); // On the falling edge, check result
            if (hashed !== golden) begin
                $display("Test failed for message: %h", message);
                $display("Expected: %h", golden);
                $display("Got:      %h", hashed);
                errors = errors + 1;
            end else begin
                $display("Test passed for message: %h", message);
            end
        end
    endtask

endmodule
