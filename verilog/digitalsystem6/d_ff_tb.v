`include "d_ff.v"
`timescale 100ps/1ps
module d_ff_tb;

reg clk, D, set;
wire Q, nQ;

always #2.5 clk <= ~clk;

D_FF d_ff(clk,D,set,Q,nQ);

initial begin
    $dumpfile("d_ff_tb.vcd");
    $dumpvars(0,d_ff_tb);
    clk <= 1; set <= 0;
    D <= 0; #10;
    D <= 0; #10;
    D <= 1; #10;
    D <= 1; #10;
    $finish;
    end


endmodule