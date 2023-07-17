module datapath(input clk,reset,pcsrc,
input regwrite,regdst,
input alusrc,memtoreg,jump,
input [2:0]alucontrol,
input [31:0]instr,
input [31:0]readdata,
output zero,
output [31:0]pc,
output [31:0]aluout,writedata);
//pc movement
wire [31:0]nextpc,pcplus4,sign_extend,signsh,pcbranch,pc_mid;

assign sign_extend=(instr[31:26]==6'b001101)?{16'd0,instr[15:0]}:{{16{instr[15]}},instr[15:0]};
//如果指令为ori，则0扩展，否则就是符号位扩展
flopr ff(clk,reset,nextpc,pc);//给下一个PC码赋值的触发器
adder add1(pc,32'd4,pcplus4);//对每次的PC码进行加4操作
left_shift left(sign_extend,signsh);//对扩展后的立即数进行左移2位操作
adder add2(signsh,pcplus4,pcbranch);//将加4后的PC码和移位后的立即数相加
mux2to1#(32) mux1(pcplus4,pcbranch,pcsrc,pc_mid);//二选一选择器，选择pcplus4或者或者pcbranch
mux2to1#(32) mux2(pc_mid,{pcplus4[31:28],instr[25:0],2'b00},jump,nextpc);//jump
//register file and alu
wire [31:0]srca,srcb;
wire [4:0] writereg;
wire [31:0] result;//输入writedata
mux2to1#(5) mux3(instr[20:16],instr[15:11],regdst,writereg);//选择寄存器文件写回数据的地址
regfile file1(clk,regwrite,instr[25:21],instr[20:16],writereg,result,srca,writedata);//寄存器文件
mux2to1#(32) mux4(writedata,sign_extend,alusrc,srcb);//选择ALU的第二个操作数srcb
ALU alu1(srca,srcb,alucontrol,aluout,zero);//ALU
mux2to1#(32) mux5(aluout,readdata,memtoreg,result);//选择写回的数据
endmodule
