`include "Mux.v"
`include "4bit_add_sub.v"

module div_4bit(A,B,Q,R,cin);

input cin;
input [3:0]A,B;
output [3:0]Q,R;
wire [3:0]q;
wire [3:0]sub0,sub1,sub2,sub3;
wire [2:0]m0,m1,m2;

assign Q[3:0] = ~q[3:0];

//add_sub_4bit (A,B,cin,cout,sum);
//Mux (In,Sel,Out)
add_sub_4bit as4_0 ({3'b000,A[3]}, B, cin, q[3], sub0 );
Mux mux00 ({sub0[2],1'b0},q[3],m0[2]);
Mux mux01 ({sub0[1],1'b0},q[3],m0[1]);
Mux mux02 ({sub0[0],1'b0},q[3],m0[0]);

add_sub_4bit as4_1 ({m0[2],m0[1],m0[0],A[2]},B, cin, q[2], sub1 );
Mux mux10 ({sub1[2],m0[1]},q[2],m1[2]);
Mux mux11 ({sub1[1],m0[0]},q[2],m1[1]);
Mux mux12 ({sub1[0], A[2]},q[2],m1[0]);

add_sub_4bit as4_2 ({m1[2],m1[1],m1[0],A[1]},B, cin, q[1], sub2 );
Mux mux20 ({sub2[2],m1[1]},q[1],m2[2]);
Mux mux21 ({sub2[1],m1[0]},q[1],m2[1]);
Mux mux22 ({sub2[0], A[1]},q[1],m2[0]);

add_sub_4bit as4_3 ({m2[2],m2[1],m2[0],A[0]},B, cin, q[0], sub3 );
Mux mux30 ({sub3[3],m2[2]},q[0],R[3]);
Mux mux31 ({sub3[2],m2[1]},q[0],R[2]);
Mux mux32 ({sub3[1],m2[0]},q[0],R[1]);
Mux mux33 ({sub3[0], A[0]},q[0],R[0]);


endmodule