`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2025 12:10:51
// Design Name: 
// Module Name: id_ex
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


module id_ex(
 input         clk,
    input         reset,
    input  [31:0] id_pc,
    input  [31:0] id_rd1,
    input  [31:0] id_rd2,
    input  [31:0] id_imm,
    input  [4:0]  id_rs1,
    input  [4:0]  id_rs2,
    input  [4:0]  id_rd,
    input  [6:0]  id_opcode,
    input  [2:0]  id_funct3,
    input  [6:0]  id_funct7,
    output reg [31:0] ex_pc,
    output reg [31:0] ex_rd1,
    output reg [31:0] ex_rd2,
    output reg [31:0] ex_imm,
    output reg [4:0]  ex_rs1,
    output reg [4:0]  ex_rs2,
    output reg [4:0]  ex_rd,
    output reg [6:0]  ex_opcode,
    output reg [2:0]  ex_funct3,
    output reg [6:0]  ex_funct7

    );
    always @(posedge clk) begin
        if (reset) begin
            ex_pc      <= 32'b0;
            ex_rd1     <= 32'b0;
            ex_rd2     <= 32'b0;
            ex_imm     <= 32'b0;
            ex_rs1     <= 5'b0;
            ex_rs2     <= 5'b0;
            ex_rd      <= 5'b0;
            ex_opcode  <= 7'b0;
            ex_funct3  <= 3'b0;
            ex_funct7  <= 7'b0;
        end else begin
            ex_pc      <= id_pc;
            ex_rd1     <= id_rd1;
            ex_rd2     <= id_rd2;
            ex_imm     <= id_imm;
            ex_rs1     <= id_rs1;
            ex_rs2     <= id_rs2;
            ex_rd      <= id_rd;
            ex_opcode  <= id_opcode;
            ex_funct3  <= id_funct3;
            ex_funct7  <= id_funct7;
        end
    end
endmodule
