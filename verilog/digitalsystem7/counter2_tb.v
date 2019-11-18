`timescale 10ns/1ns
`include "counter2.v"
module RES_UPDNC_tb;
  reg RESETN, CLK, UD;
  wire [3:0] Q;
  updncounter test(RESETN, CLK, UD, Q);
  integer i;  
  initial begin
    $dumpfile("counter2_tb.vcd");
    $dumpvars(0,RES_UPDNC_tb);
    RESETN<=1;  
    CLK <= 0;
    UD<=0;
    #1 RESETN<=0;
    #1 RESETN<=0;
    for(i=0; i<32; i=i+1)begin
     #2 CLK<=~CLK;
   end
    UD<=1;
    for(i=0; i<32; i=i+1)begin
     #2 CLK<=~CLK;
    end
    $finish;
  end
endmodule