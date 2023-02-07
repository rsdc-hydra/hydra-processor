`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.02.2023 13:11:19
// Design Name: 
// Module Name: Ins_Mem_Tb
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


module Ins_Mem_Tb #(parameter WIDTH = 32,parameter MEM_SIZE=5) (

    );
    
reg [WIDTH-1:0] pc;
reg [WIDTH-1:0] mem [2**MEM_SIZE-1:0];
wire [WIDTH-1:0] ins;

Ins_Mem ins_mem(pc,ins);

integer i;
initial begin
    $readmemh("program.mem",mem);
    pc=0;
    for(i=0;i<6;i=i+1) begin
        pc=i;
        #100;
    end
end
endmodule
