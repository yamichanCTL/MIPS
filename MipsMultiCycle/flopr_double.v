module flopr_double(clk,rst,nexta,nextb,a,b);
input clk,rst;
input[31:0] nexta,nextb;
output reg[31:0] a,b;
always @(posedge clk or posedge rst)
begin
	if(rst) 
		begin
			a<=32'b0;
			b<=32'b0;
		end
	else
		begin
			a<=nexta;
			b<=nextb;
		end
end
endmodule 