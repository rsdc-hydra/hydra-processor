module CPU_Demo(
    input src_clk,
    output	[6:0] HEX0,
    output	[6:0] HEX1,
    output	[6:0] HEX2,
    output	[6:0] HEX3,
    output	[6:0] HEX4,
    output	[6:0] HEX5,
    output	[6:0] HEX6,	
    output	[6:0] HEX7,
	 output [31:0] testR,
	 output [31:0] testM
);

reg [31:0] disp;

initial begin
    disp=0;
end

always @(posedge clk) begin
    disp=disp+1;
end

Digits digits(
    .disp(disp),
    
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX3(HEX3),

    .HEX4(HEX4),
    .HEX5(HEX5),
    .HEX6(HEX6),
    .HEX7(HEX7)
);


CPU cpu(
    .clk(clk),
    .testR(testR),
    .testM(testM)
);

// assign disp=testR;

Clk_Div clk_div(
    .clk(clk),
    .src_clk(src_clk)
);

endmodule