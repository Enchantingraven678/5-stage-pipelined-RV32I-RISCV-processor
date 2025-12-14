`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.12.2025 16:09:09
// Design Name: 
// Module Name: tb_id_stage
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


module tb_id_stage;
 // Clock / reset
    reg clk;
    reg reset;

    // IF → ID inputs
    reg  [31:0] if_pc;
    reg  [31:0] if_instr;

    // WB → ID inputs
    reg         wb_reg_write;
    reg  [4:0]  wb_rd;
    reg  [31:0] wb_wd;

    // ID stage outputs
    wire [31:0] id_pc;
    wire [31:0] id_rd1;
    wire [31:0] id_rd2;
    wire [31:0] id_imm;
    wire [4:0]  id_rs1;
    wire [4:0]  id_rs2;
    wire [4:0]  id_rd;
    wire [6:0]  id_opcode;
    wire [2:0]  id_funct3;
    wire [6:0]  id_funct7;

    // DUT
    id_stage dut (
        .clk(clk),
        .reset(reset),
        .if_pc(if_pc),
        .if_instr(if_instr),
        .wb_reg_write(wb_reg_write),
        .wb_rd(wb_rd),
        .wb_wd(wb_wd),
        .id_pc(id_pc),
        .id_rd1(id_rd1),
        .id_rd2(id_rd2),
        .id_imm(id_imm),
        .id_rs1(id_rs1),
        .id_rs2(id_rs2),
        .id_rd(id_rd),
        .id_opcode(id_opcode),
        .id_funct3(id_funct3),
        .id_funct7(id_funct7)
    );

    // --------------------------------
    // Clock generation (100 MHz)
    // --------------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // --------------------------------
    // Test sequence
    // --------------------------------
    initial begin
        // Initial state
        reset = 1;
        if_pc = 0;
        if_instr = 32'b0;
        wb_reg_write = 0;
        wb_rd = 0;
        wb_wd = 0;

        // Apply reset
        #12;
        reset = 0;

        // --------------------------------
        // Cycle 1: addi x1, x0, 5
        // Machine code: 00500093
        // --------------------------------
        if_instr = 32'h00500093;
        if_pc    = 32'h00000000;

        // Wait for IF/ID register
        @(posedge clk);

        // --------------------------------
        // Cycle 2: emulate WB (write x1 = 5)
        // --------------------------------
        wb_reg_write = 1;
        wb_rd = 5'd1;
        wb_wd = 32'd5;

        @(posedge clk);
        wb_reg_write = 0;

        // --------------------------------
        // Cycle 3: read back x1
        // --------------------------------
        if_instr = 32'h00000013;  // nop
        if_pc    = 32'h00000004;

        @(posedge clk);

        // --------------------------------
        // Display results
        // --------------------------------
        $display("ID STAGE CHECK:");
        $display("rs1      = %0d (expected 0)", id_rs1);
        $display("rd       = %0d (expected 1)", id_rd);
        $display("imm      = %0d (expected 5)", id_imm);
        $display("rd1 data = %0d (expected 5)", id_rd1);

        // End simulation
        #10;
        $finish;
    end
endmodule
