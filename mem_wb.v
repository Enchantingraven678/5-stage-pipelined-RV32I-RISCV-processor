module mem_wb (
    input         clk,
    input         reset,

    input  [31:0] mem_data,
    input  [4:0]  mem_rd,

    output reg [31:0] wb_data,
    output reg [4:0]  wb_rd
);

    always @(posedge clk) begin
        if (reset) begin
            wb_data <= 32'b0;
            wb_rd   <= 5'b0;
        end else begin
            wb_data <= mem_data;
            wb_rd   <= mem_rd;
        end
    end

endmodule