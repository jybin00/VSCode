`include "top_memory_test.v"
`timescale 1ns / 10ps

module DCT_sti;

reg clk;
reg rstn;

wire [176-1:0] X_k_out;
wire [128-1:0] x_n_in;
reg [11-1:0] test_vec [0:512*16];

reg [11-1:0] X0;
reg [11-1:0] X1;
reg [11-1:0] X2;
reg [11-1:0] X3;
reg [11-1:0] X4;
reg [11-1:0] X5;
reg [11-1:0] X6;
reg [11-1:0] X7;
reg [11-1:0] X8;
reg [11-1:0] X9;
reg [11-1:0] X10;
reg [11-1:0] X11;
reg [11-1:0] X12;
reg [11-1:0] X13;
reg [11-1:0] X14;
reg [11-1:0] X15;
wire [11-1:0] test_X0, test_X1, test_X2, test_X3, test_X4, test_X5, test_X6, test_X7, test_X8;
wire [11-1:0] test_X9, test_X10, test_X11, test_X12, test_X13, test_X14, test_X15;

top_memory_test TEST(clk, rstn); // define input & output ports of your top module by youself 


always #5 clk <= ~clk;

initial $readmemh("../matlab_data_0530/image1_2D_Xk.txt", test_vec);

initial begin
	$dumpfile("DCT_sti.vcd");
	$dumpvars(0, DCT_sti);
	clk = 1; rstn = 0;
	#10
	rstn = 1;
end

initial	$readmemh("../matlab_data_0530/image_in_1.txt", TEST.MEM_IN.array); //input image, check the path of memory rocation (module instance)


integer i = 0;
integer fp;
integer err1 = 0;
integer err2 = 0;

assign test_X0 = TEST.DCT.DCT_col.X_0_trunc;
assign test_X1 = TEST.DCT.DCT_col.X_1_trunc;
assign test_X2 = TEST.DCT.DCT_col.X_2_trunc;
assign test_X3 = TEST.DCT.DCT_col.X_3_trunc;
assign test_X4 = TEST.DCT.DCT_col.X_4_trunc;
assign test_X5 = TEST.DCT.DCT_col.X_5_trunc;
assign test_X6 = TEST.DCT.DCT_col.X_6_trunc;
assign test_X7 = TEST.DCT.DCT_col.X_7_trunc;
assign test_X8 = TEST.DCT.DCT_col.X_8_trunc;
assign test_X9 = TEST.DCT.DCT_col.X_9_trunc;
assign test_X10 = TEST.DCT.DCT_col.X_10_trunc;
assign test_X11 = TEST.DCT.DCT_col.X_11_trunc;
assign test_X12 = TEST.DCT.DCT_col.X_12_trunc;
assign test_X13 = TEST.DCT.DCT_col.X_13_trunc;
assign test_X14 = TEST.DCT.DCT_col.X_14_trunc;
assign test_X15 = TEST.DCT.DCT_col.X_15_trunc;



initial begin
	#10;
	// X0 ~ X15 are the input of your DCT module
	for (i = 0; i < 512; i=i+1) begin
		//test_X0 <= TEST.DCT.X_0_trunc;
		X0  <= test_vec[i*16+ 0];
		X1  <= test_vec[i*16+ 1];
		X2  <= test_vec[i*16+ 2];
		X3  <= test_vec[i*16+ 3];
		X4  <= test_vec[i*16+ 4];
		X5  <= test_vec[i*16+ 5];
		X6  <= test_vec[i*16+ 6];
		X7  <= test_vec[i*16+ 7];
		X8  <= test_vec[i*16+ 8];
		X9  <= test_vec[i*16+ 9];
		X10 <= test_vec[i*16+10];
		X11 <= test_vec[i*16+11];
		X12 <= test_vec[i*16+12];
		X13 <= test_vec[i*16+13];
		X14 <= test_vec[i*16+14];
		X15 <= test_vec[i*16+15];
		if(X0 != test_X0 || X1 != test_X1 || X2 != test_X2 || X3 != test_X3 || X4 != test_X4 || X5 != test_X5 || X6 != test_X6 || X7 != test_X7) begin
			//$display("X0 error at %d", i);
			err1 = err1 + 1;
		end
		if(X8 != test_X8 || X9 != test_X9 || X10 != test_X10 || X11 != test_X11 || X12 != test_X12 || X13 != test_X13 || X14 != test_X14 || X15 != test_X15) begin
			//$display("X0 error at %d", i);
			err2 = err2 + 1;
		end
		#(10);
	end

	$finish;
end


endmodule
