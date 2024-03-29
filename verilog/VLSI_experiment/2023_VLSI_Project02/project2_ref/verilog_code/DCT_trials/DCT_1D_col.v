// 1차원 DCT 모듈

module DCT_1D_row
    #(parameter BW = 12, parameter IN = 11, parameter CW = 7)

    (X_k_out, x_n_in, clk, rstn);

    output [16*BW-1:0]X_k_out;
    input [11*16-1:0]x_n_in;  // unsigned input
    input clk, rstn;
    //(11.0)
    wire unsigned [IN-1:0] x_0  = x_n_in[15*IN +: 8];
    wire unsigned [IN-1:0] x_1  = x_n_in[14*IN +: 8];
    wire unsigned [IN-1:0] x_2  = x_n_in[13*IN +: 8];
    wire unsigned [IN-1:0] x_3  = x_n_in[12*IN +: 8];
    wire unsigned [IN-1:0] x_4  = x_n_in[11*IN +: 8];
    wire unsigned [IN-1:0] x_5  = x_n_in[10*IN +: 8];
    wire unsigned [IN-1:0] x_6  = x_n_in[ 9*IN +: 8];
    wire unsigned [IN-1:0] x_7  = x_n_in[ 8*IN +: 8];
    wire unsigned [IN-1:0] x_8  = x_n_in[ 7*IN +: 8];
    wire unsigned [IN-1:0] x_9  = x_n_in[ 6*IN +: 8];
    wire unsigned [IN-1:0] x_10 = x_n_in[ 5*IN +: 8];
    wire unsigned [IN-1:0] x_11 = x_n_in[ 4*IN +: 8];
    wire unsigned [IN-1:0] x_12 = x_n_in[ 3*IN +: 8];
    wire unsigned [IN-1:0] x_13 = x_n_in[ 2*IN +: 8];
    wire unsigned [IN-1:0] x_14 = x_n_in[ 1*IN +: 8];
    wire unsigned [IN-1:0] x_15 = x_n_in[ 0*IN +: 8];
    // (1.6)
    //wire [7-1:0] C_0  = 7'h10;
    wire signed [CW-1:0] C_1  = 7'h17;
    wire signed [CW-1:0] C_2  = 7'h16;
    wire signed [CW-1:0] C_3  = 7'h16;
    wire signed [CW-1:0] C_4  = 7'h15;
    wire signed [CW-1:0] C_5  = 7'h14;
    wire signed [CW-1:0] C_6  = 7'h13;
    wire signed [CW-1:0] C_7  = 7'h11;
    wire signed [CW-1:0] C_8  = 7'h10;
    wire signed [CW-1:0] C_9  = 7'he; 
    wire signed [CW-1:0] C_10 = 7'hd;
    wire signed [CW-1:0] C_11 = 7'hb;
    wire signed [CW-1:0] C_12 = 7'h9;
    wire signed [CW-1:0] C_13 = 7'h7;
    wire signed [CW-1:0] C_14 = 7'h4;
    wire signed [CW-1:0] C_15 = 7'h2;
    // 실제로는 16개인데 어차피 C0 = C8이어서 그냥 15개로만 계산함.

    //12bit
    wire signed[IN+1-1:0] X_0_15_a, X_0_15_s;
    wire signed[IN+1-1:0] X_1_14_a, X_1_14_s;
    wire signed[IN+1-1:0] X_2_13_a, X_2_13_s;
    wire signed[IN+1-1:0] X_3_12_a, X_3_12_s;
    wire signed[IN+1-1:0] X_4_11_a, X_4_11_s;
    wire signed[IN+1-1:0] X_5_10_a, X_5_10_s;
    wire signed[IN+1-1:0] X_6_9_a, X_6_9_s;
    wire signed[IN+1-1:0] X_7_8_a, X_7_8_s;


    wire signed[IN+CW+4-1:0] X_4, X_12;
    wire signed[IN+1-1:0] X_4_trunc, X_12_trunc;

    // Common stage (Even, Odd) (12.0)
    butterfly_st1 buf1( X_0_15_a, X_0_15_s, x_0, x_15);
    butterfly_st1 buf2( X_1_14_a, X_1_14_s, x_1, x_14);
    butterfly_st1 buf3( X_2_13_a, X_2_13_s, x_2, x_13);
    butterfly_st1 buf4( X_3_12_a, X_3_12_s, x_3, x_12);
    butterfly_st1 buf5( X_4_11_a, X_4_11_s, x_4, x_11);
    butterfly_st1 buf6( X_5_10_a, X_5_10_s, x_5, x_10);
    butterfly_st1 buf7( X_6_9_a,  X_6_9_s,  x_6, x_9);
    butterfly_st1 buf8( X_7_8_a,  X_7_8_s,  x_7, x_8);

    // 13bit
    wire signed[IN+2-1:0] X_0_7_8_15_a, X_1_6_9_14_a, X_2_5_10_13_a, X_3_4_11_12_a;
    wire signed[IN+2-1:0] X_0_7_8_15_s, X_1_6_9_14_s, X_2_5_10_13_s, X_3_4_11_12_s;

    // Even stage (13.0)
    butterfly_st2 buf2_1 (X_0_7_8_15_a,  X_0_7_8_15_s,  X_0_15_a, X_7_8_a);
    butterfly_st2 buf2_2 (X_1_6_9_14_a,  X_1_6_9_14_s,  X_1_14_a, X_6_9_a);
    butterfly_st2 buf2_3 (X_2_5_10_13_a, X_2_5_10_13_s, X_2_13_a, X_5_10_a);
    butterfly_st2 buf2_4 (X_3_4_11_12_a, X_3_4_11_12_s, X_3_12_a, X_4_11_a);

    // 14bit
    wire signed[IN+3-1:0] X1, X2, X3, X4;
    // 14 bit outcome (14.0)
    butterfly_st3 buf3_1 (X2, X4, X_1_6_9_14_a, X_2_5_10_13_a);
    butterfly_st3 buf3_2 (X1, X3, X_0_7_8_15_a,  X_3_4_11_12_a);

    // Even의 Even의 Even
    ////////////////////****** X[0], X[8] ******////////////////////
    // 15bit
    wire signed[IN+4-1:0] Pre_X_0, Pre_X_8;
    wire signed[IN+CW+4-1:0] X_0, X_8;
    wire signed[12-1:0] X_0_trunc; 
    wire signed[12-1:0] X_8_trunc;

    // 12bit outcome (15.0)
    butterfly_st4 buf4_1 (Pre_X_0, Pre_X_8, X1, X2);

    // 22bit outcome (22.6) 승화가 알려준 꿀팁. $unsigned()
    assign X_0 = $unsigned(Pre_X_0) * $unsigned(C_8);
    assign X_8 = Pre_X_8 * C_8;

    // 12bit (12.0)
    assign X_0_trunc = X_0[18-1:6];
    assign X_8_trunc = X_8[18-1:6];

    // Even의 Even의 Odd
    ////////////////////****** X[4], X[12] ******////////////////////
    // 19bit outcome (22.6)
    butterfly_st4_mult buf4_2 (X_4, X_12, X3, X4, C_4, C_12);
    
    // 12bit (12.0) 앞에서 3비트, 뒤에서 6비트 자르기
    assign X_4_trunc = X_4[18-1:6];
    assign X_12_trunc = X_12[18-1:6];

    // Even의 Odd
    ////////////////////****** X[2], X[6], X[10], X[14] ******////////////////////
    // 21.6
    wire signed [IN+CW+3-1:0] Pre_X_10_1, Pre_X_6_1, Pre_X_10_2, Pre_X_6_2;
    butterfly_st3_mult buf3_3 (Pre_X_10_1, Pre_X_6_1, X_0_7_8_15_s, X_3_4_11_12_s, C_10, C_6);
    butterfly_st3_mult buf3_4 (Pre_X_6_2, Pre_X_10_2, X_1_6_9_14_s, X_2_5_10_13_s, C_14, C_2);

    // 22.6
    wire signed [IN+CW+4-1:0] X_10, X_6;
    // 22bit outcome
    assign X_10 = Pre_X_10_1 - Pre_X_10_2;
    assign X_6 = Pre_X_6_1 - Pre_X_6_2;

    // 12bit truncation
    wire signed [12-1:0] X_10_trunc, X_6_trunc;
    assign X_10_trunc = X_10[18-1:6];
    assign X_6_trunc = X_6[18-1:6];

    wire signed [IN+CW+3-1:0] Pre_X_2_1, Pre_X_14_1, Pre_X_2_2, Pre_X_14_2;
    butterfly_st3_mult buf3_5 (Pre_X_2_1, Pre_X_14_1, X_0_7_8_15_s, X_3_4_11_12_s, C_2, C_14);
    butterfly_st3_mult buf3_6 (Pre_X_2_2, Pre_X_14_2, X_2_5_10_13_s, X_1_6_9_14_s, C_10, C_6);

    wire signed [IN+CW+4-1:0] X_2, X_14;
    // 22bit outcome
    assign X_2 = Pre_X_2_1 + Pre_X_2_2;
    assign X_14 = Pre_X_14_1 + Pre_X_14_2;

    // 12bit truncation
    wire signed [12-1:0] X_2_trunc, X_14_trunc;
    assign X_2_trunc = X_2[18-1:6];
    assign X_14_trunc = X_14[18-1:6];

    // Odd part
    ////////////////////****** X[1], X[15] ******////////////////////
    // 11 + 7 + 5 = 23
    wire signed [IN+CW+5-1:0] Pre_X_1, Pre_X_15;
    wire signed [IN+CW+2-1:0] X1_1, X15_1, X1_2, X15_2, X1_3, X15_3, X1_4, X15_4;
    
    butterfly_st2_mult buf_1_15_1 (X1_1, X15_1, X_0_15_s, X_7_8_s, C_1, C_15);
    butterfly_st2_mult buf_1_15_2 (X1_2, X15_2, X_1_14_s, X_6_9_s, C_3, C_13);
    butterfly_st2_mult buf_1_15_3 (X1_3, X15_3, X_2_13_s, X_5_10_s, C_5, C_11);
    butterfly_st2_mult buf_1_15_4 (X1_4, X15_4, X_3_12_s, X_4_11_s, C_7, C_9);

    assign Pre_X_1 = X1_1 + X1_2 + X1_3 + X1_4;
    assign Pre_X_15 = X15_1 - X15_2 + X15_3 - X15_4;

    // 11bit truncation
    wire signed [12-1:0] X_1_trunc, X_15_trunc;
    assign X_1_trunc = Pre_X_1[18-1:6];
    assign X_15_trunc = Pre_X_15[18-1:6];


    ////////////////////****** X[3], X[13] ******////////////////////

    wire signed [IN+CW+5-1:0] Pre_X_3, Pre_X_13;
    wire signed [IN+CW+2-1:0] X3_1, X13_1, X3_2, X13_2, X3_3, X13_3, X3_4, X13_4;

    butterfly_st2_mult buf_3_13_1 (X3_1, X13_1, X_0_15_s, -X_7_8_s, C_3, C_13);
    butterfly_st2_mult buf_3_13_2 (X3_2, X13_2, X_1_14_s, -X_6_9_s, C_9, C_7);
    butterfly_st2_mult buf_3_13_3 (X3_3, X13_3, X_2_13_s, -X_5_10_s, C_15, C_1);
    butterfly_st2_mult buf_3_13_4 (X3_4, X13_4, X_3_12_s, X_4_11_s, C_11, C_5);

    assign Pre_X_3 = X3_1 + X3_2 + X3_3 - X3_4;
    assign Pre_X_13 = X13_1 - X13_2 + X13_3 - X13_4;

    // 11bit truncation
    wire signed [12-1:0] X_3_trunc, X_13_trunc;
    assign X_3_trunc = Pre_X_3[18-1:6];
    assign X_13_trunc = Pre_X_13[18-1:6];

    ////////////////////****** X[5], X[11] ******////////////////////

    wire signed [IN+CW+5-1:0] Pre_X_5, Pre_X_11;
    wire signed [IN+CW+2-1:0] X5_1, X11_1, X5_2, X11_2, X5_3, X11_3, X5_4, X11_4;
    
    butterfly_st2_mult buf_5_11_1 (X5_1, X11_1, X_0_15_s, X_7_8_s, C_5, C_11);
    butterfly_st2_mult buf_5_11_2 (X5_2, X11_2, X_1_14_s, X_6_9_s, C_15, C_1);
    butterfly_st2_mult buf_5_11_3 (X5_3, X11_3, X_2_13_s, -X_5_10_s, C_7, C_9);
    butterfly_st2_mult buf_5_11_4 (X5_4, X11_4, X_3_12_s, X_4_11_s, C_3, C_13);

    assign Pre_X_5 = X5_1 + X5_2 - X5_3 - X5_4;
    assign Pre_X_11 = X11_1 - X11_2 + X11_3 + X11_4;

    // 11bit truncation
    wire signed [12-1:0] X_5_trunc, X_11_trunc;
    assign X_5_trunc = Pre_X_5[18-1:6];
    assign X_11_trunc = Pre_X_11[18-1:6];

    ////////////////////****** X[7], X[9] ******////////////////////

    wire signed [IN+CW+5-1:0] Pre_X_7, Pre_X_9;
    wire signed [IN+CW+2-1:0] X7_1, X9_1, X7_2, X9_2, X7_3, X9_3, X7_4, X9_4;

    butterfly_st2_mult buf_7_9_1 (X7_1, X9_1, X_0_15_s, -X_7_8_s, C_7, C_9);
    butterfly_st2_mult buf_7_9_2 (X7_2, X9_2, X_1_14_s, X_6_9_s, C_11, C_5);
    butterfly_st2_mult buf_7_9_3 (X7_3, X9_3, X_2_13_s, -X_5_10_s, C_3, C_13);
    butterfly_st2_mult buf_7_9_4 (X7_4, X9_4, X_3_12_s, X_4_11_s, C_15, C_1);

    assign Pre_X_7 = X7_1 - X7_2 - X7_3 + X7_4;
    assign Pre_X_9 = X9_1 - X9_2 - X9_3 + X9_4;

    // 11bit truncation
    wire signed [12-1:0] X_7_trunc, X_9_trunc;
    assign X_7_trunc = Pre_X_7[18-1:6];
    assign X_9_trunc = Pre_X_9[18-1:6];

    assign X_k_out = {X_0_trunc, X_1_trunc, X_2_trunc, X_3_trunc, X_4_trunc, X_5_trunc, X_6_trunc, X_7_trunc, X_8_trunc, X_9_trunc, X_10_trunc, X_11_trunc, X_12_trunc, X_13_trunc, X_14_trunc, X_15_trunc};


