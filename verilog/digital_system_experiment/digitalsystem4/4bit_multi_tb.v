`include "4bit_multi.v"
`timescale 100ps/1ps

module multi_4bit_tb;

reg [3:0] A,B;
reg cin;
wire [7:0] C;
integer i,j;

multi_4bit multi0(A,B,C,cin);

initial begin
    $dumpfile("4bit_multi_tb.vcd");
    $dumpvars(0,multi_4bit_tb); // 여기에는 모듈 이름 써야됨. 파일 제목 x
    cin <= 1'b0;
    for(i=4'b0000; i<= 4'b1111; i++) begin
        B <= i;
        for(j=4'b0000; j<= 4'b1111; j++) begin
            A <= j; #10;
        end
    end
    $finish;
end

endmodule
