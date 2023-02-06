`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2023 11:23:51 PM
// Design Name: 
// Module Name: Control_Unit_Tb
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


module Control_Unit_Tb();
reg[6:0] opcode;
wire [1:0] alu_op;
wire alu_src,mem_to_reg,reg_write,mem_read,mem_write,branch,jump;
parameter period = 100;
Control_Unit cotrol_unit(
.opcode(opcode),
.alu_op(alu_op),
.alu_src(alu_src),
.mem_to_reg(mem_to_reg),
.reg_write(reg_write),
.mem_read(mem_read),
.mem_write(mem_write),
.branch(branch),
.jump(jump));

initial begin
opcode=7'b0110011;
#period;
opcode=7'b0000011;
#period;
opcode=7'b0100011;
#period;
opcode=7'b1100011;
#period;
end
endmodule