endmodule

module butterfly_st1(Out_add, Out_sub, in1, in2);
    output signed[12-1:0] Out_add;
    output signed[12-1:0] Out_sub;
    input [11-1:0] in1;
    input [11-1:0] in2;

    assign Out_add = in1 + in2;
    assign Out_sub = in1 - in2;

endmodule

module butterfly_st2(Out_add, Out_sub, in1, in2);
    output signed[13-1:0] Out_add;
    output signed[13-1:0] Out_sub;
    input signed[12-1:0] in1;
    input signed[12-1:0] in2;

    assign Out_add = in1 + in2;
    assign Out_sub = in1 - in2;

endmodule

module butterfly_st2_mult(Out_add, Out_sub, in1, in2, c1, c2);
    output signed[20-1:0] Out_add;
    output signed[20-1:0] Out_sub;
    input signed[7-1:0] c1, c2;
    input signed[12-1:0] in1;
    input signed[12-1:0] in2;

    assign Out_add = in1 * c1 + in2 * c2;
    assign Out_sub = in1 * c2 - in2 * c1;

endmodule

module butterfly_st3(Out_add, Out_sub, in1, in2);
    output signed[14-1:0] Out_add;
    output signed[14-1:0] Out_sub;
    input signed[13-1:0] in1;
    input signed[13-1:0] in2;

    assign Out_add = in1 + in2;
    assign Out_sub = in1 - in2;

