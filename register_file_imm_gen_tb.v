module register_file_imm_gen_tb;

    // Các tín hi?u c?n thi?t
    reg clk;
    reg rst;
    reg reg_write_en;
    reg [4:0] read_addr1, read_addr2, write_addr;
    reg [31:0] write_data;
    wire [31:0] read_data1, read_data2;

    // ??i t??ng register file
    register_file DUT (
        .clk(clk),
        .rst(rst),
        .reg_write_en(reg_write_en),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // ??i t??ng Immediate Generator
    reg [31:0] instruction;
    wire [31:0] imm_extended;
    immediate_generator imm_gen (
        .instruction(instruction),
        .imm_extended(imm_extended)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // T?o tín hi?u clock xung
    end

    // Test các test case
    initial begin
        // Kh?i t?o tín hi?u
        clk = 0;
        rst = 0;
        reg_write_en = 0;
        write_addr = 5'b0;
        read_addr1 = 5'b0;
        read_addr2 = 5'b0;
        write_data = 32'b0;
        instruction = 32'b0;
        
        // Kh?i ??ng reset
        rst = 1;
        #10 rst = 0;
        
        // Test case 1: Reset và kh?i t?o
        $display("Test case 1: Reset và kh?i t?o");
        // Mong ??i: Sau khi reset, giá tr? c?a các thanh ghi và PC ??u b?ng 0.
        #10;
        
        // Test case 2: Ghi vào register và ??c l?i
        $display("Test case 2: Ghi vào register và ??c l?i");
        reg_write_en = 1;
        write_addr = 5'd2;
        write_data = 32'hA5A5A5A5;
        #10;  // Th?i gian ?? ghi
        reg_write_en = 0;
        read_addr1 = 5'd2;
        #10;  // Th?i gian ?? c?p nh?t giá tr?
        $display("read_data1 = %h", read_data1);  // Expected: read_data1 = 32'hA5A5A5A5
        
        // Test case 3: Ki?m tra l?nh ADDI (Immediate type, 12-bit immediate)
        instruction = 32'b00000000000100000000000010010011; // ADDI x1, x0, 1
        #10;
        $display("ADDI: instruction = %b, imm_extended = %b", instruction, imm_extended); // Expected: imm_extended = 00000000000000000000000000000001

        // Test case 4: Ki?m tra l?nh LUI (U-type, 20-bit immediate)
        instruction = 32'b0000000000010000000000000000110111; // LUI x1, 0x100000
        #10;
        $display("LUI: instruction = %b, imm_extended = %b", instruction, imm_extended); // Expected: imm_extended = 00000000010000000000000000000000

        // Test case 5: Ki?m tra l?nh BEQ (Branch type, 13-bit immediate)
        instruction = 32'b00000000000000000000000011100011; // BEQ x0, x1, offset
        #10;
        $display("BEQ: instruction = %b, imm_extended = %b", instruction, imm_extended); // Expected: imm_extended = 00000000000000000000100000000000

        // Test case 6: Ki?m tra l?nh JAL (J-type, 20-bit immediate)
        instruction = 32'b000000000000000000010000001010111111; // JAL x1, offset
        #10;
        $display("JAL: instruction = %b, imm_extended = %b", instruction, imm_extended); // Expected: imm_extended = 00000000000000000000000000000000

        // Test case 7: Ki?m tra l?nh STORE (S-type, 12-bit immediate)
        instruction = 32'b00000000000100000000000010100011; // SW x1, offset(x0)
        #10;
        $display("STORE: instruction = %b, imm_extended = %b", instruction, imm_extended); // Expected: imm_extended = 00000000000000000000000000000001

        // Test case 8: Ki?m tra l?nh JALR (I-type)
        instruction = 32'b00000000000100000000000011100111; // JALR x1, x0, offset
        #10;
        $display("JALR: instruction = %b, imm_extended = %b", instruction, imm_extended); // Expected: imm_extended = 00000000000000000000000000000001

        // Test case 9: Vi?t vào register và ki?m tra l?i
        $display("Test case 7: Vi?t vào register và ki?m tra l?i");
        reg_write_en = 1;
        write_addr = 5'd3;
        write_data = 32'hDEADBEEF;
        #10; 
        reg_write_en = 0;
        read_addr1 = 5'd3;
        #10;  
        $display("read_data1 = %h", read_data1);  // Expected: read_data1 = 32'hDEADBEEF

        $finish;
    end
endmodule

