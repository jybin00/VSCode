`include "a.v"
`timescale 100ps/1ps
module a_tb;

reg a,b;
wire c;

and_module A1(a,b,c);

initial begin
$dumpfile("a_tb.vcd");
$dumpvars(0,a_tb);
       a <= 1'b0; b <= 1'b0;
 #1;   a <= 1'b0; b <= 1'b1;
 #1;   a <= 1'b1; b <= 1'b0;
 #1;   a <= 1'b1; b <= 1'b1;
 #1;
 $finish;
end


endmodule // a_tba,b,c
