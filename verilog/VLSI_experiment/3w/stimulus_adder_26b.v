`timescale 1 ns / 10 ps

//`include "Full_adder_26bits_DFF.v"
`include "Square_Root_CSA_26bits_DFF.v"

module stimulus_adder_26b;

	wire [27-1:0] sum_rca, sum_csa;
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

	//Full_adder_26bits_DFF       RCA1(sum_rca, a, b, 1'b0, clk, rstn);
	Square_Root_CSA_26bits_DFF	CSA1(sum_csa, a, b, 1'b0, clk, rstn);

	always #5 clk <= ~clk;

	initial	begin
		clk <= 1; rstn <= 0;
		#2 rstn <=1;
		#10 rstn <= 0;
		#1050; $stop;
		$finish;
	end

	initial begin
		$dumpfile("stimulus_adder_26b.vcd");
    	$dumpvars(0, stimulus_adder_26b);
		$readmemh("Practice_03_ref/a_input.txt", mat_a_input);
		$readmemh("Practice_03_ref/b_input.txt", mat_b_input);
		$readmemh("Practice_03_ref/sum_output.txt", mat_sum_output);

		i = 0;
		k = 0;
		err = 0;
		#(15);
		for(i = 0; i < 100; i = i + 1) begin
			a = mat_a_input[i];
			b = mat_b_input[i];
			mat_sum = mat_sum_output[i-1];
			#(6);
			//if((sum_csa != mat_sum)) begin
			if((sum_rca != mat_sum)||(sum_csa != mat_sum)) begin
				err = err + 1;
			end
			#(4);
		end
		$finish;
	end

endmodule