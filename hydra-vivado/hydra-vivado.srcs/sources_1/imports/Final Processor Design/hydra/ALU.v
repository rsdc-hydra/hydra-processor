`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2023 10:42:08 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] a,b,
    input signed [3:0] alu_control,
    output reg signed [31:0] result,
    output zero
    );
reg [31:0] A,B;
always @(*)
begin
A=a;
B=b;
case(alu_control)
4'b0000: result= a+b;//add
4'b0001: result= a-b;//sub
4'b0010: result= a^b;//XOR
4'b0011: result= a|b;//OR
4'b0100: result= a&b;//AND
4'b0101: result=a<<b;//shift left Logical
4'b0110: result=a>>b;//shift right logical
4'b0111: result=a>>>b;//shift right arithmatic
4'b1000: begin if (a<b) result=32'd1;else result=32'd0;end //set less than 
4'b1001: begin if (a!=b) result=32'd0;else result=32'd1;end
4'b1010: begin if (a<b) result=32'd0;else result=32'd1;end
4'b1011: begin if (A<B) result=32'd1;else result=32'd0;end//set less than unsigned
default: result=a+b;
endcase
end
assign zero=(result==32'd0) ? 1'b1: 1'b0;
endmodule
