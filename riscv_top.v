`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2025 14:04:38
// Design Name: 
// Module Name: riscv_top
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


module riscv_top (
    input clk,
    input reset
);

    // ======================
    // IF stage
    // ======================
    wire [31:0] if_pc;
    wire [31:0] if_instr;

    if_stage if_stage_inst (
        .clk   (clk),
        .reset (reset),
        .pc    (if_pc),
        .instr (if_instr)
    );

    // ======================
    // ID stage
    // ======================
    wire [31:0] id_pc, id_rd1, id_rd2, id_imm;
    wire [4:0]  id_rs1, id_rs2, id_rd;
    wire [6:0]  id_opcode;
    wire [2:0]  id_funct3;
    wire [6:0]  id_funct7;

    // WB → ID feedback
    wire        wb_reg_write;
    wire [31:0] wb_wd;
    wire [4:0]  wb_rd;

    id_stage id_stage_inst (
        .clk          (clk),
        .reset        (reset),
        .if_pc        (if_pc),
        .if_instr     (if_instr),
        .wb_reg_write (wb_reg_write),
        .wb_rd        (wb_rd),
        .wb_wd        (wb_wd),
        .id_pc        (id_pc),
        .id_rd1       (id_rd1),
        .id_rd2       (id_rd2),
        .id_imm       (id_imm),
        .id_rs1       (id_rs1),
        .id_rs2       (id_rs2),
        .id_rd        (id_rd),
        .id_opcode    (id_opcode),
        .id_funct3    (id_funct3),
        .id_funct7    (id_funct7)
    );

    // ======================
    // ID / EX pipeline
    // ======================
    wire [31:0] ex_rd1, ex_rd2, ex_imm;
    wire [4:0]  ex_rd;
    wire [6:0]  ex_opcode;
    wire [2:0]  ex_funct3;
    wire [6:0]  ex_funct7;

    id_ex id_ex_inst (
        .clk        (clk),
        .reset      (reset),
        .id_pc      (id_pc),
        .id_rd1     (id_rd1),
        .id_rd2     (id_rd2),
        .id_imm     (id_imm),
        .id_rs1     (id_rs1),
        .id_rs2     (id_rs2),
        .id_rd      (id_rd),
        .id_opcode  (id_opcode),
        .id_funct3  (id_funct3),
        .id_funct7  (id_funct7),
        .ex_rd1     (ex_rd1),
        .ex_rd2     (ex_rd2),
        .ex_imm     (ex_imm),
        .ex_rd      (ex_rd),
        .ex_opcode  (ex_opcode),
        .ex_funct3  (ex_funct3),
        .ex_funct7  (ex_funct7)
    );

    // ======================
    // EX stage
    // ======================
    wire [31:0] ex_alu_result;
    wire        ex_zero;

    ex_stage ex_stage_inst (
        .ex_rd1     (ex_rd1),
        .ex_rd2     (ex_rd2),
        .ex_imm     (ex_imm),
        .ex_opcode  (ex_opcode),
        .ex_funct3  (ex_funct3),
        .ex_funct7  (ex_funct7),
        .alu_result (ex_alu_result),
        .zero       (ex_zero)
    );

    // ======================
    // EX / MEM pipeline
    // ======================
    wire [31:0] mem_alu_result;
    wire [4:0]  mem_rd;

    ex_mem ex_mem_inst (
        .clk            (clk),
        .reset          (reset),
        .ex_alu_result  (ex_alu_result),
        .ex_zero        (ex_zero),
        .ex_rd          (ex_rd),
        .mem_alu_result (mem_alu_result),
        .mem_zero       (),
        .mem_rd         (mem_rd)
    );

    // ======================
    // MEM stage (NO rd logic here)
    // ======================
    wire [31:0] mem_data;

 mem_stage mem_stage_inst (
    .mem_alu_result (mem_alu_result),
    .mem_data       (mem_data)
);


    // ======================
    // MEM / WB pipeline
    // ======================
    wire [31:0] wb_data;

    mem_wb mem_wb_inst (
        .clk      (clk),
        .reset    (reset),
        .mem_data (mem_data),
        .mem_rd   (mem_rd),
        .wb_data  (wb_data),
        .wb_rd    (wb_rd)
    );

    // ======================
    // WB stage (NO rd output)
    // ======================
    wb_stage wb_stage_inst (
        .wb_data_in (wb_data),
        .wb_rd_in   (wb_rd),
        .reg_write  (wb_reg_write),
        .wb_wd      (wb_wd)
    );

    // ======================
    // Register File
    // ======================
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

endmodule




