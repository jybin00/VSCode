`timescale 1 ns / 1 ns
`include "Full_adder_26bits_pipe.v"
`include "SRCSA_26bit_pipe_top.v"

module stimulus_pipelined_26b;

	wire [27-1:0] sum_pipe_csa;
	wire [27-1:0] sum_pipe_rca;
	reg [26-1:0] a, b;
	reg clk;
	reg rstn;

	reg [26-1:0] mat_a_input [0:99];
	reg [26-1:0] mat_b_input [0:99];
	reg [27-1:0] mat_sum_output [0:99];
	reg [27-1:0] mat_sum;
	
	integer i;
	integer k;
	integer err;

	SRCSA_26bit_pipe_top CSA0(sum_pipe_csa, a, b, 1'b0, clk, rstn);
	Full_adder_26bits_pipe RCA0 (sum_pipe_rca, a, b, 1'b0, clk, rstn);

	always #5 clk <= ~clk;

	initial	begin
		clk <= 1; rstn <= 0;
		#12 rstn <=1;
		#1050 $stop;
	end

	initial begin
		$dumpfile("stimulus_pipelined_26b.vcd");
    	$dumpvars(0, stimulus_pipelined_26b);
		$readmemh("Practice_04_ref/a_input_26b.txt", mat_a_input);
		$readmemh("Practice_04_ref/b_input_26b.txt", mat_b_input);
		$readmemh("Practice_04_ref/sum_output_27b.txt", mat_sum_output);

		err = 0;
		i = 0;
		#(20);
		for(i = 0; i < 100; i = i + 1) begin
			a = mat_a_input[i];
			b = mat_b_input[i];
			mat_sum = mat_sum_output[i-2];			
			#(10);
			//if((sum_pipe_rca != mat_sum)) begin
			if((sum_pipe_csa != mat_sum) || (sum_pipe_rca != mat_sum)) begin
				err = err + 1;
			end
		end
		$finish;
	end

	endmodule