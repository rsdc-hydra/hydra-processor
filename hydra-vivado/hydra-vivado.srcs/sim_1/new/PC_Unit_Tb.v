`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.02.2023 19:44:50
// Design Name: 
// Module Name: PC_Unit_Tb
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


module PC_Unit_Tb #(parameter WIDTH = 32,parameter MEM_SIZE=5);

reg clk,branch,zero;
reg [WIDTH-1:0] imm;
wire [WIDTH-1:0] pc,pc_next;

initial begin
    clk=0;
    imm=1;
end

parameter delay=20;

PC_Unit pc_unit(
    .clk(clk),
    .branch(branch),
    .zero(zero),
    .imm(imm),
    .pc(pc),
    .pc_next(pc_next)
);


always begin
    #10 clk = ~clk;
end

initial begin
    zero=0;
    branch=0;
    #delay;
    zero=1'b0;
    branch=1;
    #delay;
    zero=1;
    branch=1'b0;
    #delay
    branch=1;
    #delay;
    branch=0;
    #delay;
    zero=0;  
end


endmodule
