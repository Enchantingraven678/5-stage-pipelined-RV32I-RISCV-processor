`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.12.2025 13:25:37
// Design Name: 
// Module Name: if_stage
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


module if_stage (
    input         clk,
    input         reset,
    output [31:0] pc,
    output [31:0] instr
);

    wire [31:0] pc_next;
    wire [31:0] pc_plus4;

    // -----------------------------
    // Program Counter
    // -----------------------------
    pc pc_inst (
        .clk     (clk),
        .reset   (reset),
        .pc_next (pc_next),
        .pc      (pc)
    );

    // -----------------------------
    // PC + 4 Adder
    // -----------------------------
    pc_adder pc_adder_inst (
        .pc       (pc),
        .pc_plus4 (pc_plus4)
    );

    // -----------------------------
    // Instruction Memory
    // -----------------------------
    instr_mem instr_mem_inst (
        .addr  (pc),
        .instr (instr)
    );

    // -----------------------------
    // Next PC selection
    // (for now: always PC + 4)
    // -----------------------------
    assign pc_next = pc_plus4;

endmodule

