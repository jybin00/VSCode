`include "jk.v"
module RES_UPDNC(RESETN, CLK, UD, Q);
input RESETN, CLK, UD;
output wire [3:0] Q;
wire [3:0] nQ;
wire w;
assign w=1'b1;
JK_FF F1(CLK, RESETN, w, w, Q[0], nQ[0]);
JK_FF F2(CLK, RESETN, (Q[0] & UD)|(nQ[0] & ~UD), (Q[0] & UD)|(nQ[0] & ~UD), Q[1], nQ[1]);
JK_FF F3(CLK, RESETN, (Q[1] & (Q[0] & UD))|(nQ[1] & (nQ[0] & ~UD)), (Q[1] & (Q[0] & UD))|(nQ[1] & (nQ[0] & ~UD)), Q[2], nQ[2]);
JK_FF F4(CLK, RESETN, (Q[2] & (Q[1] & UD))|(nQ[2] & (nQ[1] & ~UD)), (Q[2] & (Q[1] & UD))|(nQ[2] & (nQ[1] & ~UD)), Q[3], nQ[3]);
endmodule