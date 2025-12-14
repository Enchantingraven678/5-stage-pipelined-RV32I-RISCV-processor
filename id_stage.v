`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.12.2025 15:59:29
// Design Name: 
// Module Name: id_stage
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


module id_stage(
 input         clk,
    input         reset,

    input  [31:0] if_pc,
    input  [31:0] if_instr,

    input         wb_reg_write,
    input  [4:0]  wb_rd,
    input  [31:0] wb_wd,

    output [31:0] id_pc,
    output [31:0] id_rd1,
    output [31:0] id_rd2,
    output [31:0] id_imm,
    output [4:0]  id_rs1,
    output [4:0]  id_rs2,
    output [4:0]  id_rd,
    output [6:0]  id_opcode,
    output [2:0]  id_funct3,
    output [6:0]  id_funct7

    );
     wire [31:0] instr;

    if_id if_id_inst (
        .clk      (clk),
        .reset    (reset),
        .pc_in    (if_pc),
        .instr_in (if_instr),
        .pc_out   (id_pc),
        .instr_out(instr)
    );

    instr_decoder decoder (
        .instr  (instr),
        .opcode (id_opcode),
        .rd     (id_rd),
        .funct3 (id_funct3),
        .rs1    (id_rs1),
        .rs2    (id_rs2),
        .funct7 (id_funct7)
    );

    regfile regfile_inst (
        .clk       (clk),
        .reg_write (wb_reg_write),
        .rs1       (id_rs1),
        .rs2       (id_rs2),
        .rd        (wb_rd),
        .wd        (wb_wd),
        .rd1       (id_rd1),
        .rd2       (id_rd2)
    );

    imm_gen imm_gen_inst (
        .instr  (instr),
        
        .imm    (id_imm)
    );

endmodule

