module mux2to1#(parameter width)
(input [width-1:0] d0,d1,
input sel,
output [width-1:0] y);
assign y=sel?d1:d0;
endmodule 
//sel 为0选前面，为1选后面的