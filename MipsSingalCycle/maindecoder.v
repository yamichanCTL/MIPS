module maindecoder(input [5:0]op,
output reg regwrite,regdst,alusrc,branch,bne,memwrite,memtoreg,jump,
output reg[1:0]aluop);
reg [9:0]control;
always@(*)
begin
case(op)
6'b000000:control<=10'b1100000010;//rtype
6'b100011:control<=10'b1010010000;//lw
6'b101011:control<=10'b0010100000;//sw
6'b000100:control<=10'b0001000001;//beq
6'b001000:control<=10'b1010000000;//addi
6'b000010:control<=10'b0000001000;//j
6'b001101:control<=10'b1010000011;//ori
6'b000101:control<=10'b0001000101;//bne
default:  control<=10'bxxxxxxxxxx;
endcase 
{regwrite,regdst,alusrc,branch,memwrite,memtoreg,jump,bne,aluop[1:0]}<=control;
end
endmodule 