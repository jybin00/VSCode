`timescale 1 ns / 10 ps
`include "Top_memory_control.v"

module stimulus_Top_memory_control;
	reg [52-1:0] mat_output [0:255];
	reg [52-1:0] mat_out;
	reg clk;
	reg rstn;
	wire [52-1:0] out;

	Top_memory_control MEM_TEST(.DATA_out(out), .clk(clk), .rstn(rstn));

	always #5 clk <= ~clk;
	
	initial begin
		clk <= 1; rstn <= 0;
		#10
		rstn <= 1;
		#10260 $stop;
	end
	
	
	integer i = 0;
	integer err = 0;
	
	initial	$readmemh("input.txt", MEM_TEST.MEMORY.array);
	initial $readmemh("output.txt", mat_output);
	
	initial begin
		$dumpfile("stimulus_Top_memory_control.vcd");
    	$dumpvars(0, stimulus_Top_memory_control);
		// #(10250);
		#(5140);

		for(i = 0; i < 128; i = i + 1) begin
			mat_out <= mat_output[i];
			#(10);
			if(out != mat_out) err = err + 1;
			#(30);
		end
		$finish;
	end
	
	
endmodule
			