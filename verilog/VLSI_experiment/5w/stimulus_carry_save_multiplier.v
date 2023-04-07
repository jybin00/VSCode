`timescale 1 ns / 1 ns
//`include "multiplier_rca_26b.v"
`include "multiplier_csa_26b.v"
module stimulus_carry_save_multiplier;

	wire [52-1:0] mul_out_rca, mul_out_csa;
	reg [26-1:0] a, b;
	reg clk;
	reg rstn;

	reg [26-1:0] mat_a_input [0:99];
	reg [26-1:0] mat_b_input [0:99];
	reg [52-1:0] mat_mult_output [0:99];
	reg [52-1:0] mat_out;

	integer i;
	integer k;
	integer err;

	//multiplier_rca_26b MULT0(mul_out_rca, a, b, clk, rstn);
	multiplier_csa_26b MULT1(mul_out_csa, a, b, clk, rstn);

	always #5 clk <= ~clk;

	initial	begin
		clk <= 1; rstn <= 0;
		#12
		rstn <= 1;
		#1050 $stop;
	end

	initial	begin
		$dumpfile("stimulus_carry_save_multiplier.vcd");
    	$dumpvars(0, stimulus_carry_save_multiplier);
		$readmemh("Practice_05_ref/a_input.txt", mat_a_input);
		$readmemh("Practice_05_ref/b_input.txt", mat_b_input);
		$readmemh("Practice_05_ref/mult_output.txt", mat_mult_output);
		i = 0;
		err = 0;
		#(20);

		for(i = 0; i < 100; i = i + 1)
		begin
			a = mat_a_input[i];
			b = mat_b_input[i];
			mat_out <= mat_mult_output[i-1];
			#(5);
			if((mul_out_rca != mat_out) || (mul_out_csa != mat_out))
				err = err + 1;
			#(5);
		end

		$finish;
	end

endmodule
