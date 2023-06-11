`timescale 1ns / 10ps
`include "top_memory_test.v"
module sti_project2;

reg clk;
reg rstn;


top_memory_test TEST(clk,reset); // define input & output ports of your top module by youself 


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
	//fp = $fopen("DCT_image_1.txt","w"); //output image, this is the output file that finished 2D-DCT operations.

	//#328040; //change if you need
	#30000;

	// for (i = 0; i<16384; i=i+1)	begin
	// 	$display("DATA %b", TEST.MEM_OUT.array[i]); //check the path of memory rocation (module instance)
	// 	$fwrite(fp,"%b\n",   TEST.MEM_OUT.array[i]); //check the path of memory rocation (module instance)
	// end
   
	#100
	//$fclose(fp);  
	$finish;
end


endmodule
