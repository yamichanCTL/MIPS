module mips(input clk, reset, 
output [31:0]pc,
input [31:0]instr, 
output memwrite,
output [31:0]aluout, writedata,
input [31:0]readdata);
 
//controller
wire regwrite,regdst,alusrc,memtoreg;
wire jump;//jump
wire pcsrc,zero;//branch
wire [2:0]alucontrol;

controller c(instr[31:26],instr[5:0],zero,
regwrite,regdst,
alusrc,memwrite,memtoreg,jump,pcsrc,
alucontrol);
//datapath
datapath dp(clk,reset,pcsrc,
regwrite,regdst,
alusrc,memtoreg,jump,
alucontrol,instr,readdata,
zero,pc,
aluout,writedata);

endmodule 