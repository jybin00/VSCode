`timescale 1ns/10ps
`include "Top_folded_FIR.v"
module stimulus_folded_FIR_filter;

	wire signed [22-1:0] out;

	wire signed [12-1:0] c0 = 12'h25d;
	wire signed [12-1:0] c1 = 12'hc9d;
	wire signed [12-1:0] c2 = 12'h41d;
	wire signed [12-1:0] c3 = 12'hca0;
	wire signed [12-1:0] c4 = 12'h652;

	reg clk20, clk100, rstn;

	reg signed [22-1:0] sig_mat [0:251];
	reg signed [22-1:0] out_mat;
	
	Top_folded_FIR FIR(out, clk100, clk20, rstn, c0, c1, c2, c3, c4);
	
	initial
	begin
		clk100  <= 1;
		clk20   <= 1;
		rstn    <= 0;
		#10
		rstn    <= 1;
		#13070 $stop;
	end
	
	always #5 clk100 = ~clk100;
	always #25 clk20 = ~clk20;
	
	initial $readmemh("input_vector_hex.txt", FIR.DIRECT_INPUT_MEM.array);
	initial $readmemh("output_vector_hex.txt", sig_mat);
	integer i=0;	
	integer err=0;
	initial
	begin		
		$dumpfile("stimulus_folded_FIR_filter.vcd");
		$dumpvars(0,stimulus_folded_FIR_filter);
		#(400);//change the timing if needed
		for (i=0; i<252; i=i+1)
		begin
			out_mat <= sig_mat[i];
			#(10);
			if(out != out_mat) err <= err + 1;
			#(40);
		end
		$finish;
	end

endmodule
	
	


