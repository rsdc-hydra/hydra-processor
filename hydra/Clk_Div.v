module Clk_Div (clk,src_clk);

output reg clk;
input src_clk; 
reg [26:0] count;

initial begin
count=0;
end

always @(posedge src_clk)
begin
    if (count == 27'd1_000_000) begin 
        count   <= 0;
        clk <= ~clk;
    end else begin
        count   <= count + 1'b1;    
    end 
end

endmodule