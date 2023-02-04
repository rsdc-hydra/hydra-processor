`timescale 1ns/1ps
//`include "Parameters.v"

module Immediate_Gen (
    input clk,
    input [32-1:0] instruction_,
    output [32-1:0] immediate
);

reg [6:0] opcode;
reg [32-1:0] imm;
always @(immediate) begin
    opcode = instruction_[6:0];
    case(opcode)
        7'd3:imm <= {{20{instruction_[31]}},instruction_[31:20]};
        7'd35:imm <= {{20{instruction_[31]}},instruction_[31:25],instruction_[11:7]};
        7'd99:imm <= {{19{instruction_[31]}},instruction_[7],instruction_[30:25],instruction_[11:8],1'b0};
        default:imm <= 32'b0;
    endcase
end
assign immediate=imm;
endmodule