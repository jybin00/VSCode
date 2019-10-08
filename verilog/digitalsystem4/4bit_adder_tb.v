`include "4bit_adder.v"
`timescale 100ps/1ps

module adder_4bit_tb;

reg [3:0]A,B;
reg cin;
wire [3:0]sum;
wire cout;
integer i,j,k;

adder_4bit fa4 (A,B,sum,cin,cout);

initial begin
    $dumpfile("4bit_adder_tb.vcd");
    $dumpvars(0,adder_4bit_tb); // 여기에는 모듈 이름 써야됨. 파일 제목 x
    for(i = 0; i < 1; i++)
	begin
        cin <= i;
		for(j=0; j <16; j++)
        begin
            B <= j;
            for(k=0; k<16; k++)
            begin
                A <= k; #10;
            end
        end
        $finish;
	end
end
endmodule
