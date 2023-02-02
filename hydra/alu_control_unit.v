`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/03/2023 02:26:03 AM
// Design Name: 
// Module Name: alu_control_unit
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


module alu_control_unit(alu_cnt,alu_op,opcode);
  output reg [2:0] alu_cnt;
  input [1:0] alu_op;
  input [3:0] opcode;
  wire [5:0] alucontrol_in;
  assign alucontrol_in ={alu_op,opcode};
  always @(alucontrol_in)
  casex (alucontrol_in)
  6'b00xxxx: alu_cnt=3'b000;
  6'b01xxxx: alu_cnt=3'b001;
  6'b100000: alu_cnt=3'b000;
  6'b100001: alu_cnt=3'b001;
  6'b100010: alu_cnt=3'b010;
  6'b100011: alu_cnt=3'b011;
  6'b100100: alu_cnt=3'b100;
  6'b100101: alu_cnt=3'b101;
  6'b100110: alu_cnt=3'b110;
  6'b100111: alu_cnt=3'b111;
  default: alu_cnt=3'b000;
  endcase
endmodule
