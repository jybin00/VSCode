// 1차원 DCT 모듈

module DCT_1D
    #(parameter C_bit = 8, parameter BW = 11)

    (X_k_out, x_n_in, clk, rstn, c_in);

    output signed [16*BW-1:0]X_k_out;
    input [128-1:0]x_n_in;
    input clk, rstn;
    input [C_bit*16-1:0] c_in;

    wire signed[8-1:0] x_0 = x_n_in[0*8 +: 8];
    wire signed[8-1:0] x_1 = x_n_in[1*8 +: 8];
    wire signed[8-1:0] x_2 = x_n_in[2*8 +: 8];
    wire signed[8-1:0] x_3 = x_n_in[3*8 +: 8];
    wire signed[8-1:0] x_4 = x_n_in[4*8 +: 8];
    wire signed[8-1:0] x_5 = x_n_in[5*8 +: 8];
    wire signed[8-1:0] x_6 = x_n_in[6*8 +: 8];
    wire signed[8-1:0] x_7 = x_n_in[7*8 +: 8];
    wire signed[8-1:0] x_8 = x_n_in[8*8 +: 8];
    wire signed[8-1:0] x_9 = x_n_in[9*8 +: 8];
    wire signed[8-1:0] x_10 = x_n_in[10*8 +: 8];
    wire signed[8-1:0] x_11 = x_n_in[11*8 +: 8];
    wire signed[8-1:0] x_12 = x_n_in[12*8 +: 8];
    wire signed[8-1:0] x_13 = x_n_in[13*8 +: 8];
    wire signed[8-1:0] x_14 = x_n_in[14*8 +: 8];
    wire signed[8-1:0] x_15 = x_n_in[15*8 +: 8];

    wire signed[7-1:0] C_1 = c_in[0*7 +: 7];
    wire signed[7-1:0] C_2 = c_in[1*7 +: 7];
    wire signed[7-1:0] C_3 = c_in[2*7 +: 7];
    wire signed[7-1:0] C_4 = c_in[3*7 +: 7];
    wire signed[7-1:0] C_5 = c_in[4*7 +: 7];
    wire signed[7-1:0] C_6 = c_in[5*7 +: 7];
    wire signed[7-1:0] C_7 = c_in[6*7 +: 7];
    wire signed[7-1:0] C_8 = c_in[7*7 +: 7];
    wire signed[7-1:0] C_9 = c_in[8*7 +: 7];
    wire signed[7-1:0] C_10 = c_in[9*7 +: 7];
    wire signed[7-1:0] C_11 = c_in[10*7 +: 7];
    wire signed[7-1:0] C_12 = c_in[11*7 +: 7];
    wire signed[7-1:0] C_13 = c_in[12*7 +: 7];
    wire signed[7-1:0] C_14 = c_in[13*7 +: 7];
    wire signed[7-1:0] C_15 = c_in[14*7 +: 7];
    wire signed[7-1:0] C_16 = c_in[15*7 +: 7];

    wire signed[9-1:0] X_0_15_a, X_0_15_s;
    wire signed[9-1:0] X_1_14_a, X_1_14_s;
    wire signed[9-1:0] X_2_13_a, X_2_13_s;
    wire signed[9-1:0] X_3_12_a, X_3_12_s;
    wire signed[9-1:0] X_4_11_a, X_4_11_s;
    wire signed[9-1:0] X_5_10_a, X_5_10_s;
    wire signed[9-1:0] X_6_09_a, X_6_09_s;
    wire signed[9-1:0] X_7_08_a, X_7_08_s;

    wire signed[12-1:0] Pre_X_0, Pre_X_8;
    wire signed[19-1:0] X_0, X_8;
    wire signed[11-1:0] X_0_trunc, X_8_trunc;

    wire signed[19-1:0] X_4, X_12;
    wire signed[11-1:0] X_4_trunc, X_12_trunc;

    // Common stage (Even, Odd)
    butterfly_st1 buf1( X_0_15_a, X_0_15_s, x_0, x_15);
    butterfly_st1 buf2( X_1_14_a, X_1_14_s, x_1, x_14);
    butterfly_st1 buf3( X_2_13_a, X_2_13_s, x_2, x_13);
    butterfly_st1 buf4( X_3_12_a, X_3_12_s, x_3, x_12);
    butterfly_st1 buf5( X_4_11_a, X_4_11_s, x_4, x_11);
    butterfly_st1 buf6( X_5_10_a, X_5_10_s, x_5, x_10);
    butterfly_st1 buf7( X_6_09_a,  X_6_09_s,  x_6, x_9);
    butterfly_st1 buf8( X_7_08_a,  X_7_08_s,  x_7, x_8);

    wire signed[10-1:0] X_0_7_8_15_a, X_1_6_9_14_a, X_2_5_10_13_a, X_3_4_11_12_a;
    wire signed[10-1:0] X_0_7_8_15_s, X_1_6_9_14_s, X_2_5_10_13_s, X_3_4_11_12_s;

    // Even stage
    butterfly_st2 buf2_1 (X_0_7_8_15_a,  X_0_7_8_15_s,  X_0_15_a, X_7_08_a);
    butterfly_st2 buf2_2 (X_1_6_9_14_a,  X_1_6_9_14_s,  X_1_14_a, X_6_09_a);
    butterfly_st2 buf2_3 (X_2_5_10_13_a, X_2_5_10_13_s, X_2_13_a, X_5_10_a);
    butterfly_st2 buf2_4 (X_3_4_11_12_a, X_3_4_11_12_s, X_3_12_a, X_4_11_a);

    wire signed[11-1:0] X1, X2, X3, X4;
    // 11 bit outcome
    butterfly_st3 buf3_1 (X2, X4, X_1_6_9_14_a, X_2_5_10_13_a);
    butterfly_st3 buf3_2 (X1, X3, X_0_7_8_15_a,  X_3_4_11_12_a);

    // Even의 Even의 Even
    ////////////////////****** X[0], X[8] ******////////////////////
    // 12bit outcome
    butterfly_st4 buf4_1 (Pre_X_0, Pre_X_8, X1, X2);

    // 19bit outcome
    assign X_0 = Pre_X_0 * C_8;
    assign X_8 = Pre_X_8 * C_8;

    // 11bit
    assign X_0_trunc = X_0[19-1:8];
    assign X_8_trunc = X_8[19-1:8];

    // Even의 Even의 Odd
    ////////////////////****** X[4], X[12] ******////////////////////
    // 19bit outcome
    butterfly_st4_mult buf4_2 (X_4, X_12, X3, X4, C_4, C_12);
    
    // 11bit
    assign X_4_trunc = X_4[19-1:8];
    assign X_12_trunc = X_12[19-1:8];

    // Even의 Odd
    ////////////////////****** X[2], X[6], X[10], X[14] ******////////////////////
    wire signed [18-1:0] Pre_X_10_1, Pre_X_6_1, Pre_X_10_2, Pre_X_6_2;
    butterfly_st3_mult buf3_3 (Pre_X_10_1, Pre_X_6_1, X_0_7_8_15_s, X_3_4_11_12_s, C_10, C_6);
    butterfly_st3_mult buf3_4 (Pre_X_6_2, Pre_X_10_2, X_1_6_9_14_s, X_2_5_10_13_s, C_14, C_2);

    wire signed [19-1:0] X_10, X_6;
    // 19bit outcome
    assign X_10 = Pre_X_10_1 - Pre_X_10_2;
    assign X_6 = Pre_X_6_1 - Pre_X_6_2;

    // 11bit truncation
    wire signed [11-1:0] X_10_trunc, X_6_trunc;
    assign X_10_trunc = X_10[19-1:8];
    assign X_6_trunc = X_6[19-1:8];

    wire signed [18-1:0] Pre_X_2_1, Pre_X_14_1, Pre_X_2_2, Pre_X_14_2;
    butterfly_st3_mult buf3_5 (Pre_X_2_1, Pre_X_14_1, X_0_7_8_15_s, X_3_4_11_12_s, C_2, C_14);
    butterfly_st3_mult buf3_6 (Pre_X_2_2, Pre_X_14_2, X_2_5_10_13_s, X_1_6_9_14_s, C_10, C_6);

    wire signed [19-1:0] X_2, X_14;
    // 19bit outcome
    assign X_2 = Pre_X_2_1 + Pre_X_2_2;
    assign X_14 = Pre_X_14_1 + Pre_X_14_2;

    // 11bit truncation
    wire signed [11-1:0] X_2_trunc, X_14_trunc;
    assign X_2_trunc = X_2[19-1:8];
    assign X_14_trunc = X_14[19-1:8];

    // Odd part
    ////////////////////****** X[1], X[3], X[5], X[7], X[9], X[11], X[13], X[15] ******////////////////////
    



