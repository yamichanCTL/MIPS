module test1();
reg clk,reset;
reg[31:26] op;
reg[5:0] funct;
reg zero;
wire irwrite,memwrite,iord,pcen;
wire[1:0] pcsrc;
wire[2:0] alucontrol;
wire[1:0] alusrcb;
wire alusrca,regwrite,regdst,memtoreg,bne_sign;

controller control(clk,reset,op,funct,zero,irwrite,
memwrite,iord,pcen,pcsrc,alucontrol,alusrcb,alusrca,
regwrite,regdst,memtoreg,bne_sign);

initial
begin
	reset <= 1; # 22; reset <= 0;
end

always
begin
	clk <= 1; # 5; clk <= 0; # 5;
end 
endmodule 