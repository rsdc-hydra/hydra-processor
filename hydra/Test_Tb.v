`timescale 1ns / 1ps

module Test_Tb();

reg A;
wire [1:0] B;

Test test(
    .A(A),
    .B(B)
);

reg [31:0] mem [1:0];

initial begin
$readmemh("pr.hex",mem);
$display("hello");
$display(mem[0]);
    A=1;
    #100;
    A=0;
    #100;
end

endmodule