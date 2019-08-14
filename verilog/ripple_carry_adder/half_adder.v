module half_adder(out0,out1,in0,in1);

input in1, in0;
output out1, out0;

xor xor0(out0,in1,in0);
and and0(out1,in1,in0);

endmodule