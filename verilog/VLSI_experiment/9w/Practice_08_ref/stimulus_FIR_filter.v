`timescale 1 ns / 10 ps
`include "top_FIR_filter.v"
module stimulus_FIR_filter;

	reg [22-1:0] sig_mat [0:256-1];
	reg [22-1:0] out_mat;
	reg clk, rstn;
 
        wire    [12-1:0] c0 = 12'h25d ;
        wire    [12-1:0] c1 = 12'hc9d ;
        wire    [12-1:0] c2 = 12'h41d ;
        wire    [12-1:0] c3 = 12'hca0 ;
        wire    [12-1:0] c4 = 12'h652 ;
	
	top_FIR_filter FIR(clk, rstn, c0, c1, c2, c3, c4 );

	always #5 clk = ~clk;
	
	initial begin
		clk <= 1; rstn <= 0;
		#10
		rstn <= 1;
	end

	integer i = 0;
	integer err = 0;
	
	initial $readmemh("input_vector_hex.txt", FIR.DIRECT_INPUT_MEM.array); //check the path of memory rocation (module instance)
	//initial $readmemh("input_vector_hex.txt", FIR.TRANS_INPUT_MEM.array);  //check the path of memory rocation (module instance)

	initial $readmemh("output_vector_hex.txt", sig_mat);


	initial begin
		$dumpfile("stimulus_FIR_filter.vcd");
		$dumpvars(0, stimulus_FIR_filter);
		#(80); //simulate the latency yourself
		for (i=0; i<256; i=i+1) begin
			out_mat <= sig_mat[i];
			#(2);
			//if((FIR.Filter1.direct_out != out_mat) || (FIR.Filter2.trans_out != out_mat)) err = err + 1;
			if((FIR.Direct_filter.y_n != out_mat)) err = err + 1;
			#(8);
		end
		$finish;
	end

endmodule
	
	

