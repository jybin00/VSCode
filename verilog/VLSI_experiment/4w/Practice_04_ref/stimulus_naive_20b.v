`timescale 1 ns / 1 ns
`include "naive_carry_select_adder_20b.v"
module stimulus_naive_20b;

	wire [21-1:0] sum_naive;
	reg [20-1:0] a, b;
	reg clk;
	reg rstn;

	reg [20-1:0] mat_a_input [0:99]; // 20bit짜리 reg 100개 선언
	reg [20-1:0] mat_b_input [0:99];
	reg [21-1:0] mat_sum_output [0:99];
	reg [21-1:0] mat_sum;
	
	integer i;
	integer k;
	integer err;

	naive_carry_select_adder_20b ADD0(.sum(sum_naive), .a(a), .b(b), .cin(1'b0), .clk(clk), .rstn(rstn));

	always #5 clk <= ~clk;

	initial	begin
		clk <= 1; rstn <= 0;
		#12 rstn <=1;
		#1050 $stop;
	end

	initial begin
		$dumpfile("stimulus_naive_20b.vcd");
    	$dumpvars(0, stimulus_naive_20b);
		$readmemh("a_input_20b.txt", mat_a_input);
		$readmemh("b_input_20b.txt", mat_b_input);
		$readmemh("sum_output_21b.txt", mat_sum_output);

		i = 0;
		err = 0;

		#(20);
		for(i = 0; i < 100; i = i + 1) begin
			a = mat_a_input[i];
			b = mat_b_input[i];
			mat_sum = mat_sum_output[i-1];
			#(10);
			if(sum_naive != mat_sum) begin
				err = err + 1;
			end
		end
	end

	endmodule