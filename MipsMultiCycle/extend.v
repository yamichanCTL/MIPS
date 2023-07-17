module extend(a,b);
input[31:0] a;
output reg[31:0] b;
always @(*)
begin
	case(a[31:26])
		6'b001100:b={16'b0,a[15:0]};//andi
		6'b001101:b={16'b0,a[15:0]};//ori
		6'b001110:b={16'b0,a[15:0]};//xori
		default:b={{16{a[15]}},a[15:0]};
	endcase
end
endmodule 