`include "line_decoder.v"
module line_decoder_tb;

reg [3:0]A;
wire [3:0]B;
integer i;

line_decoder ld(A,B);
initial begin
    $dumpfile("line_decoder_tb.vcd");
    $dumpvars(0,line_decoder_tb); // 여기에는 모듈 이름 써야됨. 파일 제목 x
    for (i = 4'b0000; i <= 4'b1111; i = i+1)
    begin
        A <= i;
        #10;
    end
    $finish;
end

endmodule