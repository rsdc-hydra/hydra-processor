`timescale 1ns / 1ps

module ALU(
    input signed [31:0] a,b,
    input [3:0] alu_cnt,
    output reg signed [31:0] alu_result,
    output zero
    );

    reg [31:0] A,B;
    always @(*)
    begin
        A=a;
        B=b;
        case(alu_cnt)
            4'b0000: alu_result= a+b;//add
            4'b0001: alu_result= a-b;//sub
            4'b0010: alu_result= a^b;//XOR
            4'b0011: alu_result= a|b;//OR
            4'b0100: alu_result= a&b;//AND
            4'b0101: alu_result=a<<b;//shift left Logical
            4'b0110: alu_result=a>>b;//shift right logical
            4'b0111: alu_result=a>>>b;//shift right arithmatic
            4'b1000: begin if (a<b) alu_result=32'd1;else alu_result=32'd0;end //set less than 
            4'b1001: begin if (a!=b) alu_result=32'd0;else alu_result=32'd1;end
            4'b1010: begin if (a<b) alu_result=32'd0;else alu_result=32'd1;end
            4'b1011: begin if (A<B) alu_result=32'd1;else alu_result=32'd0;end//set less than unsigned
            default: alu_result=a+b;
        endcase
    end
    
    assign zero=(alu_result==32'd0) ? 1'b1: 1'b0;
endmodule
