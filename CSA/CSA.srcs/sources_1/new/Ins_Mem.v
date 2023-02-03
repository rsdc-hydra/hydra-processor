`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.02.2023 10:15:46
// Design Name: 
// Module Name: Ins_Mem
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


module Ins_Mem #(parameter WIDTH = 32) (
    input [WIDTH-1:0] pc,
    output [WIDTH-1:0] ins
    );

reg [WIDTH-1:0] mem [WIDTH-1:0];

initial begin
$readmemh("program.mem",mem);
end

assign ins=mem[pc];
    
endmodule
