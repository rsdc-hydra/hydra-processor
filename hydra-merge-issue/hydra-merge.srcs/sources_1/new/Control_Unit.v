`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2023 10:14:58 PM
// Design Name: 
// Module Name: Control_unit
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

module Control_Unit(
    input[6:0] opcode,
    output reg[1:0] alu_op,
    output reg alu_src,mem_to_reg,reg_write,mem_read,mem_write,branch,jump
    );
always @(*)
begin
    case(opcode)
        7'b0110011: // R-Type 
        begin
            alu_src = 1'b0;
            mem_to_reg = 1'b0;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            alu_op = 2'b10;
        end
        7'b0000011: //I type 
        begin
            alu_src = 1'b1;
            mem_to_reg = 1'b1;
            reg_write = 1'b1;
            mem_read = 1'b1;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            alu_op = 2'b00;
        end
        7'b0010011: //I type - Immidiate operations
        begin
            alu_src = 1'b1;
            mem_to_reg = 1'b0;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            alu_op = 2'b11;
        end
        7'b0100011: //S type
        begin
            alu_src = 1'b1;
            mem_to_reg = 1'bX;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b1;
            branch = 1'b0;
            jump = 1'b0;
            alu_op = 2'b00;
        end
        7'b1100011: // SB type
        begin
            alu_src = 1'b0;
            mem_to_reg = 1'bX;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b1;
            jump = 1'b0;
            alu_op = 2'b01;
        end
    endcase
end
endmodule