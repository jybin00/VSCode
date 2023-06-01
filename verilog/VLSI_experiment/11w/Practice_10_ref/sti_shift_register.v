`timescale 1ns/10ps
`include "FIFO4.v"

module sti_shift_register;

    reg clk, rstn;
	wire [24-1:0] out;
	reg [24-1:0] sig_A [0:1023];
	reg [24-1:0] A, B;

	FIFO4 SR(out, A, clk, rstn);
	
    initial
	begin
		clk = 1;
		rstn = 0;
		#20
		rstn = 1;
	end
	
	always #5 clk = ~clk;
    integer i=0, err = 0;

	initial
	begin	
		$readmemh("complex_add/ArAi.txt", sig_A);
    end

	initial
	begin
		$dumpfile("sti_shift_register.vcd"); //결과 파일 이름 설정
    	$dumpvars(0, sti_shift_register); //모니터링할 신호 설정
		begin
			#20;
			for (i=0; i<1024; i=i+1)
			begin
				A = sig_A[i];
				B = sig_A[i-4];
				#10;
				if (out != B ) err = err + 1;
				
			end
		end
		$finish;
	end


endmodule
	
	