endmodule

module butterfly_st1(Out_add, Out_sub, in1, in2);
    output signed[9-1:0] Out_add;
    output signed[9-1:0] Out_sub;
    input signed[8-1:0] in1;
    input signed[8-1:0] in2;

    assign Out_add = in1 + in2;
    assign Out_sub = in1 - in2;

endmodule

module butterfly_st2(Out_add, Out_sub, in1, in2);
    output signed[10-1:0] Out_add;
    output signed[10-1:0] Out_sub;
    input signed[9-1:0] in1;
    input signed[9-1:0] in2;

    assign Out_add = in1 + in2;
    assign Out_sub = in1 - in2;

endmodule

module butterfly_st2_mult(Out_add, Out_sub, in1, in2, c1, c2);
    output signed[17-1:0] Out_add;
    output signed[17-1:0] Out_sub;
    input signed[7-1:0] c1, c2;
    input signed[9-1:0] in1;
    input signed[9-1:0] in2;

    assign Out_add = in1 * c1 + in2 * c2;
    assign Out_sub = in1 * c2 - in2 * c1;

endmodule

module butterfly_st3(Out_add, Out_sub, in1, in2);
    output signed[11-1:0] Out_add;
    output signed[11-1:0] Out_sub;
    input signed[10-1:0] in1;
    input signed[10-1:0] in2;

    assign Out_add = in1 + in2;
    assign Out_sub = in1 - in2;

endmodule
// Even의 Odd X[2], X[6], X[10], X[14]를 위한 butterfly 모듈
module butterfly_st3_mult (Out_add, Out_sub, in1, in2, c1, c2);
    output signed[18-1:0] Out_add;
    output signed[18-1:0] Out_sub;
    input signed[7-1:0] c1, c2;
    input signed[10-1:0] in1;
    input signed[10-1:0] in2;

    assign Out_add = in1 * c1 + in2 * c2;
    assign Out_sub = in1 * c2 - in2 * c1;

endmodule

module butterfly_st4(Out_add, Out_sub, in1, in2);
    output signed[12-1:0] Out_add;
    output signed[12-1:0] Out_sub;
    input signed[11-1:0] in1, in2;

    assign Out_add = in1 + in2;
    assign Out_sub = in1 - in2;

endmodule

// even X[4], X[12]를 위한 butterfly 모듈
module butterfly_st4_mult(Out_add, Out_sub, in1, in2, c1, c2);
    output signed[19-1:0] Out_add;
    output signed[19-1:0] Out_sub;
    input signed[7-1:0] c1, c2;
    input signed[11-1:0] in1, in2;

    assign Out_add = in1 * c1 + in2 * c2;
    assign Out_sub = in1 * c2 - in2 * c1;

endmodule