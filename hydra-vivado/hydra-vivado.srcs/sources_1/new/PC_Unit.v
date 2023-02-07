`timescale 1ns / 1ps

module PC_Unit #(parameter WIDTH = 32,parameter MEM_SIZE=5) (
    input clk,branch,zero,
    input [WIDTH-1:0] imm,
    output reg [WIDTH-1:0] pc,
    output [WIDTH-1:0] pc_next
);

    assign pc_next= (branch && zero) ? (pc + (imm<<1)):(pc+4);
    
    initial begin
        pc=0;
    end

    always @ (posedge clk) begin
        pc<=pc_next;
    end

endmodule
