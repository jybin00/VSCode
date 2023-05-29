`timescale 1ns/10ps
`include "Butterfly.v"

module sti_Butterfly;

	wire [24-1:0]	C1, C2;

	reg [24-1:0] sig_A [0:1023];
	reg [24-1:0] sig_B [0:1023];
	reg [24-1:0] sig_C1 [0:1023];
	reg [24-1:0] sig_C2 [0:1023];
	
	reg [24-1:0] A;
	reg [24-1:0] B;
	reg [24-1:0] C;
	reg [24-1:0] D;

	Butterfly BF(C1, C2, A, B);
	
	initial
	begin
		$readmemh("complex_add/ArAi.txt", sig_A);
		$readmemh("complex_add/BrBi.txt", sig_B);
		$readmemh("complex_add/C1rC1i.txt", sig_C1);
		$readmemh("complex_add/C2rC2i.txt", sig_C2);
	end
	
	integer i=0;
	integer err = 0;	
	initial
	begin		
		$dumpfile("sti_Butterfly.vcd");
		$dumpvars(0, sti_Butterfly);
		for (i=0; i<1024; i=i+1)
		begin
			A = sig_A[i];
			B = sig_B[i];
			C = sig_C1[i];
			D = sig_C2[i];
			#(10);
			if((C1 != C)||(C2 != D)) err = err + 1;
		end
		$finish;
	end


endmodule
	
	

