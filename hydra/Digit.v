module Digit(bcd,seg);
input [3:0] bcd;
output [6:0] seg;
reg [6:0] seg;

always @ (bcd)
begin
	case (bcd)
	0:seg=7'B1000000;
	1:seg=7'B1111001;
	2:seg=7'B0100100;
	3:seg=7'B0110000;
	4:seg=7'B0011001;
	5:seg=7'B0010010;
	6:seg=7'B0000010;
	7:seg=7'B1111000;
	8:seg=7'B0000000;
	9:seg=7'B0010000;
	10:seg=7'B0001000;
	11:seg=7'B0000011;
	12:seg=7'B1000110;
	13:seg=7'B0100001;
	14:seg=7'B0000110;
	15:seg=7'B0001110;	
	default:seg=7'B1111111;
	endcase
end
endmodule