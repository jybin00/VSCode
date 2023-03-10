`include "CSA.v"  // 앞에서 만든 CSA를 불로 옴.
`timescale 100ps/1ps // #1 = 100ps를 쉰다. 오차 시간 = 1ps
module stimulus_carry_select_adder_20b; // 모듈 이름

wire [20:0] sum; // 합계
reg [19:0] a, b; // 입력되는 숫자
reg clk;   // 클락
reg reset; // 리셋 기능을 위한 변수

reg [19:0] mat_a_input [0:99]; // 100행 20열 짜리 레지스털
reg [19:0] mat_b_input [0:99];
reg [20:0] mat_sum_output [0:99];

initial
begin
	clk <= 1;
	reset <= 0;
	#10
	reset <= 1;
end

always #5 clk <= ~clk;


CSA csa0 (.Out(sum), .A(a), .B(b), .clk(clk), .reset(reset));


integer i;
initial
begin
    $dumpfile("stimulus_carry_select_adder_20b.vcd");
    $dumpvars(0,stimulus_carry_select_adder_20b);
	$readmemh("a_input_20b.txt", mat_a_input);
	$readmemh("b_input_20b.txt", mat_b_input);
	i = 0;
	#(10);

	for(i = 0; i < 100; i++)
	begin
		a = mat_a_input[i];
		b = mat_b_input[i];
		#(10);
	end
	$finish;
end

integer k;
integer err;
reg [22:0] mat_sum;

initial
begin
    $dumpfile("stimulus_carry_select_adder_20b.vcd");
    $dumpvars(0,stimulus_carry_select_adder_20b);
	$readmemh("sum_output_20b.txt", mat_sum_output);
	err = 0;
	k = 0;
	#(20);

	for(k = 0; k < 100; k = k + 1)
	begin
		mat_sum <= mat_sum_output[k];
		if((sum != mat_sum))
			err = err + 1;
		#(10);
	end
$finish;

end


endmodule
