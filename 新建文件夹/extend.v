module extend(a,b);
input[15:0] a;
output[31:0] b;
assign b={{16{a[15]}},a[15:0]};
endmodule 