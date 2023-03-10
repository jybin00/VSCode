`include "full_adder.v"

module adder_4bit(A,B,sum,cin,cout);

input [3:0]A,B;
input cin;
output [3:0]sum;
output cout;
wire [2:0]c;

full_adder fa0 (A[0],B[0],cin,sum[0],c[0]);
full_adder fa1 (A[1],B[1],c[0],sum[1],c[1]);
full_adder fa2 (A[2],B[2],c[1],sum[2],c[2]);
full_adder fa3 (A[3],B[3],c[2],sum[3],cout);

endmodule
