module controller(input [5:0]op,funct,
input zero,
output regwrite,regdst,
alusrc,memwrite,memtoreg,jump,pcsrc,
output [2:0]alucontrol);

wire [1:0]aluop;
wire branch,bne;

maindecoder md(op,
regwrite,regdst,
alusrc,branch,bne,
memwrite,memtoreg,jump,
aluop);

aludecoder ad(funct,
aluop,
alucontrol);

assign pcsrc=(bne==0)?(branch&zero):!(branch&zero);
endmodule 