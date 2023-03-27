module D_FF_26bit (q, d, clk, reset);

output [26-1:0] q;
input  [26-1:0] d;
input  clk, reset;

reg    [26-1:0] q;

always @ (negedge clk) begin
    if(reset)
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule