module left_shift(a,b);
input[31:0] a;
output[31:0] b;
assign b={a[29:0],2'b00};
endmodule
