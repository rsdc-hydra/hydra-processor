module Mux #(parameter WIDTH = 32) (
  input sel,
  input [WIDTH-1:0] i0,
  input [WIDTH-1:0] i1,
  output [WIDTH-1:0] out
);

assign out=(sel==1'b1)?i1:i0;

endmodule