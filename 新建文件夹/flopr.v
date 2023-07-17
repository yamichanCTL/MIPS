module flopr(clk,reset,nextpc,pc);
input clk,reset;
input[31:0] nextpc;
output reg[31:0] pc;
always @(posedge clk or posedge reset)
begin
	if(reset) pc<=32'd0;
	else pc<=nextpc;
end
endmodule 