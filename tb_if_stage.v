`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.12.2025 13:28:50
// Design Name: 
// Module Name: tb_if_stage
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

module tb_if_stage;

    reg clk;
    reg reset;
    wire [31:0] pc;
    wire [31:0] instr;

    // IF stage DUT
    if_stage dut (
        .clk   (clk),
        .reset (reset),
        .pc    (pc),
        .instr (instr)
    );

    // Clock generation (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        reset = 1;
        #12;
        reset = 0;

        #100;   // let it fetch few instructions
        $finish;
    end

endmodule