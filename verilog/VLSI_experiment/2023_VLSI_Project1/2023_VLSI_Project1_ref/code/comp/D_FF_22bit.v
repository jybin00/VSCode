module D_FF_22bit (q, d, clk, reset);

output [22-1:0] q;
input  [22-1:0] d;
input  clk, reset;

reg    [22-1:0] q;

always @ (posedge clk) begin
    if(~reset)
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule