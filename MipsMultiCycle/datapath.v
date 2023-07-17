module datapath(input clk,rst,pcen,
input[1:0] pcsrc,alusrcb,
input[2:0] alucontrol,
output [31:0]instr,
input [31:0] readdata,
input alusrca,regwrite,iord,irwrite,regdst,memtoreg,bne_sign,
output zero,
output[31:0] writedata,adr);

wire [31:0] pc,aluout;
wire[31:0] nextpc,aluOUT,nextsrca,result,rd1,rd2,data,immext,immext_etd,srca,srcb,pcjump;
wire[31:0] nextsrcb;
wire[27:0] jump_etd;
wire[4:0] a3;
assign writedata=nextsrcb;
assign pcjump={pc[31:28],jump_etd};

flopr_en fpc(clk,rst,pcen,nextpc,pc);//给下一个PC值赋值
mux2to1#(32) mux1(pc,aluOUT,iord,adr);//给数据指令存储器的A赋值
flopr#(32) fdata(clk,rst,readdata,data);//把readdata赋值给data
flopr_en finstr(clk,rst,irwrite,readdata,instr);//把输入的readdata赋值给instr
mux2to1#(32) mux2(pc,nextsrca,alusrca,srca);//给ALU前的srca赋值
mux2to1#(32) mux3(aluOUT,data,memtoreg,result);//选择写回寄存器文件的数据
mux2to1#(5) mux4(instr[20:16],instr[15:11],regdst,a3);//选择写回寄存器文件的数据的地址
regfile file(clk,regwrite,instr[25:21],instr[20:16],a3,result,rd1,rd2);//寄存器文件
flopr_double flopr4(clk,rst,rd1,rd2,nextsrca,nextsrcb);//把rd1，rd2赋值给nextsrca，nextsrcb
extend etd(instr,immext);//扩展
left_shift shift1(immext,immext_etd);//给立即数左移
left_shift26 shift2(instr[25:0],jump_etd);//跳转指令时的移位
mux4to1 mux5(nextsrcb,32'd4,immext,immext_etd,alusrcb,srcb);//选择srcb
ALU alu(srca,srcb,alucontrol,aluout,zero);//ALU
flopr #(32) faluout(clk,rst,aluout,aluOUT);//把aluout赋值给aluOUT
mux4to1 mux6(aluout,aluOUT,pcjump,32'd0,pcsrc,nextpc);//选择nextpc值
endmodule 