`timescale 1ns/1ps
//`include "Parameters.v"

module Immediate_Gen (
    input [32-1:0] ins,
    output [32-1:0] imm
);

reg [6:0] opcode;
reg [32-1:0] _imm;

reg [2:0] func3;
reg func7;
wire z=0;
always @(ins) begin
    opcode = ins[6:0];
    case(opcode)
        7'd19: begin
            func3=ins[14:12];
            func7=ins[30];

            if (func3==3'd1)
                _imm = {{27{z}},ins[24:20]}; 
            else begin
                if (func3==3'd5) begin
                    if(func7)
                         _imm = {{27{ins[31]}},ins[24:20]};
                    else
                        _imm = {{27{z}},ins[24:20]};
                end
                else
                    _imm = {{20{ins[31]}},ins[31:20]};
            end
        end 

        7'd3:_imm = {{20{ins[31]}},ins[31:20]};
        7'd35:_imm = {{20{ins[31]}},ins[31:25],ins[11:7]};
        7'd99:_imm = {{20{ins[31]}},ins[7],ins[30:25],ins[11:8]};
        default:_imm = 32'b0;
    endcase
end
assign imm=_imm;
endmodule