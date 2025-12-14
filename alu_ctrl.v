`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2025 10:13:08
// Design Name: 
// Module Name: alu_ctrl
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


module alu_ctrl(
    input  [6:0] opcode,
    input  [2:0] funct3,
    input  [6:0] funct7,
    output reg [3:0] alu_ctrl

    );
     always @(*) begin
        case (opcode)

            // R-type instructions
            7'b0110011: begin
                case ({funct7, funct3})
                    10'b0000000_000: alu_ctrl = 4'b0000; // ADD
                    10'b0100000_000: alu_ctrl = 4'b0001; // SUB
                    10'b0000000_111: alu_ctrl = 4'b0010; // AND
                    10'b0000000_110: alu_ctrl = 4'b0011; // OR
                    10'b0000000_100: alu_ctrl = 4'b0100; // XOR
                    10'b0000000_010: alu_ctrl = 4'b0101; // SLT
                    default:          alu_ctrl = 4'b0000;
                endcase
            end

            // I-type arithmetic
            7'b0010011: begin
                case (funct3)
                    3'b000: alu_ctrl = 4'b0000; // ADDI
                    3'b111: alu_ctrl = 4'b0010; // ANDI
                    3'b110: alu_ctrl = 4'b0011; // ORI
                    3'b100: alu_ctrl = 4'b0100; // XORI
                    default: alu_ctrl = 4'b0000;
                endcase
            end

            default:
                alu_ctrl = 4'b0000;
        endcase
    end

endmodule

