`include "line_decoder.v"
module BCD_converter(B,P);

input [3:0]B;
output [9:0]P;
wire [10:0]T;

line_decoder C1 ({3'b000,B[3]},T[3:0]);
line_decoder C2 ({T[2:0],B[2]},T[7:4]);
line_decoder C3 ({3'b000,T[3]},{P[9],T[10:8]});
line_decoder C4 ({T[6:4],B1},P[4:1]);
line_decoder C5 (T[10:7],P[8:5]);


endmodule

