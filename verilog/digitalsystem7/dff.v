`include"sr.v"
module D_FF(CLK, D, set, Q, nQ);
  input CLK, D, set;
  output Q, nQ;
  wire w1, w2, w3,  w4; 
  sr_latch L1(w4|set, CLK&(~set), w1, w2);
  sr_latch L2((CLK&w2)|set, D&(~set), w3,  w4);
  sr_latch L3(w2, w3, Q, nQ);
endmodule