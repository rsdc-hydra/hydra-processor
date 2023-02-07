`timescale 1ns / 1ps

module Ins_Mem #(parameter WIDTH = 32,parameter MEM_SIZE=5) (
    input [WIDTH-1:0] pc, 
    input reg [WIDTH-1:0] mem [2**MEM_SIZE-1:0],
    output [WIDTH-1:0] ins
    );

wire  [MEM_SIZE-1:0] mem_addr=pc[MEM_SIZE-1:0];

assign ins=mem[mem_addr];
    
endmodule
