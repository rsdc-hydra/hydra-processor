module Data_Mem  #(parameter WIDTH = 32,parameter MEM_SIZE=7) (
    input clk,mem_write,mem_read,
    input [WIDTH-1:0] addr,write_data,
    output [WIDTH-1:0] read_data,
    output [WIDTH-1:0] test
);

reg [WIDTH-1:0] mem [2**MEM_SIZE-1:0][2**2-1:0];
wire  [MEM_SIZE-1:0] mem_addr_row=addr[MEM_SIZE+3:4];
wire  [1:0] mem_addr_col=addr[3:2];

assign read_data=(mem_read)? mem[mem_addr_row][mem_addr_col]: 0;

always @(posedge clk) begin
    if(mem_write)
        mem[mem_addr_row][mem_addr_col]<=write_data;
end
endmodule
