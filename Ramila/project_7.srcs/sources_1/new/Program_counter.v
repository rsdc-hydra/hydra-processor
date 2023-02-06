`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2023 10:35:13 AM
// Design Name: 
// Module Name: Program_counter
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


module Program_counter(reset,br,Imm,zero,clk,regout);

input [31:0] Imm;
input reset,br,zero,clk;
output reg [31:0] regout;

wire 	 branch;  
assign branch = br & zero;

always @(posedge clk) begin
    if (reset)
        regout = 32'b0;
    else 
        case (branch)
            1'b0 : regout = regout +4;
            1'b1 : regout = Imm;
        endcase
end


endmodule

