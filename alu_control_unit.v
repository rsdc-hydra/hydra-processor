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


module alu_control_unit(alu_cnt,alu_op,ALU_OPCODE);
  output reg [3:0] alu_cnt;
  input [1:0] alu_op;
  input [3:0] ALU_OPCODE;
  wire [5:0] alucontrol_in;
  assign alucontrol_in ={alu_op,ALU_OPCODE};
  always @(alucontrol_in)
  casex (alucontrol_in)
  //I type and S type ALU control signals
  6'b00xxxx: alu_cnt=4'b0000;
  
  //I type ALU controls for immidiate opperations
  
  //SB type ALU control Signals
  6'b01xxxx: alu_cnt=4'b0001;
  
 // R type Alu Control signals
  6'b100000: alu_cnt=4'b0000;//add
  6'b101000: alu_cnt=4'b0001;//sub
  6'b100100: alu_cnt=4'b0010;//xor
  6'b100110: alu_cnt=4'b0011;//or
  6'b100111: alu_cnt=4'b0100;//and
  6'b100001: alu_cnt=4'b0101;//shift left 
  6'b100101: alu_cnt=4'b0110;//shift right
  6'b101101: alu_cnt=4'b0110;//shift right arithmatic
  6'b100010: alu_cnt=4'b0111;//set less than
  6'b100011: alu_cnt=4'b0111;//set less than
  default: alu_cnt=4'b0000;
  endcase
endmodule
