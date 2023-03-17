module stimulus_FA_16bit_with_DFF;

wire [17-1:0] sum;
reg [16-1:0]  a, b;
reg [17-1:0] mat_sum;
reg clk;
reg reset;

reg [16-1:0] mat_a_input [0:99];
reg [16-1:0] mat_b_input [0:99];
reg [17-1:0] mat_sum_output [0:99];

Full_adder_16bit_with_DFF gate1(.sum(sum), .a(a), .b(b), .c_in(1'b0), .clk(clk), .reset(reset)); // c_in is 1'b0

integer i;
integer err;

initial
	clk = 1'b0;	//set clk to 0
always
	#5 clk = ~clk;	
initial
begin
	
	reset = 1'b1;
	#0 reset = 1'b0;
	$readmemh("a_input.txt", mat_a_input);
	$readmemh("b_input.txt", mat_b_input);
	$readmemh("sum_output.txt", mat_sum_output);

	i = 0;
	err = 0;
	#(10);

	for(i = 0; i < 100; i = i + 1)
	begin
		a = mat_a_input[i];
		b = mat_b_input[i];
		mat_sum = mat_sum_output[i-1];
		#(2)
		if(sum != mat_sum)
			err = err + 1;
		#(8);
	end
	#(20)
	$stop;
end


endmodule