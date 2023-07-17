module maindecoder(input clk,reset,
input [5:0]op,
output irwrite,memwrite,iord,pcwrite,branch,
output [1:0]pcsrc,
output [1:0]alusrcb,
output alusrca,regwrite,regdst,memtoreg,bne_sign,
output [1:0]aluop);

parameter s0=4'b0000;//fetch instruction
parameter s1=4'b0001;//decode 
parameter s2=4'b0010;//memadr
parameter s3=4'b0011;//memload
parameter s4=4'b0100;//memwriteback
parameter s5=4'b0101;//memwrite
parameter s6=4'b0110;//execute
parameter s7=4'b0111;//alu writeback
parameter s8=4'b1000;//branch
parameter s9=4'b1001;//addi execute
parameter s10=4'b1010;//addi writeback
parameter s11=4'b1011;//jump
parameter s12=4'b1100;//bne
parameter s13=4'b1101;//ori 
parameter lw=6'b100011;
parameter sw=6'b101011;
parameter r=6'b000000;
parameter beq=6'b000100;
parameter addi=6'b001000;
parameter j=6'b000010;
parameter bne=6'b000101;
parameter ori=6'b001101;

reg [3:0]state,nextstate;
reg [15:0]controls;
assign {bne_sign,pcwrite,memwrite,irwrite,regwrite,alusrca,branch,iord,memtoreg,regdst,alusrcb,pcsrc,aluop}=controls;//控制信号

//reset
always@(posedge clk,posedge reset)
begin
if(reset) state<=s0;
else state<=nextstate;
end
//nextstate
always@(*)
begin
case(state)
s0:nextstate=s1;
s1:case(op)
   lw:nextstate=s2;
   sw:nextstate=s2;
   r:nextstate=s6;
   beq:nextstate=s8;
   addi:nextstate=s9;
   j:nextstate=s11;
	bne:nextstate=s12;
	ori:nextstate=s13;
default:nextstate=s0;
endcase
s2:case(op)
   lw:nextstate=s3;
	sw:nextstate=s5;
	default:nextstate<=s0;
	endcase
s3:nextstate=s4;
s4:nextstate=s0;//1 2 3 4 0lw
s5:nextstate=s0;//1 2 5 0sw
s6:nextstate=s7;
s7:nextstate=s0;//1 6 7 0 r
s8:nextstate=s0;//1 8 0 beq
s9:nextstate=s10;
s10:nextstate=s0;// 1 9 10 0 addi
s11:nextstate=s0;// 1 11 0 j
s12:nextstate=s0;// 1 12 0 bne
s13:nextstate=s10;// 1 13 10 0 ori
default:nextstate=s0;
endcase
end
//output
always@(*)
begin
case(state)
s0:controls=16'h5010;
s1:controls=16'h0030;
s2:controls=16'h0420;
s3:controls=16'h0100;
s4:controls=16'h0880;
s5:controls=16'h2100;
s6:controls=16'h0402;
s7:controls=16'h0840;
s8:controls=16'h0605;
s9:controls=16'h0420;
s10:controls=16'h0800;
s11:controls=16'h4008;
s12:controls=16'h8605;
s13:controls=16'h0423;
default:controls=16'hxxxx;
endcase
end
endmodule 