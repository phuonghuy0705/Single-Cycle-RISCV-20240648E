module instruction_memory #(
    parameter MEM_DEPTH = 256 
) (
    input  wire [31:0] address, 
    output wire [31:0] instruction 
);

    reg [31:0] mem [0:MEM_DEPTH-1];

    initial begin
       $readmemh("program.hex", mem);
    end

    assign instruction = mem[address >> 2];

endmodule