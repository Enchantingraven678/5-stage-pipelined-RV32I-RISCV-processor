`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2025 12:37:23
// Design Name: 
// Module Name: ex_stage
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


module ex_stage(
    input  [31:0] ex_rd1,
    input  [31:0] ex_rd2,
    input  [31:0] ex_imm,
    input  [6:0]  ex_opcode,
    input  [2:0]  ex_funct3,
    input  [6:0]  ex_funct7,

    output [31:0] alu_result,
    output        zero

    );
      wire [31:0] alu_b;
    wire [3:0]  alu_ctrl;

    // Operand select: immediate for I-type
    assign alu_b = (ex_opcode == 7'b0010011) ? ex_imm : ex_rd2;

    // ALU control
    alu_ctrl alu_ctrl_inst (
        .opcode   (ex_opcode),
        .funct3   (ex_funct3),
        .funct7   (ex_funct7),
        .alu_ctrl (alu_ctrl)
    );

    // ALU
    alu alu_inst (
        .a        (ex_rd1),
        .b        (alu_b),
        .alu_ctrl (alu_ctrl),
        .result   (alu_result),
        .zero     (zero)
    );
endmodule
