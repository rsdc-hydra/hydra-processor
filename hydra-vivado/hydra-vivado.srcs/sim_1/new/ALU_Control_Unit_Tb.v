`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2023 20:58:12
// Design Name: 
// Module Name: ALU_Control_Unit_Tb
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


module ALU_Control_Unit_Tb;
reg [6:0] opcode;
wire reg[1:0] alu_op;
wire reg alu_src,mem_to_reg,reg_write,mem_read,mem_write,branch,jump;

ALU_Control_Unit alu_control_unit(
    .opcode(opcode),
    .alu_op(alu_op),
    .alu_src,
    .mem_to_reg(mem_to_reg),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .branch(branch),
    .jump(jump)
);

initial begin
    
end

endmodule
