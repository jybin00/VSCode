`include "D_FF.v"

module T_FF (q, clk, reset);

output q;
input clk, reset;

wire d;

D_FF dff0 (q, d, clk, reset);
not n1(d, q);

endmodule