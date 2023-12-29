`timescale 1ns / 1ps

module Ins_Mem #(parameter WIDTH = 32,parameter MEM_SIZE=5) (
    input [WIDTH-1:0] pc,
    output [WIDTH-1:0] ins
    );

reg [WIDTH-1:0] mem [2**MEM_SIZE-1:0];
wire  [MEM_SIZE-1:0] mem_addr=pc[MEM_SIZE+1:2];

initial begin
$readmemh("program.mem",mem);
end

assign ins=mem[mem_addr];
    
endmodule
