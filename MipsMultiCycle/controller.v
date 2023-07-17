module controller(input clk,reset,
input [31:26]op,
input [5:0]funct,
input zero,
output irwrite,memwrite,iord,pcen,
output [1:0]pcsrc,
output [2:0]alucontrol,
output [1:0]alusrcb,
output alusrca,regwrite,regdst,memtoreg,bne_sign);

wire [1:0]aluop;
wire pcwrite,branch;

maindecoder md(clk,reset,op,
irwrite,memwrite,iord,pcwrite,branch,
pcsrc,alusrcb,
alusrca,regwrite,regdst,memtoreg,bne_sign,
aluop);//主译码器

aludecoder ad(funct,aluop,alucontrol);

assign pcen=(bne_sign)?(pcwrite|(!(branch&zero))):(pcwrite|(branch&zero));
endmodule