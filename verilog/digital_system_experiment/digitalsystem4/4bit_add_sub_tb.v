`include "4bit_add_sub.v"
`timescale 100ps/1ps

module add_sub_4bit_tb;

reg [3:0]A,B;
reg cin;
wire [3:0]sum;
wire cout;
wire [4:0]sum_f;
integer i,j,k;

add_sub_4bit a_s0 (A,B,cin,cout,sum,sum_f);

initial begin
    $dumpfile("4bit_add_sub_tb.vcd");
    $dumpvars(0,add_sub_4bit_tb); // 여기에는 모듈 이름 써야됨. 파일 제목 x
    for(i = 4'b0000; i <= 4'b0001; i++)
	begin
        cin <= i;
		for(j=4'b0000; j <=4'b1111; j++)
        begin
            B <= j;
            for(k=4'b0000; k<=4'b1111; k++)
            begin
                A <= k; #10;
            end
        end
	end
    $finish;
end

endmodule
