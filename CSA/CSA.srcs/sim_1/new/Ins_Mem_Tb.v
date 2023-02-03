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


module Ins_Mem_Tb #(parameter WIDTH = 32) (

    );
    
reg [WIDTH-1:0] pc;
wire [WIDTH-1:0] ins;

Ins_Mem ins_mem(pc,ins);

integer i;
initial 
begin
    
    pc=0;
    for(i=0;i<6;i=i+1) begin
        pc=i;
        #100;
    end
end
endmodule
