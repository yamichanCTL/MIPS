module left_shift26(a,b);
input[25:0] a;
output[27:0] b;
assign b={a[25:0],2'b00};
endmodule
