`timescale 10ns/1ns
`include "counter.v"
module RES_UPDNC_tb;
  reg RESETN, CLK, UD;
  wire [3:0] Q;
  RES_UPDNC test(RESETN, CLK, ~UD, Q);
  integer i;  
  initial begin
    $dumpfile("counter_tb.vcd");
    $dumpvars(0,RES_UPDNC_tb);
    RESETN<=0;  
    CLK <= 0;
    UD<=0;
    #1 RESETN<=1;
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