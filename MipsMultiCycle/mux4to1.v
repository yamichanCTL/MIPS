module mux4to1(a,b,c,d,sel,Y);
input[31:0] a,b,c,d;
input[1:0] sel;
output reg[31:0] Y;
always @(*)
begin
	case(sel)
		2'b00:Y=a;
		2'b01:Y=b;
		2'b10:Y=c;
		2'b11:Y=d;
		default:Y=Y;
	endcase
end
endmodule