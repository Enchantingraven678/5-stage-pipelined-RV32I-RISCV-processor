`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2025 10:09:26
// Design Name: 
// Module Name: ALU
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

module alu (
    input  [31:0] a,
    input  [31:0] b,
    input  [3:0]  alu_ctrl,
    output reg [31:0] result,
    output        zero
);

    always @(*) begin
        case (alu_ctrl)
            4'b0000: result = a + b;                     // ADD
            4'b0001: result = a - b;                     // SUB
            4'b0010: result = a & b;                     // AND
            4'b0011: result = a | b;                     // OR
            4'b0100: result = a ^ b;                     // XOR
            4'b0101: result = ($signed(a) < $signed(b)); // SLT
            4'b0110: result = a << b[4:0];               // SLL
            4'b0111: result = a >> b[4:0];               // SRL
            default: result = 32'b0;
        endcase
    end

    assign zero = (result == 32'b0);

endmodule

