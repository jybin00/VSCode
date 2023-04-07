`timescale 1 ns / 1 ps
module stimulus_naive_26b;

	wire [27-1:0] sum_naive;
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

	naive_carry_select_adder_26b ADD0(.sum(sum_naive), .a(a), .b(b), .cin(1'b0), .clk(clk), .rstn(rstn));

	always #5 clk <= ~clk;

	initial	begin
		clk <= 1; rstn <= 0;
		#12 rstn <=1;
		#1050 $stop;
	end

	initial begin
		$readmemh("a_input_26b.txt", mat_a_input);
		$readmemh("b_input_26b.txt", mat_b_input);

		i = 0;
		#(20);
		for(i = 0; i < 100; i = i + 1) begin
			a = mat_a_input[i];
			b = mat_b_input[i];
			#(10);
		end
	end

	initial begin
		$readmemh("sum_output_27b.txt", mat_sum_output);

		k = 0;
		err = 0;
		#(30);
		for(k = 0; k < 100; k = k + 1) begin
			mat_sum = mat_sum_output[k];			
			#(2);
			if(sum_naive != mat_sum) begin
				err = err + 1;
			end
			#(8);
		end
	end

	endmodule