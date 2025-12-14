module instr_mem (
    input  [31:0] addr,
    output [31:0] instr
);

    // ✅ THIS is a MEMORY (array)
    reg [31:0] mem [0:255];
   
    integer i;
    // Load program
    initial begin
    // Fill memory with NOPs
    for (i = 0; i < 256; i = i + 1)
        mem[i] = 32'h00000013;
        $readmemh("C:/Users/sagni/Desktop/program.hex", mem);
    end

    // Word-aligned access
    assign instr = mem[addr[9:2]];

endmodule