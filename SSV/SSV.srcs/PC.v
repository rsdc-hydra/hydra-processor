module ProgramCounter (
  input clk,
  input rst,
  input inc,
  input [31:0] nextPC,
  output reg [31:0] PC
);

always @(posedge clk) begin
  if (rst) begin
    PC <= 32'h0;
  end else if (inc) begin
    PC <= nextPC;
  end
end

endmodule