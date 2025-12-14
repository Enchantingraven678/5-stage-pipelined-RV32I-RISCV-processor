`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.12.2025 15:26:13
// Design Name: 
// Module Name: tb_regfile
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


module tb_regfile;
    reg         clk;
    reg         reg_write;
    reg  [4:0]  rs1, rs2, rd;
    reg  [31:0] wd;
    wire [31:0] rd1, rd2;

    regfile dut (
        .clk(clk),
        .reg_write(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Write x1 = 10
        reg_write = 1;
        rd = 5'd1;
        wd = 32'd10;
        rs1 = 5'd0;
        rs2 = 5'd0;
        #10;

        // Write x2 = 20
        rd = 5'd2;
        wd = 32'd20;
        #10;

        // Read x1 and x2
        reg_write = 0;
        rs1 = 5'd1;
        rs2 = 5'd2;
        #10;

        // Try writing x0 (should fail)
        reg_write = 1;
        rd = 5'd0;
        wd = 32'd999;
        #10;

        // Read x0
        reg_write = 0;
        rs1 = 5'd0;
        #10;

        $finish;
    end

endmodule

