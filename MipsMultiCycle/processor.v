module processor(input clk,reset,
input [31:0]readdata,
output memwrite,
output [31:0]writedata,adr);

wire [31:0]instr;
wire zero,irwrite,iord,pcen;
wire alusrca,regwrite,regdst,memtoreg,bne_sign;
wire [1:0]pcsrc,alusrcb;
wire [2:0]alucontrol;



controller con(clk,reset,
instr[31:26],instr[5:0],
zero,
irwrite,memwrite,iord,pcen,
pcsrc,alucontrol,alusrcb,
alusrca,regwrite,regdst,memtoreg,bne_sign);

datapath dp(clk,reset,pcen,
pcsrc,alusrcb,
alucontrol,
instr,readdata,
alusrca,regwrite,iord,irwrite,regdst,memtoreg,bne_sign,
zero,
writedata,adr);
endmodule
