`include "div.v"
`timescale 100ps/1ps

module divier_tb;

reg[3:0]A,B;
wire [3:0]Q,R;

divider div0(A,B,Q,R);

initial begin
$dumpfile("div_tb.vcd");
$dumpvars(0,divier_tb); // 여기에는 모듈 이름 써야됨. 파일 제목 x
A <= 4'b1010; B <= 4'b0011; #10;
A <= 4'b0101; B <= 4'b0101; #10;
A <= 4'b0111; B <= 4'b0010; #10;
$finish;
end




endmodule