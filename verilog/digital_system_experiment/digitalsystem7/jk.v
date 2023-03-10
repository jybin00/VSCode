`include "dff.v"
module JK_FF(CLK, set, J, K, Q, nQ);
  input CLK, J, K, set;
  output Q,  nQ;
  wire w1;
  assign w1 = (J & nQ) | (~K & Q);
  D_FF F1(CLK, w1, set, Q, nQ); 
endmodule