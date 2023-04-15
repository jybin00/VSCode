`timescale 1 ns / 10 ps
`include "Top_MBIST.v"
module stimulus_Top_MBIST;

	reg clk;
	reg rstn;
	reg MBIST_start;

	wire [52-1:0] out;
	wire out_done;

	Top_MBIST MBIST_TEST(.DATA_out(out), .MBIST_done(out_done), .MBIST_start(MBIST_start), .clk(clk), .rstn(rstn));

	always #5 clk <= ~clk;

	initial	
	begin
		$dumpfile("stimulus_Top_MBIST.vcd");
    	$dumpvars(0, stimulus_Top_MBIST);
		clk <= 1; rstn <= 0; MBIST_start <= 0;
		#20
		MBIST_start <= 1;
		#10
		MBIST_start <= 0; rstn <= 1; 
		#10300 $stop;
		$finish;
	end

endmodule
