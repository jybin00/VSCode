`include "top_memory_test.v"
`timescale 1ns / 10ps

module DCT_sti;

reg clk;
reg rstn;

wire [176-1:0] X_k_out;
wire [128-1:0] x_n_in;

top_memory_test TEST(clk, rstn); // define input & output ports of your top module by youself 


always #5 clk <= ~clk;

initial begin
	$dumpfile("DCT_sti.vcd");
	$dumpvars(0, DCT_sti);
	clk = 1; rstn = 0;
	#10
	rstn = 1;
end

initial	$readmemh("../matlab_data_0530/image_in_1.txt", TEST.MEM_IN.array); //input image, check the path of memory rocation (module instance)


integer i;
integer fp;

initial begin

	#1640; //change if you need

	$finish;
end


endmodule
