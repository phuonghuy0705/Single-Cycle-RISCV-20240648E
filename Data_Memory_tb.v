
`timescale 1ns / 1ps

module data_memory_tb;
    reg clk;
    reg mem_read_en;
    reg mem_write_en;
    reg [31:0] address;
    reg [31:0] write_data;
    wire [31:0] read_data;

    // Instantiate the Data Memory module
    data_memory #(.DATA_MEM_DEPTH(256)) uut (
        .clk(clk),
        .mem_read_en(mem_read_en),
        .mem_write_en(mem_write_en),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Generate clock signal
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        mem_read_en = 0;
        mem_write_en = 0;
        address = 32'b0;
        write_data = 32'b0;

        // Test 1: Check initial memory values (should be 0)
        #10;
        mem_read_en = 1;
        address = 32'h00000004;
        #10;
        $display("Initial Read at 0x04: %h", read_data); // Expected: 00000000

        // Test 2: Write data to memory
        mem_read_en = 0;
        mem_write_en = 1;
        address = 32'h00000004;
        write_data = 32'hDEADBEEF;
        #10;
        mem_write_en = 0;

        // Test 3: Read data back from memory
        mem_read_en = 1;
        #10;
        $display("Read after Write at 0x04: %h", read_data); // Expected: DEADBEEF

        // Test 4: Try to read from an address not written to
        address = 32'h00000008;
        #10;
        $display("Read at 0x08 (not written): %h", read_data); // Expected: 00000000

        // Test 5: Disable read enable and check the output
        mem_read_en = 0;
        #10;
        $display("Read with mem_read_en disabled: %h", read_data); // Expected: 00000000

        // End of simulation
        $finish;
    end
endmodule
