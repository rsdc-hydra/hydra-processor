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
    input [2:0] alu_control,
    output reg [31:0] result,
    output zero
    );
always @(*) begin
    case(alu_control)
        3'b000: result= a+b;
        3'b001: result= a-b;
        3'b010: result= ~a;
        3'b011: result=a<<b;
        3'b100: result=a>>b;
        3'b101: result=a&b;
        3'b110: result=a|b;
        3'b111: begin 
            if (a<b) result=32'd1;
            else result=32'd0;
            end
        default: result=a+b;
    endcase
end
assign zero=(result==16'd0) ? 1'b1: 1'b0;
endmodule
