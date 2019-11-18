`include "jk.v"
`timescale 100ps/1ps
module jk_tb;

reg clk, set, j, k;
wire Q, nQ;


always #2.5 clk <= ~clk;

 JK_FF jk_ff(clk,set,j,k,Q,nQ);

initial begin
    $dumpfile("jk_tb.vcd");
    $dumpvars(0,jk_tb);
    clk <= 1; set <= 0;
    j<= 0; k<= 0; #10;
    j<= 0; k<= 1; #10;
    j<= 1; k<= 0; #10;
    j<= 1; k<= 1; #10;
    j<= 0; k<= 0; #10;
    j<= 0; k<= 1; #10;
    j<= 1; k<= 0; #10;
    j<= 1; k<= 1; #10;
    $finish;
    end


endmodule