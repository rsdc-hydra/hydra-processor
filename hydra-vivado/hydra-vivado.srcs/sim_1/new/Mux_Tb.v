module Mux_tb;

// Parameters
parameter WIDTH = 32;

// Inputs
reg sel;
reg [WIDTH-1:0] i0;
reg [WIDTH-1:0] i1;

// Outputs
wire [WIDTH-1:0] out;

// Instance of Mux
Mux #(WIDTH) mux_inst(.sel(sel), .i0(i0), .i1(i1), .out(out));

initial begin
  // Test Case 1: sel = 0
  sel = 0;
  i0 = 32'h12345678;
  i1 = 32'h87654321;
  #10;
  if (out != i0)
    $display("Test Case 1: FAILED");
  else
    $display("Test Case 1: PASSED");

  // Test Case 2: sel = 1
  sel = 1;
  i0 = 32'h1234578;
  i1 = 32'h1234abc;
  #10;
  if (out != i1)
    $display("Test Case 2: FAILED");
  else
    $display("Test Case 2: PASSED");
end

endmodule
