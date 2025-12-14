`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2025 14:09:32
// Design Name: 
// Module Name: wb_stage
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


module wb_stage(
input  [31:0] wb_data_in,
    input  [4:0]  wb_rd_in,

    output        reg_write,
    output [31:0] wb_wd,
    output [4:0]  wb_rd

    );
     // For now: always write back (ADD / ADDI)
    assign reg_write = (wb_rd_in != 5'd0);
    assign wb_wd     = wb_data_in;
    assign wb_rd     = wb_rd_in;
     // ✅ FORCE write-back for non-zero rd
    assign reg_write = (wb_rd_in != 5'd0);
endmodule
