module D_FF_8bit (q, d, clk, reset);

output [8-1:0] q;
input  [8-1:0] d;
input  clk, reset;

reg    [8-1:0] q;

always @ (posedge clk) begin
    if(~reset)
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule