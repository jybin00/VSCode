module sr_latch(s, r, Q, nQ);
  input s,r;
  output Q, nQ;
  assign Q = ~ (s & nQ);
  assign nQ = ~ (r & Q);
endmodule