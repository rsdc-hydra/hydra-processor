`timescale 1ns/1ps
//`include "Parameters.v"

module Immediate_Gen (
    input [32-1:0] instruction_,
    output [32-1:0] immediate
);

reg [6:0] opcode;
reg [32-1:0] imm;
always @(instruction_) begin
    opcode = instruction_[6:0];
    case(opcode)
        7'd3:imm = {{20{instruction_[31]}},instruction_[31:20]};
        7'd35:imm = {{20{instruction_[31]}},instruction_[31:25],instruction_[11:7]};
        7'd99:imm = {{20{instruction_[31]}},instruction_[7],instruction_[30:25],instruction_[11:8]};
        default:imm = 32'b0;
    endcase
end
assign immediate=imm;
endmodule