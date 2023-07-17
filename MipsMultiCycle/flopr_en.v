module flopr_en(clk,rst,en,nexta,a);
input clk,en,rst;
input[31:0] nexta;
output reg[31:0] a;
always @(posedge clk or posedge rst)
begin
	if(rst) a<=32'b0;
	else if(en) a<=nexta;
	else a<=a;
end
endmodule