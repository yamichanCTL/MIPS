module MIPSmulti(input clk, reset,
output [31:0] writedata, adr,
output memwrite);
wire [31:0] readdata;
// instantiate processor and memories
processor pro(clk, reset, readdata, memwrite, writedata, adr);
mem mem(clk, memwrite, adr, writedata, readdata);
endmodule 
