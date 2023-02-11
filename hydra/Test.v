`timescale 1ns / 1ps

module Test(
    input A,
    output [1:0] B
    );

assign B=(A==1'b1)? 2'b00:2'b11;   
 
endmodule
