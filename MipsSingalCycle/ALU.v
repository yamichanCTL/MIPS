module ALU
(input [31:0]a,b,
input [2:0]f,
output reg [31:0]y,
output reg zero);
//ALU功能
always@(*)
begin 
case(f)
3'b000:y=a&b;
3'b001:y=a|b;
3'b010:y=a+b;
3'b011:y=1'b0;//未使用
3'b100:y=a&~b;
3'b101:y=a|~b;
3'b110:y=a-b;
3'b111:
begin
case({a[31],b[31]})//a，b符号位拼接
2'b00:y=a<b?1:0;//a，b同+
2'b01:y=0;//a+，b-则 a>b
2'b10:y=1;//a-，b+则 a<b
2'b11:y=a>b?1:0;//a,b同负 a逻辑值大则算术值小
endcase
end// SLT
default: y=0;
endcase 
zero=(y==0);//zero标志符
end
endmodule 