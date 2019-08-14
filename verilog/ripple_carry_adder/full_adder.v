`include "half_adder.v"

module full_adder (A,B,Cin,Cout,S);

input A, B, Cin;
output Cout, S;
wire xor_out, half_out, and_out;

xor xor0(xor_out,A,B);
or or0(Cout,half_out,and_out);
half_adder h0(S,half_out,xor_out,Cin);
and and0(and_out,A,B);

endmodule