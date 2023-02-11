`timescale 1ns / 1ps

module ALU_Control_Unit(alu_cnt,alu_op,alu_opcode,alu_control_in);
  output reg [3:0] alu_cnt;
  input [1:0] alu_op;
  input [3:0] alu_opcode;
  output [5:0] alu_control_in;
  assign alu_control_in ={alu_op,alu_opcode};
  always @(alu_control_in)
  begin
  casex (alu_control_in)
  //I type and S type ALU control signals
  6'b00xxxx: alu_cnt=4'b0000;
  
  //I type ALU controls for immidiate opperations
  6'b11x000: alu_cnt=4'b0000;
  6'b11x100: alu_cnt=4'b0010; 
  6'b11x110: alu_cnt=4'b0011;
  6'b11x111: alu_cnt=4'b0100;
  6'b110001: alu_cnt=4'b0101;
  6'b110101: alu_cnt=4'b0110;
  6'b111101: alu_cnt=4'b0111;
  6'b11x010: alu_cnt=4'b1000;
  6'b11x011: alu_cnt=4'b1011;
   
  //SB type ALU control Signals
  6'b01x000: alu_cnt=4'b0001;
  6'b01x001: alu_cnt=4'b1001;
  6'b01x100: alu_cnt=4'b1010;
  6'b01x101: alu_cnt=4'b1000;
  6'b01x110: alu_cnt=4'b1010;
  6'b01x111: alu_cnt=4'b1000;
 // R type Alu Control signals
  6'b100000: alu_cnt=4'b0000;//add
  6'b101000: alu_cnt=4'b0001;//sub
  6'b100100: alu_cnt=4'b0010;//xor
  6'b100110: alu_cnt=4'b0011;//or
  6'b100111: alu_cnt=4'b0100;//and
  6'b100001: alu_cnt=4'b0101;//shift left 
  6'b100101: alu_cnt=4'b0110;//shift right
  6'b101101: alu_cnt=4'b0111;//shift right arithmatic
  6'b100010: alu_cnt=4'b1000;//set less than
  6'b100011: alu_cnt=4'b1000;//set less than unsigned
  default: alu_cnt=4'b0000;
  endcase
  end
endmodule
