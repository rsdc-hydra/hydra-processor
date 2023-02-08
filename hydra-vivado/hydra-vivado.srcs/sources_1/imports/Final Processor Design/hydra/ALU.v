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
    input [31:0] alu_input_a,alu_input_b,
    input [2:0] alu_cnt,
    output reg [31:0] alu_result,
    output zero
    );

initial begin
    alu_result=0;
end

always @(*) begin
    case(alu_cnt)
        3'b000: alu_result= alu_input_a+alu_input_b;
        3'b001: alu_result= alu_input_a-alu_input_b;
        3'b010: alu_result= ~alu_input_a;
        3'b011: alu_result=alu_input_a<<alu_input_b;
        3'b100: alu_result=alu_input_a>>alu_input_b;
        3'b101: alu_result=alu_input_a&alu_input_b;
        3'b110: alu_result=alu_input_a|alu_input_b;
        3'b111: begin 
            if (alu_input_a<alu_input_b) alu_result=32'd1;
            else alu_result=32'd0;
            end
        default: alu_result=alu_input_a+alu_input_b;
    endcase
end
assign zero=(alu_result==16'd0) ? 1'b1: 1'b0;
endmodule
