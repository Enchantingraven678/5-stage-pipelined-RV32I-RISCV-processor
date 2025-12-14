`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.12.2025 11:29:06
// Design Name: 
// Module Name: tb_pc
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


module tb_pc;
 reg         clk;
    reg         reset;
    reg  [31:0] pc_next;
    wire [31:0] pc;

    // Instantiate PC
    pc dut (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc(pc)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 10 ns period
    end
     initial begin
        reset = 1;
        pc_next = 32'd0;

        #12;
        reset = 0;

        // Simulate PC increment
        pc_next = 32'd4;
        #10;
        pc_next = 32'd8;
        #10;
        pc_next = 32'd12;
        #10;

        $finish;
    end
endmodule
