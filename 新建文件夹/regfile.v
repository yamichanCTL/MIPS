module regfile(clk,we3,a1,a2,a3,wd3,rd1,rd2);
input clk,we3;//定义时钟信号和写使能信号
input[4:0] a1,a2,a3;//寄存器文件输入
input[31:0] wd3;//寄存写入数据
output[31:0] rd1,rd2;//寄存器输出
reg [31:0]file[31:0];//寄存器文件

assign rd1=(a1!=5'd0)?file[a1]:0;
assign rd2=(a2!=5'd0)?file[a2]:0;

always @(posedge clk)
begin
	if(we3) file[a3]<=wd3;
end

endmodule 