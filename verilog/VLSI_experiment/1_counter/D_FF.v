module D FF(q, d, clk, reset);

output 1;
input d, clk, reset;
reg a;

always @ (negedge clk)
begin if (reset) q <= 1'b0;
else g <= d;

end
endmodule