`include "Full_adder_13bits.v"
`include "D_FF_26bit.v"
`include "D_FF_27bit.v"

module Full_adder_26bits_pipe (sum_output, a_input, b_input, c_in, clk, reset);

    output [27-1:0] sum_output;  // module에서는 input, output이 wire로 선언됨. 
    input [26-1:0] a_input, b_input; // module에서는 reg는 behavior level에서만 사용 할 수 있음.
    input clk, reset;
    input c_in;

    wire [14-1:0] sum1;
    wire [14-1:0] sum2;
    wire [13-1:0] sum_2p;

    wire [13-1:0] a1_1, b1_1 ;
    wire [13-1:0] a1_2, b1_2 ;
    wire [13-1:0] a2_p, b2_p ;

    wire c_in_s1, c_in_s2;

    D_FF_26bit dff26_A  ( {a1_2, a1_1}, a_input, clk, reset);  // 처음에 맨 위에 달려 있는 DFF
    D_FF_26bit dff26_B  ( {b1_2, b1_1}, b_input, clk, reset);
    D_FF_1bit  dff01_Cin( c_in_s1, c_in, clk, reset);        // 첫번재 스테이지 캐리 저장

    Full_adder_13bits Stage1_adder (sum1, a1_1, b1_1, c_in_s1);  // 첫번째 스테이지 에더

    D_FF_1bit  dff01_pCout( c_in_s2, sum1[13], clk, reset);        // 첫번재 스테이지 캐리 저장
    D_FF_13bit dff13_pSum ( sum_2p, sum1[13-1:0], clk, reset); // 첫번째 스테이지 섬 저장

    D_FF_13bit dff13_pA ( a2_p, a1_2, clk, reset);  // pipeline 을 위한 13bit DFF
    D_FF_13bit dff13_pB ( b2_p, b1_2, clk, reset);

    Full_adder_13bits Stage2_adder (sum2, a2_p, b2_p, c_in_s2);       // 두번재 스테이지 에더

    D_FF_27bit Sum_Out  ( sum_output, {sum2, sum_2p}, clk, reset);


endmodule

module D_FF_1bit (q, d, clk, reset);

output q;
input  d;
input  clk, reset;

reg    q;

always @ (posedge clk) begin
    if(~reset)      // reset == 0이면 리셋
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule

module D_FF_13bit (q, d, clk, reset);

output [13-1:0] q;
input  [13-1:0] d;
input  clk, reset;

reg    [13-1:0] q;

always @ (posedge clk) begin
    if(~reset)      // reset == 0이면 리셋
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule

module D_FF_26bit (q, d, clk, reset);
output [26-1:0] q;
input  [26-1:0] d;
input  clk, reset;

reg    [26-1:0] q;

always @ (posedge clk) begin
    if(~reset)
        q <= 1'b0;
    else 
	q <= d;
end
endmodule

module D_FF_27bit (q, d, clk, reset);
output [27-1:0] q;
input  [27-1:0] d;
input  clk, reset;

reg    [27-1:0] q;

always @ (posedge clk) begin
    if(~reset)
        q <= 1'b0;
    else 
	q <= d;
end
endmodule
