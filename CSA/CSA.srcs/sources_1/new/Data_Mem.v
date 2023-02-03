module Data_Mem  #(parameter WIDTH = 32,parameter MEM_SIZE=5) (
    input clk,mem_write,mem_read,
    input [WIDTH-1:0] addr,write_data,
    output [WIDTH-1:0] read_data
);

reg [WIDTH-1:0] mem [2**MEM_SIZE-1:0];
wire  [MEM_SIZE-1:0] mem_addr=addr[MEM_SIZE-1:0];

assign read_data=(mem_read) mem[addr]: 0;

always @(posedge clk) begin
    if(mem_write)
        mem[mem_addr]<=write_data;
end


endmodule
