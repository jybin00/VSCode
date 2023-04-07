`include "Full_adder_1bit.v"
`include "MUX/mux10to5.v"
`include "MUX/mux12to6.v"
`include "MUX/mux14to7.v"
`include "MUX/mux16to8.v"

module SRCSA_26bit_pipe (sum_output, a, b, c_in, clk, reset);

output [27-1:0] sum_output; // ok
input  [26-1:0] a, b; // ok
input   c_in;
input   clk, reset;

wire [21:0] sum_z; // ok zero
wire [21:0] sum_o; // ok one

wire [4-1:0]  sum_d;  // 첫번재 dff으로 들어가는 sum .
wire [16-1:0] sum_d0; // dff으로 들어가는 input이 0일 때 sum.
wire [16-1:0] sum_d1; // dff으로 들어가는 input이 1일 때 sum.

wire [21:0] c_z; // carry zero ok
wire [21:0] c_o; // carry one ok

wire [6:0] c ; // ok
wire c_d;
wire [3:0] c_0, c_1;  // dff에서 나오는 carry.
wire a1, b1; // 5bit입력도 4 + 1bit으로 나누고 1bit은 따로 넣어줘야 함.
wire [1:0] a2, b2; // 6bit 입력도 4 + 2bit으로 나누고 2bit은 따로
wire [2:0] a3, b3; // 7bit 입력도 마찬가지.

//Stage 0
//FA 1 * 4
Full_adder_1bit FA1_1 ( sum_d[0], c[0], a[0], b[0], c_in );
Full_adder_1bit FA1_2 ( sum_d[1], c[1], a[1], b[1], c[0] ); 
Full_adder_1bit FA1_3 ( sum_d[2], c[2], a[2], b[2], c[1] ); 
Full_adder_1bit FA1_4 ( sum_d[3], c[3], a[3], b[3], c[2] ); 

D_FF_5bit DFF000 ({c_d, sum_output[3:0]}, {c[3],sum_d[3:0]}, clk, reset); // 스테이지 0

//Stage 1
//FA 4 * 2 + MUX
// c = 0
Full_adder_1bit FA4_1_0 ( sum_z[0], c_z[0], a[4], b[4], 1'b0 );
Full_adder_1bit FA4_2_0 ( sum_z[1], c_z[1], a[5], b[5], c_z[0] ); 
Full_adder_1bit FA4_3_0 ( sum_z[2], c_z[2], a[6], b[6], c_z[1] ); 
Full_adder_1bit FA4_4_0 ( sum_z[3], c_z[3], a[7], b[7], c_z[2] ); 
D_FF_5bit DFF100 ({c_0[0], sum_d0[3:0]}, {c_z[3], sum_z[3:0]}, clk, reset); // 파이파라인 관점에서 스테이지 0
// c = 1
Full_adder_1bit FA4_1_1 ( sum_o[0], c_o[0], a[4], b[4], 1'b1 );
Full_adder_1bit FA4_2_1 ( sum_o[1], c_o[1], a[5], b[5], c_o[0] ); 
Full_adder_1bit FA4_3_1 ( sum_o[2], c_o[2], a[6], b[6], c_o[1] ); 
Full_adder_1bit FA4_4_1 ( sum_o[3], c_o[3], a[7], b[7], c_o[2] ); 
D_FF_5bit DFF101 ({c_1[0], sum_d1[3:0]}, {c_o[3], sum_o[3:0]}, clk, reset);  // sum_o를 받아서 sum_d1으로 출력

// out, a, b, s
mux10to5 Mu1 ( {c[4], sum_output[7:4]}, {c_0[0], sum_d0[3:0]}, {c_1[0], sum_d1[3:0]}, c_d ); 
// sum_d0와 sum_d1을 받아서 c_d를 sel bit으로 삼아 둘 중 하나 출력.

//Stage 2
//FA 5 * 2 + MUX
// c = 0
Full_adder_1bit FA5_1_0 ( sum_z[4], c_z[4], a[8],  b[8],  1'b0 );
Full_adder_1bit FA5_2_0 ( sum_z[5], c_z[5], a[9],  b[9],  c_z[4] ); 
Full_adder_1bit FA5_3_0 ( sum_z[6], c_z[6], a[10], b[10], c_z[5] ); 
Full_adder_1bit FA5_4_0 ( sum_z[7], c_z[7], a[11], b[11], c_z[6] ); 
D_FF_5bit DFF200 ({c_0[1], sum_d0[7:4]}, {c_z[7], sum_z[7:4]}, clk, reset);

D_FF_1bit DFF10 (a1, a[12], clk, reset); // 입력을 받아서 가지고 있다가 클럭이 들어올 때 FA로 전송
D_FF_1bit DFF11 (b1, b[12], clk, reset);

Full_adder_1bit FA5_5_0 ( sum_z[8], c_z[8], a1, b1, c_0[1] ); 
// c = 1
Full_adder_1bit FA5_1_1 ( sum_o[4], c_o[4], a[8],  b[8],  1'b1 );
Full_adder_1bit FA5_2_1 ( sum_o[5], c_o[5], a[9],  b[9],  c_o[4] ); 
Full_adder_1bit FA5_3_1 ( sum_o[6], c_o[6], a[10], b[10], c_o[5] ); 
Full_adder_1bit FA5_4_1 ( sum_o[7], c_o[7], a[11], b[11], c_o[6] ); 
D_FF_5bit DFF201 ({c_1[1], sum_d1[7:4]}, {c_o[7], sum_o[7:4]}, clk, reset);

Full_adder_1bit FA5_5_1 ( sum_o[8], c_o[8], a1, b1, c_1[1] ); 

mux12to6 Mu2 ( {c[5], sum_output[12:8]}, {c_z[8], sum_z[8],sum_d0[7:4]}, {c_o[8], sum_o[8],sum_d1[7:4]}, c[4] );

//Stage 3
//FA 6 + MUX
// c = 0
Full_adder_1bit FA6_1_0 ( sum_z[9],  c_z[9],  a[13], b[13],  1'b0 );
Full_adder_1bit FA6_2_0 ( sum_z[10], c_z[10], a[14], b[14], c_z[9] ); 
Full_adder_1bit FA6_3_0 ( sum_z[11], c_z[11], a[15], b[15], c_z[10] ); 
Full_adder_1bit FA6_4_0 ( sum_z[12], c_z[12], a[16], b[16], c_z[11] ); 
D_FF_5bit DFF300 ({c_0[2], sum_d0[11:8]}, {c_z[12], sum_z[12:9]}, clk, reset);  // dff에서 나온 carry는 다음 FA의 cin으로!

D_FF_2bit DFF20 (a2[1:0], a[18:17], clk, reset);
D_FF_2bit DFF21 (b2[1:0], b[18:17], clk, reset);

Full_adder_1bit FA6_5_0 ( sum_z[13], c_z[13], a2[0], b2[0], c_0[2] ); 
Full_adder_1bit FA6_6_0 ( sum_z[14], c_z[14], a2[1], b2[1], c_z[13] ); 

// c = 1
Full_adder_1bit FA6_1_1 ( sum_o[9],  c_o[9],  a[13], b[13],  1'b1 );
Full_adder_1bit FA6_2_1 ( sum_o[10], c_o[10], a[14], b[14], c_o[9] ); 
Full_adder_1bit FA6_3_1 ( sum_o[11], c_o[11], a[15], b[15], c_o[10] ); 
Full_adder_1bit FA6_4_1 ( sum_o[12], c_o[12], a[16], b[16], c_o[11] ); 
D_FF_5bit DFF301 ({c_1[2], sum_d1[11:8]}, {c_o[12], sum_o[12:9]}, clk, reset);

Full_adder_1bit FA6_5_1 ( sum_o[13], c_o[13], a2[0], b2[0], c_1[2] ); 
Full_adder_1bit FA6_6_1 ( sum_o[14], c_o[14], a2[1], b2[1], c_o[13] ); 

mux14to7 Mu3 ( {c[6], sum_output[18:13]}, {c_z[14], sum_z[14:13], sum_d0[11:8]}, {c_o[14], sum_o[14:13], sum_d1[11:8]}, c[5] ); 

//Stage 4
//FA 7 + MUX
// c = 0
Full_adder_1bit FA7_1_0 ( sum_z[15], c_z[15], a[19], b[19],  1'b0 );
Full_adder_1bit FA7_2_0 ( sum_z[16], c_z[16], a[20], b[20], c_z[15] ); 
Full_adder_1bit FA7_3_0 ( sum_z[17], c_z[17], a[21], b[21], c_z[16] ); 
Full_adder_1bit FA7_4_0 ( sum_z[18], c_z[18], a[22], b[22], c_z[17] ); 
D_FF_5bit DFF400 ({c_0[3], sum_d0[15:12]}, {c_z[18], sum_z[18:15]}, clk, reset);

D_FF_3bit DFF30 (a3[2:0], a[25:23], clk, reset);
D_FF_3bit DFF31 (b3[2:0], b[25:23], clk, reset);

Full_adder_1bit FA7_5_0 ( sum_z[19], c_z[19], a3[0], b3[0], c_0[3] ); 
Full_adder_1bit FA7_6_0 ( sum_z[20], c_z[20], a3[1], b3[1], c_z[19] ); 
Full_adder_1bit FA7_7_0 ( sum_z[21], c_z[21], a3[2], b3[2], c_z[20] );

// c = 1
Full_adder_1bit FA7_1_1 ( sum_o[15], c_o[15], a[19], b[19],  1'b1 );
Full_adder_1bit FA7_2_1 ( sum_o[16], c_o[16], a[20], b[20], c_o[15] ); 
Full_adder_1bit FA7_3_1 ( sum_o[17], c_o[17], a[21], b[21], c_o[16] ); 
Full_adder_1bit FA7_4_1 ( sum_o[18], c_o[18], a[22], b[22], c_o[17] ); 
D_FF_5bit DFF401 ({c_1[3], sum_d1[15:12]}, {c_o[18], sum_o[18:15]}, clk, reset);

Full_adder_1bit FA7_5_1 ( sum_o[19], c_o[19], a3[0], b3[0], c_1[3] ); 
Full_adder_1bit FA7_6_1 ( sum_o[20], c_o[20], a3[1], b3[1], c_o[19] ); 
Full_adder_1bit FA7_7_1 ( sum_o[21], c_o[21], a3[2], b3[2], c_o[20] );

mux16to8 Mu4 ( sum_output[26:19], {c_z[21], sum_z[21:19], sum_d0[15:12]}, {c_o[21], sum_o[21:19], sum_d1[15:12]}, c[6] ); 


endmodule


module D_FF_5bit (q, d, clk, reset);

output [5-1:0] q;
input  [5-1:0] d;
input  clk, reset;

reg    [5-1:0] q;

always @ (posedge clk) begin
    if(~reset)
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule

module D_FF_3bit (q, d, clk, reset);

output [3-1:0] q;
input  [3-1:0] d;
input  clk, reset;

reg    [3-1:0] q;

always @ (posedge clk) begin
    if(~reset)
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule

module D_FF_2bit (q, d, clk, reset);

output [2-1:0] q;
input  [2-1:0] d;
input  clk, reset;

reg    [2-1:0] q;

always @ (posedge clk) begin
    if(~reset)
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule

module D_FF_1bit (q, d, clk, reset);

output  q;
input   d;
input  clk, reset;

reg     q;


always @ (posedge clk) begin
    if(~reset)
        q <= 1'b0;
    else 
	    q <= d;
end 
endmodule 


