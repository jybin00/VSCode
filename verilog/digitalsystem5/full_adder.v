module full_adder(A,B,cin,sum,cout);

input A,B;
input cin;
output sum,cout;

wire t1,t2,t3;

xor(t1,A,B);
and(t2,A,B);
xor(sum,t1,cin);
and(t3,t1,cin);
or(cout,t3,t2);

endmodule
