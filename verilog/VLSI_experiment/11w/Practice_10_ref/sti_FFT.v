
`timescale 1ns/10ps
`include "top_FFT.v"
module sti_FFT;

	reg clk, reset;

    reg [24-1:0] mat_in [0:1023];
	reg [24-1:0] in;
	reg [24-1:0] mat_out [0:1023];
	reg [24-1:0] out_mat;
	wire [12-1:0]out_mat_i, out_mat_r;
	assign out_mat_i = out_mat[12-1:0], out_mat_r = out_mat[24-1:12];

    wire [24-1:0] out;
	
	
	top_FFT FFT(out, in, clk, reset);
	
	initial
	begin
		clk = 1;
		reset = 0;
		#12
		reset = 1;
	end
	
	always #5 clk = ~clk;
	
    integer i=0, j=0;

	initial
	begin		
		$readmemh("fft/input_FFT.txt", mat_in);
		begin
			#(20);
			for (i=0; i<1024; i=i+1)
			begin
				in = mat_in[i];
				#(10);
			end
		end
	end

	
	integer err = 0;	
	initial
	begin		
		$dumpfile("sti_FFT.vcd");
		$dumpvars(0, sti_FFT);
		$readmemh("fft/output_FFT.txt", mat_out);
		begin
			#(120); //change if needed
			for (j=0; j<1024; j=j+1)
			begin
				out_mat <= mat_out[j];
				if (out_mat != out) err = err + 1;
				#(10);
			end
		end
		$finish;
	end




endmodule
	
	

