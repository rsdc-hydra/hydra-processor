
`timescale 1ns/1ps
`include "Parameters.v"

module  Reg_File (
    input clk,reg_write,
    input [REG_FILE_SIZE-1:0] read_reg_addr_1,read_reg_addr_2,write_reg_addr,
    output [WIDTH-1:0] read_reg_data_1,read_reg_data_2,write_reg_data    
);

reg [WIDTH-1:0] regs [2**REG_FILE_SIZE-1:0];

initial begin
    for(i=0;i<2**REG_FILE_SIZE;i=i+1)
        regs[i]<=WIDTH'd0;
end

assign read_reg_data_1=regs[read_reg_addr_1];
assign read_reg_data_2=regs[read_reg_addr_2];

always @ (posedge clk) begin
    if (reg_write)
        regs[write_reg_addr]<=write_reg_data;
end
    
endmodule