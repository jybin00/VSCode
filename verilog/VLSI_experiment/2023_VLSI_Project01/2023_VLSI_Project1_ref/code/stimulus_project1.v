`timescale 1ns / 100ps
`include "Top_controller.v"


module stimulus_project1;

	reg [22-1:0] mat_output [0:4096-1];
	reg [22-1:0] mat_out;
	reg [22-1:0] out;
	reg clk;
	reg rstn;
	reg start;

	wire done;

	Top_controller CON(.done(done), .start(start), .clk(clk), .rstn(rstn));


	always #5 clk <= ~clk;
	
	integer i = 0;
	integer err = 0;
	
	initial	$readmemh("vec_a.txt", CON.MEM_A.array);
	initial	$readmemh("vec_b.txt", CON.MEM_B.array);
	initial $readmemh("vec_c.txt", mat_output);


	initial begin
		$dumpfile("stimulus_project1.vcd");
		$dumpvars(0, stimulus_project1);
		clk = 1; rstn = 0; start = 0;
		#10
		rstn = 1;
		#10 start = 1;
		#10 start = ~start;
		#2622000
		if(done) begin
			for(i = 0; i < 4096; i = i + 1) begin
				
				mat_out <= mat_output[i];
				out     <= CON.MEM_C.array[i];
				#(2);
				if(out != mat_out) err = err + 1;
				#(8);
			end
			// #10 $stop;
		end
		#1000 $stop;
		
	end


	
	
endmodule
			