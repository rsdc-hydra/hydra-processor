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


module Program_counter(reset,inc,regin,load,clk,regout);

input [31:0] regin;
input reset,inc,load,clk;
output reg [31:0] regout;


always @(posedge clk) begin
    if (reset)
        regout = 32'b0;
    else if (load) begin
        case (inc)
            1'b0 : regout = regin;
            1'b1 : regout = regout + 4;
        endcase
    end 
end


endmodule

