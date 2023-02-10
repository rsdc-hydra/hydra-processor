`timescale 1ns / 1ps

module  Reg_File #(parameter WIDTH = 32,parameter REG_FILE_SIZE=5) (
    input clk,reg_write,
    input [REG_FILE_SIZE-1:0] read_reg_addr_1,read_reg_addr_2,write_reg_addr,
	input [WIDTH-1:0] write_reg_data,
    output [WIDTH-1:0] read_reg_data_1,read_reg_data_2,
    output [WIDTH-1:0] test
);

reg [WIDTH-1:0] regs [2**REG_FILE_SIZE-1:0];

assign read_reg_data_1=regs[read_reg_addr_1];
assign read_reg_data_2=regs[read_reg_addr_2];

integer i;
initial 
begin  
    for(i=0;i<2**REG_FILE_SIZE;i=i+1)
        regs[i]=0;
end

always @ (posedge clk) begin
    if (reg_write == 1'b1 && write_reg_addr != 5'd0)
        regs[write_reg_addr]<=write_reg_data;
end

assign test=regs[1];
    
endmodule
