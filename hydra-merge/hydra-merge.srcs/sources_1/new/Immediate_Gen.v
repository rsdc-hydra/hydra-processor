`timescale 1ns/1ps
//`include "Parameters.v"

module Immediate_Gen (
    input [32-1:0] ins,
    output [32-1:0] imm
);

reg [6:0] opcode;
reg [32-1:0] _imm;
always @(ins) begin
    opcode = ins[6:0];
    case(opcode)
        7'd19:_imm = {{20{ins[31]}},ins[31:20]};
        7'd3:_imm = {{20{ins[31]}},ins[31:20]};
        7'd35:_imm = {{20{ins[31]}},ins[31:25],ins[11:7]};
        7'd99:_imm = {{20{ins[31]}},ins[7],ins[30:25],ins[11:8]};
        default:_imm = 32'b0;
    endcase
end
assign imm=_imm;
endmodule