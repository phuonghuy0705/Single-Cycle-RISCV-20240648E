module register_file (
    input  wire        clk,
    input  wire        rst,
    input  wire        reg_write_en, 
    input  wire [4:0]  read_addr1,  
    input  wire [4:0]  read_addr2,   
    input  wire [4:0]  write_addr,   
    input  wire [31:0] write_data,   
    output wire [31:0] read_data1,  
    output wire [31:0] read_data2   
);

    reg [31:0] registers [0:31]; 

    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else begin
            if (reg_write_en) begin
                if (write_addr == 5'b00000) begin
                    $display("[WARNING] Khong duoc ghi vao thanh ghi x0 (Dia chi 0)!!!", write_data);
                end else begin
                    registers[write_addr] <= write_data;
                end
            end
        end
    end

    assign read_data1 = (read_addr1 == 5'b00000) ? 32'b0 : registers[read_addr1];
    assign read_data2 = (read_addr2 == 5'b00000) ? 32'b0 : registers[read_addr2];

endmodule
