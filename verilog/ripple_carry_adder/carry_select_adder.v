`include "full_adder.v"

module carry_select_adder (A,B,C_in,C_out)

input [9:0] A,B;
input C_in;
output C_out;
wire [8:0] wire;

full_adder fa_0 (A[0],B[0],C_in    ,C_out[0],Sum[0]);
full_adder fa_1 (A[1],B[1],C_out[0],C_out[1],Sum[1]);
full_adder fa_2 (A[2],B[2],C_out[1],C_out[2],Sum[2]);
full_adder fa_3 (A[3],B[3],C_out[2],C_out[3],Sum[3]);
full_adder fa_4 (A[4],B[4],C_out[3],C_out[4],Sum[4]);
full_adder fa_5 (A[5],B[5],C_out[4],C_out[5],Sum[5]);
full_adder fa_6 (A[6],B[6],C_out[5],C_out[6],Sum[6]);
full_adder fa_7 (A[7],B[7],C_out[6],C_out[7],Sum[7]);
full_adder fa_8 (A[8],B[8],C_out[7],C_out[8],Sum[8]);
full_adder fa_9 (A[9],B[9],C_out[8],C_out_r ,Sum[9]);



endmodule // 