module T_FF (q, clk, reset);

output q;
input clk, reset;

wire d;

D_FF dff0 (g, d, clk, reset);

not n1(d, a);
endmodule