endmodule
// Even의 Odd X[2], X[6], X[10], X[14]를 위한 butterfly 모듈
module butterfly_st3_mult (Out_add, Out_sub, in1, in2, c1, c2);
    output signed[21-1:0] Out_add;
    output signed[21-1:0] Out_sub;
    input signed[7-1:0] c1, c2;
    input signed[13-1:0] in1;
    input signed[13-1:0] in2;

    assign Out_add = in1 * c1 + in2 * c2;
    assign Out_sub = in1 * c2 - in2 * c1;

endmodule

module butterfly_st4(Out_add, Out_sub, in1, in2);
    output signed[15-1:0] Out_add;
    output signed[15-1:0] Out_sub;
    input signed[14-1:0] in1, in2;

    assign Out_add = in1 + in2;
    assign Out_sub = in1 - in2;

endmodule

// even X[4], X[12]를 위한 butterfly 모듈
module butterfly_st4_mult(Out_add, Out_sub, in1, in2, c1, c2);
    output signed[22-1:0] Out_add;
    output signed[22-1:0] Out_sub;
    input signed[7-1:0] c1, c2;
    input signed[14-1:0] in1, in2;

    assign Out_add = in1 * c1 + in2 * c2;
    assign Out_sub = in1 * c2 - in2 * c1;

endmodule