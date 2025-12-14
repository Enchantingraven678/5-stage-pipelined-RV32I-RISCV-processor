`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2025 14:16:27
// Design Name: 
// Module Name: tb_riscv_top
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


module tb_riscv_top;
reg clk;
    reg reset;

    // DUT
    riscv_top dut (
        .clk   (clk),
        .reset (reset)
    );

  
    // Clock generation (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        reset = 1;
        #20;
        reset = 0;

        // Let pipeline run
        #60;

        $display("\n--- RISC-V PIPELINE TEST ---");
        $display("x1 register value = %0d",
                 dut.id_stage_inst.regfile_inst.regs[1]);

        if (dut.id_stage_inst.regfile_inst.regs[1] == 32'd5)
            $display("✅ TEST PASSED: ADDI executed correctly");
        else
            $display("❌ TEST FAILED: Wrong register value");

        $display("-----------------------------\n");

        $finish;
    end

endmodule

