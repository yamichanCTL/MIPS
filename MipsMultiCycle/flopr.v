module flopr#(parameter width)
(clk,reset,nextpc,pc);
input clk,reset;
input [width-1:0] nextpc;
output reg[width-1:0] pc;
always @(posedge clk or posedge reset)
begin
	if(reset) pc<=width-1'd0;
	else pc<=nextpc;
end
endmodule 