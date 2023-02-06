module Mux (
  input wire sel,
  input wire a,
  input wire b,
  output reg y
);

  always @ (sel, a, b) begin
    if (sel == 1'b0) begin
      y = a;
    end else begin
      y = b;
    end
  end

endmodule