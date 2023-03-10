`include "4bit_adder.v"

module multi_4bit(A,B,C,cin);

input [3:0]A,B;
input cin;
output [7:0]C;

wire [3:0]A0;
wire [3:0]A1;
wire [3:0]A2;
wire [3:0]A3;
wire [2:0]carry;

wire [3:0]s0;
wire [3:0]s1;
wire [3:0]s2;
// A0 * B
and(A0[0],A[0],B[0]);
and(A0[1],A[0],B[1]);
and(A0[2],A[0],B[2]);
and(A0[3],A[0],B[3]);
// A1 * B
and(A1[0],A[1],B[0]);
and(A1[1],A[1],B[1]);
and(A1[2],A[1],B[2]);
and(A1[3],A[1],B[3]);
// A2 * B
and(A2[0],A[2],B[0]);
and(A2[1],A[2],B[1]);
and(A2[2],A[2],B[2]);
and(A2[3],A[2],B[3]);
// A3 * B
and(A3[0],A[3],B[0]);
and(A3[1],A[3],B[1]);
and(A3[2],A[3],B[2]);
and(A3[3],A[3],B[3]);

//module adder_4bit(A,B,sum,cin,cout);
adder_4bit add01 ({1'b0    ,A0[3],A0[2],A0[1]},A1,s0,cin,carry[0]);
adder_4bit add02 ({carry[0],s0[3],s0[2],s0[1]},A2,s1,cin,carry[1]);
adder_4bit add03 ({carry[1],s1[3],s1[2],s1[1]},A3,s2,cin,carry[2]);

assign C[0] = A0[0];
assign C[1] = s0[0];
assign C[2] = s1[0];
assign C[7:3] = {carry[2],s2[3],s2[2],s2[1],s2[0]};

endmodule



