`include "full_adder.v"

module abs (A,B,cin,cout,sum);

input [3:0]A,B;
input cin;
output [3:0]sum;
output cout;
wire [3:0]a;  // xor과 full adder 연결
wire [2:0]c;  // full adder 내부 연결
assign B = 4'b0000;
assign cin = A[3];

xor(a[0],A[0],cin);
xor(a[1],A[1],cin);
xor(a[2],A[2],cin);
xor(a[3],A[3],cin);

full_adder fa0 (B[0],a[0], cin,sum[0],c[0]);
full_adder fa1 (B[1],a[1],c[0],sum[1],c[1]);
full_adder fa2 (B[2],a[2],c[1],sum[2],c[2]);
full_adder fa3 (B[3],a[3],c[2],sum[3],cout);

endmodule


