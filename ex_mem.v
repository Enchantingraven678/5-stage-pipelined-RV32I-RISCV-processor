`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2025 13:16:05
// Design Name: 
// Module Name: ex_mem
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


module ex_mem(
    input         clk,
    input         reset,

    // Inputs from EX stage
    input  [31:0] ex_alu_result,
    input         ex_zero,
    input  [4:0]  ex_rd,

    // Outputs to MEM stage
    output reg [31:0] mem_alu_result,
    output reg        mem_zero,
    output reg [4:0]  mem_rd
    );
      always @(posedge clk) begin
        if (reset) begin
            mem_alu_result <= 32'b0;
            mem_zero       <= 1'b0;
            mem_rd         <= 5'b0;
        end else begin
            mem_alu_result <= ex_alu_result;
            mem_zero       <= ex_zero;
            mem_rd         <= ex_rd;
        end
    end
endmodule
