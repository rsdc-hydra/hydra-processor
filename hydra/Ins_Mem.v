`timescale 1ns / 1ps

module Ins_Mem #(parameter WIDTH = 32,parameter MEM_SIZE=5) (
    input [WIDTH-1:0] pc,
    output [WIDTH-1:0] ins
    );

reg [WIDTH-1:0] mem [2**MEM_SIZE-1:0];
wire  [MEM_SIZE-1:0] mem_addr=pc[MEM_SIZE+1:2];

initial begin
//  $display("mem[1]");   
$readmemh("program.mem",mem);
// //addi x2,x0,5
// //addi x3,x0,12
// mem[0]=32'h00500113;
// mem[1]=32'h00c00193;


// addi x1,x0,40
// addi x2,x0,42
// add x3,x1,x2

// mem[0]=32'h02800093;
// mem[1]=32'h02a00113;
// mem[2]=32'h002081b3;
// $display(mem[1]);
end

assign ins=mem[mem_addr];
    
endmodule
