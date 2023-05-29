
`timescale 1ns/10ps
module sti_FFT;

	reg clk, reset;

    reg [24-1:0] mat_in [0:1023];
	reg [24-1:0] in;
	reg [24-1:0] mat_out [0:1023];
	reg [24-1:0] out_mat;

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
		$readmemh("input_FFT.txt", mat_in);
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
		$readmemh("output_FFT.txt", mat_out);
		begin
			#(200); //change if needed
			for (j=0; j<1024; j=j+1)
			begin
				out_mat <= mat_out[j];
				if (out_mat != out) err = err + 1;
				#(10);
			end
		end
	end





endmodule
	
	

