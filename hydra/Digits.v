
module Digits(
	input [31:0] disp,
	output	[6:0] HEX0,
	output	[6:0] HEX1,
	output	[6:0] HEX2,
	output	[6:0] HEX3,
	output	[6:0] HEX4,
	output	[6:0] HEX5,
	output	[6:0] HEX6,	
	output	[6:0] HEX7
);


reg [3:0] inp0,inp1,inp2,inp3,inp4,inp5,inp6,inp7;

Digit seg0(inp0,HEX0);
Digit seg1(inp1,HEX1);
Digit seg2(inp2,HEX2);
Digit seg3(inp3,HEX3);
Digit seg4(inp4,HEX4);
Digit seg5(inp5,HEX5);
Digit seg6(inp6,HEX6);
Digit seg7(inp7,HEX7);

always @ (*) begin
	inp0=disp[3:0];	
	inp1=disp[7:4];
	inp2=disp[11:8];
	inp3=disp[15:12];
	
	inp4=disp[19:16];
	inp5=disp[23:20];
	inp6=disp[27:24];
	inp7=disp[31:28];	
end
endmodule
