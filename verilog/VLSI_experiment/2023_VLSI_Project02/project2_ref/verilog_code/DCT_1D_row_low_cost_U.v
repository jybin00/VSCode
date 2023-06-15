// 1차원 DCT 모듈

module DCT_1D_row
    #(parameter C_bit = 7, parameter BW = 11)

    (X_k_out, x_n_in, clk, rstn);

    output [16*BW-1:0]X_k_out;
    input [128-1:0]x_n_in;  // unsigned input
    input clk, rstn;
    //(8.0)
    wire [9-1:0] x_0  = {1'b0, (x_n_in[15*8 +: 8]));
    wire [9-1:0] x_1  = {1'b0, (x_n_in[14*8 +: 8]));
    wire [9-1:0] x_2  = {1'b0, (x_n_in[13*8 +: 8]));
    wire [9-1:0] x_3  = {1'b0, (x_n_in[12*8 +: 8]));
    wire [9-1:0] x_4  = {1'b0, (x_n_in[11*8 +: 8]));
    wire [9-1:0] x_5  = {1'b0, (x_n_in[10*8 +: 8]));
    wire [9-1:0] x_6  = {1'b0, (x_n_in[ 9*8 +: 8]));
    wire [9-1:0] x_7  = {1'b0, (x_n_in[ 8*8 +: 8]));
    wire [9-1:0] x_8  = {1'b0, (x_n_in[ 7*8 +: 8]));
    wire [9-1:0] x_9  = {1'b0, (x_n_in[ 6*8 +: 8]));
    wire [9-1:0] x_10 = {1'b0, (x_n_in[ 5*8 +: 8]));
    wire [9-1:0] x_11 = {1'b0, (x_n_in[ 4*8 +: 8]));
    wire [9-1:0] x_12 = {1'b0, (x_n_in[ 3*8 +: 8]));
    wire [9-1:0] x_13 = {1'b0, (x_n_in[ 2*8 +: 8]));
    wire [9-1:0] x_14 = {1'b0, (x_n_in[ 1*8 +: 8]));
    wire [9-1:0] x_15 = {1'b0, (x_n_in[ 0*8 +: 8]));
    // (8.7)
    //wire [8-1:0] C_0  = 8'h20;
    // wire [8-1:0] C_1  = 8'h2d;
    // wire [8-1:0] C_2  = 8'h2c;
    // wire [8-1:0] C_3  = 8'h2b;
    // wire [8-1:0] C_4  = 8'h2a;
    // wire [8-1:0] C_5  = 8'h28;
    // wire [8-1:0] C_6  = 8'h26;
    // wire [8-1:0] C_7  = 8'h23;
    // wire [8-1:0] C_8  = 8'h20;
    // wire [8-1:0] C_9  = 8'h1d;
    // wire [8-1:0] C_10 = 8'h19;
    // wire [8-1:0] C_11 = 8'h15;
    // wire [8-1:0] C_12 = 8'h11;
    // wire [8-1:0] C_13 = 8'hd;
    // wire [8-1:0] C_14 = 8'h9;
    // wire [8-1:0] C_15 = 8'h4;
    // 실제로는 16개인데 어차피 C0 = C8이어서 그냥 15개로만 계산함.

    wire signed[9-1:0] X_0_15_a, X_0_15_s;
    wire signed[9-1:0] X_1_14_a, X_1_14_s;
    wire signed[9-1:0] X_2_13_a, X_2_13_s;
    wire signed[9-1:0] X_3_12_a, X_3_12_s;
    wire signed[9-1:0] X_4_11_a, X_4_11_s;
    wire signed[9-1:0] X_5_10_a, X_5_10_s;
    wire signed[9-1:0] X_6_9_a, X_6_9_s;
    wire signed[9-1:0] X_7_8_a, X_7_8_s;


    wire signed[19-1:0] X_4, X_12;
    wire signed[11-1:0] X_4_trunc, X_12_trunc;

    // Common stage (Even, Odd) (9.0)
    butterfly_st1 buf1( X_0_15_a, X_0_15_s, x_0, x_15);
    butterfly_st1 buf2( X_1_14_a, X_1_14_s, x_1, x_14);
    butterfly_st1 buf3( X_2_13_a, X_2_13_s, x_2, x_13);
    butterfly_st1 buf4( X_3_12_a, X_3_12_s, x_3, x_12);
    butterfly_st1 buf5( X_4_11_a, X_4_11_s, x_4, x_11);
    butterfly_st1 buf6( X_5_10_a, X_5_10_s, x_5, x_10);
    butterfly_st1 buf7( X_6_9_a,  X_6_9_s,  x_6, x_9);
    butterfly_st1 buf8( X_7_8_a,  X_7_8_s,  x_7, x_8);

    wire signed[10-1:0] X_0_7_8_15_a, X_1_6_9_14_a, X_2_5_10_13_a, X_3_4_11_12_a;
    wire signed[10-1:0] X_0_7_8_15_s, X_1_6_9_14_s, X_2_5_10_13_s, X_3_4_11_12_s;

    // Even stage (10.0)
    butterfly_st2 buf2_1 (X_0_7_8_15_a,  X_0_7_8_15_s,  X_0_15_a, X_7_8_a);
    butterfly_st2 buf2_2 (X_1_6_9_14_a,  X_1_6_9_14_s,  X_1_14_a, X_6_9_a);
    butterfly_st2 buf2_3 (X_2_5_10_13_a, X_2_5_10_13_s, X_2_13_a, X_5_10_a);
    butterfly_st2 buf2_4 (X_3_4_11_12_a, X_3_4_11_12_s, X_3_12_a, X_4_11_a);

    wire signed[11-1:0] X1, X2, X3, X4;
    // 11 bit outcome (11.0)
    butterfly_st3 buf3_1 (X2, X4, X_1_6_9_14_a, X_2_5_10_13_a);
    butterfly_st3 buf3_2 (X1, X3, X_0_7_8_15_a,  X_3_4_11_12_a);

    // Even의 Even의 Even
    ////////////////////****** X[0], X[8] ******////////////////////
    wire signed[12-1:0] Pre_X_0, Pre_X_8;
    wire signed[19-1:0] X_0;
    wire signed[19-1:0] X_8;
    wire signed[11-1:0] X_0_trunc; 
    wire signed[11-1:0] X_8_trunc;

    // 12bit outcome (12.0)
    butterfly_st4 buf4_1 (Pre_X_0, Pre_X_8, X1, X2);

    // 16bit outcome (16.4) 승화가 알려준 꿀팁. $unsigned()
    assign X_0 = Pre_X_0 << 4;
    //assign X_0 = X_0 << 1;
    // 19bit outcome
    assign X_8 = Pre_X_8 << 4;

    // 11bit (11.0)
    assign X_0_trunc = X_0[17-1:6];
    assign X_8_trunc = X_8[17-1:6];

    // Even의 Even의 Odd
    ////////////////////****** X[4], X[12] ******////////////////////
    // 19bit outcome (19.6)
    //butterfly_st4_mult buf4_2 (X_4, X_12, X3, X4, C_4, C_12);

    assign X_4 = (X3 << 4) + (X3 << 2) + X3 + (X4 << 3) + X4;
    assign X_12 = (X3 << 3) + (X3) - ((X4 << 4) + (X4 << 2) + X4);
    
    // 11bit (11.0) 앞에서 2비트, 뒤에서 6비트 자르기
    assign X_4_trunc = X_4[17-1:6];
    assign X_12_trunc = X_12[17-1:6];

    // Even의 Odd
    ////////////////////****** X[2], X[6], X[10], X[14] ******////////////////////
    // 18.6
    wire signed [18-1:0] Pre_X_10_1, Pre_X_6_1, Pre_X_10_2, Pre_X_6_2;
    //butterfly_st3_mult buf3_3 (Pre_X_10_1, Pre_X_6_1, X_0_7_8_15_s, X_3_4_11_12_s, C_10, C_6);
    //butterfly_st3_mult buf3_4 (Pre_X_6_2, Pre_X_10_2, X_1_6_9_14_s, X_2_5_10_13_s, C_14, C_2);

    // C10 = 0001101, C6 = 0010011
    // C10 * X_0_7_8_15_s + C6 * X_3_4_11_12_s
    // -C10 * X_3_4_11_12 + C6 * X_0_7_8_15_s
    assign Pre_X_10_1 = (X_0_7_8_15_s << 3) + (X_0_7_8_15_s << 2) + (X_0_7_8_15_s) + (X_3_4_11_12_s << 4) + (X_3_4_11_12_s << 1) + (X_3_4_11_12_s);
    assign Pre_X_6_1 = -((X_3_4_11_12_s << 3) + (X_3_4_11_12_s << 2) + (X_3_4_11_12_s)) + ((X_0_7_8_15_s << 4) + (X_0_7_8_15_s << 1) + (X_0_7_8_15_s));

    // C14 = 0000100, C2 = 0010110
    // C14 * X_1_6_9_14_s + C2 * X_2_5_10_13_s
    // -C14 * X_2_5_10_13_s + C2 * X_1_6_9_14_s
    assign Pre_X_6_2 = (X_1_6_9_14_s << 2)  + (X_2_5_10_13_s << 4) + (X_2_5_10_13_s << 2) + (X_2_5_10_13_s << 1);
    assign Pre_X_10_2 = -((X_2_5_10_13_s << 2)) + ((X_1_6_9_14_s << 4) + (X_1_6_9_14_s << 2) + (X_1_6_9_14_s << 1));
    
    // 19.6
    wire signed [19-1:0] X_10, X_6;
    // 19bit outcome
    assign X_10 = Pre_X_10_1 - Pre_X_10_2;
    assign X_6 = Pre_X_6_1 - Pre_X_6_2;

    // 11bit truncation
    wire signed [11-1:0] X_10_trunc, X_6_trunc;
    assign X_10_trunc = X_10[17-1:6];
    assign X_6_trunc = X_6[17-1:6];

    // X[2], X[6]
    wire signed [18-1:0] Pre_X_2_1, Pre_X_14_1, Pre_X_2_2, Pre_X_14_2;
    //butterfly_st3_mult buf3_5 (Pre_X_2_1, Pre_X_14_1, X_0_7_8_15_s, X_3_4_11_12_s, C_2, C_14);
    //butterfly_st3_mult buf3_6 (Pre_X_2_2, Pre_X_14_2, X_2_5_10_13_s, X_1_6_9_14_s, C_10, C_6);

    // C2 = 0010110, C14 = 0000100
    // C2 * X_0_7_8_15_s + C14 * X_3_4_11_12_s
    // -C2 * X_3_4_11_12_s + C14 * X_0_7_8_15_s
    assign Pre_X_2_1 = (X_0_7_8_15_s << 4) + (X_0_7_8_15_s << 2) + (X_0_7_8_15_s << 1) + (X_3_4_11_12_s << 2);
    assign Pre_X_14_1 = -((X_3_4_11_12_s << 4) + (X_3_4_11_12_s << 2) + (X_3_4_11_12_s << 1)) + ((X_0_7_8_15_s << 2));

    // C10 = 0001101, C6 = 0010011
    // C10 * X_2_5_10_13_s + C6 * X_1_6_9_14_s
    // -C10 * X_1_6_9_14_s + C6 * X_2_5_10_13_s
    assign Pre_X_2_2 = (X_2_5_10_13_s << 3) + (X_2_5_10_13_s << 2) + (X_2_5_10_13_s) + (X_1_6_9_14_s << 4) + (X_1_6_9_14_s << 1) + (X_1_6_9_14_s);
    assign Pre_X_14_2 = -((X_1_6_9_14_s << 3) + (X_1_6_9_14_s << 2) + (X_1_6_9_14_s)) + ((X_2_5_10_13_s << 4) + (X_2_5_10_13_s << 1) + (X_2_5_10_13_s));

    wire signed [19-1:0] X_2, X_14;
    // 19bit outcome
    assign X_2 = Pre_X_2_1 + Pre_X_2_2;
    assign X_14 = Pre_X_14_1 + Pre_X_14_2;

    // 11bit truncation
    wire signed [11-1:0] X_2_trunc, X_14_trunc;
    assign X_2_trunc = X_2[17-1:6];
    assign X_14_trunc = X_14[17-1:6];

    // Odd part
    ////////////////////****** X[1], X[15] ******////////////////////

    wire signed [20-1:0] Pre_X_1, Pre_X_15;
    wire signed [17-1:0] X1_1, X15_1, X1_2, X15_2, X1_3, X15_3, X1_4, X15_4;
    
    //butterfly_st2_mult buf_1_15_1 (X1_1, X15_1, X_0_15_s, X_7_8_s, C_1, C_15);
    //butterfly_st2_mult buf_1_15_2 (X1_2, X15_2, X_1_14_s, X_6_9_s, C_3, C_13);
    //butterfly_st2_mult buf_1_15_3 (X1_3, X15_3, X_2_13_s, X_5_10_s, C_5, C_11);
    //butterfly_st2_mult buf_1_15_4 (X1_4, X15_4, X_3_12_s, X_4_11_s, C_7, C_9);

    // C1 = 0010111, C15 = 0000010
    // C1 * X_0_15_s + C15 * X_7_8_s
    // -C1 * X_7_8_s + C15 * X_0_15_s
    assign X1_1 = (X_0_15_s << 4) + (X_0_15_s << 2) + (X_0_15_s << 1) + X_0_15_s + (X_7_8_s << 1);
    assign X15_1 = -((X_7_8_s << 4) + (X_7_8_s << 2) + (X_7_8_s << 1) + X_7_8_s) + ((X_0_15_s << 1));

    // C3 = 0010110, C13 = 0000111
    // C3 * X_1_14_s + C13 * X_6_9_s
    // -C3 * X_6_9_s + C13 * X_1_14_s
    assign X1_2 = ((X_1_14_s << 4)+(X_1_14_s << 2)+(X_1_14_s << 1))  + (X_6_9_s << 2) + (X_6_9_s << 1) + (X_6_9_s);
    assign X15_2 = -((X_6_9_s << 4) + (X_6_9_s << 2) + (X_6_9_s << 1)) + ((X_1_14_s << 2)+(X_1_14_s << 1)+(X_1_14_s));

    // C5 = 0010100, C11 = 0001011
    // C5 * X_2_13_s + C11 * X_5_10_s
    // -C5 * X_5_10_s + C11 * X_2_13_s
    assign X1_3 = (X_2_13_s << 4) + (X_2_13_s << 2) + (X_5_10_s << 3) + (X_5_10_s << 1) + (X_5_10_s);
    assign X15_3 = -((X_5_10_s << 4) + (X_5_10_s << 2)) + ((X_2_13_s << 3) + (X_2_13_s << 1) + (X_2_13_s));

    // C7 = 0010001, C9 = 0001110
    // C7 * X_3_12_s + C9 * X_4_11_s
    // -C7 * X_4_11_s + C9 * X_3_12_s
    assign X1_4 = (X_3_12_s << 4) + (X_3_12_s) + (X_4_11_s << 3) + (X_4_11_s << 2) + (X_4_11_s << 1);
    assign X15_4 = -((X_4_11_s << 4) + (X_4_11_s)) + ((X_3_12_s << 3) + (X_3_12_s << 2) + (X_3_12_s << 1));

    assign Pre_X_1 = X1_1 + X1_2 + X1_3 + X1_4;
    assign Pre_X_15 = X15_1 - X15_2 + X15_3 - X15_4;

    // 11bit truncation
    wire signed [11-1:0] X_1_trunc, X_15_trunc;
    assign X_1_trunc = Pre_X_1[17-1:6];
    assign X_15_trunc = Pre_X_15[17-1:6];


    ////////////////////****** X[3], X[13] ******////////////////////

    wire signed [20-1:0] Pre_X_3, Pre_X_13;
    wire signed [17-1:0] X3_1, X13_1, X3_2, X13_2, X3_3, X13_3, X3_4, X13_4;

    //butterfly_st2_mult buf_3_13_1 (X3_1, X13_1, X_0_15_s, -X_7_8_s, C_3, C_13);
    //butterfly_st2_mult buf_3_13_2 (X3_2, X13_2, X_1_14_s, -X_6_9_s, C_9, C_7);
    //butterfly_st2_mult buf_3_13_3 (X3_3, X13_3, X_2_13_s, -X_5_10_s, C_15, C_1);
    //butterfly_st2_mult buf_3_13_4 (X3_4, X13_4, X_3_12_s, X_4_11_s, C_11, C_5);

    // C3 = 0010110, C13 = 0000111
    // C3 * X_0_15_s  C13 * X_7_8_s
    // -C3 * X_7_8_s + C13 * X_0_15_s
    //assign X_7_8_s = -X_7_8_s;
    assign X3_1 = (X_0_15_s << 4) + (X_0_15_s << 2) + (X_0_15_s << 1) -((X_7_8_s << 2) + (X_7_8_s << 1) + (X_7_8_s));
    assign X13_1 = ((X_7_8_s << 4) + (X_7_8_s << 2) + (X_7_8_s << 1)) + ((X_0_15_s << 2) + (X_0_15_s << 1) + (X_0_15_s));

    // C9 = 0001110, C7 = 0010001
    // C9 * X_1_14_s + C7 * X_6_9_s
    // -C9 * X_6_9_s + C7 * X_1_14_s
    //assign X_6_9_s = -X_6_9_s;
    assign X3_2 = (X_1_14_s << 3) + (X_1_14_s << 2) + (X_1_14_s << 1) - ((X_6_9_s << 4) + (X_6_9_s));
    assign X13_2 = ((X_6_9_s << 3) + (X_6_9_s << 2) + (X_6_9_s << 1)) + ((X_1_14_s << 4) + (X_1_14_s));

    // C15 = 0000010, C1 = 0010111
    // C15 * X_2_13_s + C1 * X_5_10_s
    // -C15 * X_5_10_s + C1 * X_2_13_s
    //assign X_5_10_s = -X_5_10_s;
    assign X3_3 = (X_2_13_s << 1) - ((X_5_10_s << 4) + (X_5_10_s << 2) + (X_5_10_s << 1) + X_5_10_s);
    assign X13_3 = ((X_5_10_s << 1)) + ((X_2_13_s << 4) + (X_2_13_s << 2) + (X_2_13_s << 1) + (X_2_13_s));

    // C11 = 0001011, C5 = 0010100
    // C11 * X_3_12_s + C5 * X_4_11_s
    // -C11 * X_4_11_s + C5 * X_3_12_s
    assign X3_4 = ((X_3_12_s << 3) + (X_3_12_s << 1) + (X_3_12_s)) + (X_4_11_s << 4) + (X_4_11_s << 2);
    assign X13_4 = -((X_4_11_s << 3) + (X_4_11_s << 1) + (X_4_11_s)) + ((X_3_12_s << 4) + (X_3_12_s << 2));

    assign Pre_X_3 = X3_1 + X3_2 + X3_3 - X3_4;
    assign Pre_X_13 = X13_1 - X13_2 + X13_3 - X13_4;

    // 11bit truncation
    wire signed [11-1:0] X_3_trunc, X_13_trunc;
    assign X_3_trunc = Pre_X_3[17-1:6];
    assign X_13_trunc = Pre_X_13[17-1:6];

    ////////////////////****** X[5], X[11] ******////////////////////

    wire signed [20-1:0] Pre_X_5, Pre_X_11;
    wire signed [17-1:0] X5_1, X11_1, X5_2, X11_2, X5_3, X11_3, X5_4, X11_4;
    
    //butterfly_st2_mult buf_5_11_1 (X5_1, X11_1, X_0_15_s, X_7_8_s, C_5, C_11);
    //butterfly_st2_mult buf_5_11_2 (X5_2, X11_2, X_1_14_s, X_6_9_s, C_15, C_1);
    //butterfly_st2_mult buf_5_11_3 (X5_3, X11_3, X_2_13_s, -X_5_10_s, C_7, C_9);
    //butterfly_st2_mult buf_5_11_4 (X5_4, X11_4, X_3_12_s, X_4_11_s, C_3, C_13);

    // C5 = 0010100, C11 = 0001011
    // C5 * X_0_15_s + C11 * X_7_8_s
    // -C5 * X_7_8_s + C11 * X_0_15_s
    assign X5_1 = (X_0_15_s << 4) + (X_0_15_s << 2) + (X_7_8_s << 3) + (X_7_8_s << 1) + (X_7_8_s);
    assign X11_1 = -((X_7_8_s << 4) + (X_7_8_s << 2)) + ((X_0_15_s << 3) + (X_0_15_s << 1) + (X_0_15_s));

    // C15 = 0000010, C1 = 0010111
    // C15 * X_1_14_s + C1 * X_6_9_s
    // -C15 * X_6_9_s + C1 * X_1_14_s
    assign X5_2 = (X_1_14_s << 1) + ((X_6_9_s << 4) + (X_6_9_s << 2) + (X_6_9_s << 1) + X_6_9_s);
    assign X11_2 = -((X_6_9_s << 1)) + ((X_1_14_s << 4) + (X_1_14_s << 2) + (X_1_14_s << 1) + (X_1_14_s));

    // C7 = 0010001, C9 = 0001110
    // C7 * X_2_13_s + C9 * X_5_10_s
    // -C7 * X_5_10_s + C9 * X_2_13_s
    assign X5_3 = (X_2_13_s << 4) + (X_2_13_s) - ((X_5_10_s << 3) + (X_5_10_s << 2) + (X_5_10_s << 1));
    assign X11_3 = ((X_5_10_s << 4) + (X_5_10_s)) + ((X_2_13_s << 3) + (X_2_13_s << 2) + (X_2_13_s << 1));

    // C3 = 0010110, C13 = 0000111
    // C3 * X_3_12_s + C13 * X_4_11_s
    // -C3 * X_4_11_s + C13 * X_3_12_s
    assign X5_4 = (X_3_12_s << 4) + (X_3_12_s << 2) + (X_3_12_s << 1) + (X_4_11_s << 2) + (X_4_11_s << 1) + X_4_11_s;
    assign X11_4 = -((X_4_11_s << 4) + (X_4_11_s << 2) + (X_4_11_s << 1)) + ((X_3_12_s << 2) + (X_3_12_s << 1) + X_3_12_s);

    assign Pre_X_5 = X5_1 + X5_2 - X5_3 - X5_4;
    assign Pre_X_11 = X11_1 - X11_2 + X11_3 + X11_4;

    // 11bit truncation
    wire signed [11-1:0] X_5_trunc, X_11_trunc;
    assign X_5_trunc = Pre_X_5[17-1:6];
    assign X_11_trunc = Pre_X_11[17-1:6];

    ////////////////////****** X[7], X[9] ******////////////////////

    wire signed [20-1:0] Pre_X_7, Pre_X_9;
    wire signed [17-1:0] X7_1, X9_1, X7_2, X9_2, X7_3, X9_3, X7_4, X9_4;

    //butterfly_st2_mult buf_7_9_1 (X7_1, X9_1, X_0_15_s, -X_7_8_s, C_7, C_9);
    //butterfly_st2_mult buf_7_9_2 (X7_2, X9_2, X_1_14_s, X_6_9_s, C_11, C_5);
    //butterfly_st2_mult buf_7_9_3 (X7_3, X9_3, X_2_13_s, -X_5_10_s, C_3, C_13);
    //butterfly_st2_mult buf_7_9_4 (X7_4, X9_4, X_3_12_s, X_4_11_s, C_15, C_1);

    // C7 = 0010001, C9 = 0001110
    // C7 * X_0_15_s - C9 * X_7_8_s
    // C7 * X_7_8_s + C9 * X_0_15_s
    //assign X_7_8_s = -X_7_8_s;
    assign X7_1 = (X_0_15_s << 4) + (X_0_15_s) - ((X_7_8_s << 3) + (X_7_8_s << 2) + (X_7_8_s << 1));
    assign X9_1 = ((X_7_8_s << 4) + (X_7_8_s)) + ((X_0_15_s << 3) + (X_0_15_s << 2) + (X_0_15_s << 1));

    // C11 = 0001011, C5 = 0010100
    // C11 * X_1_14_s + C5 * X_6_9_s
    // -C11 * X_6_9_s + C5 * X_1_14_s
    assign X7_2 = (X_1_14_s << 3) + (X_1_14_s << 1) + (X_1_14_s) + (X_6_9_s << 4) + (X_6_9_s << 2);
    assign X9_2 = -((X_6_9_s << 3) + (X_6_9_s << 1) + (X_6_9_s)) + ((X_1_14_s << 4) + (X_1_14_s << 2));

    // C3 = 0010110, C13 = 0000111
    // C3 * X_2_13_s - C13 * X_5_10_s
    // C3 * X_5_10_s + C13 * X_2_13_s
    //assign X_5_10_s = -X_5_10_s;
    assign X7_3 = (X_2_13_s << 4) + (X_2_13_s << 2) + (X_2_13_s << 1) - ((X_5_10_s << 2) + (X_5_10_s << 1) + X_5_10_s);
    assign X9_3 = ((X_5_10_s << 4) + (X_5_10_s << 2) + (X_5_10_s << 1)) + ((X_2_13_s << 2) + (X_2_13_s << 1) + X_2_13_s);

    // C15 = 0000010, C1 = 0010111
    // C15 * X_3_12_s + C1 * X_4_11_s
    // -C15 * X_4_11_s + C1 * X_3_12_s
    assign X7_4 = (X_3_12_s << 1) + ((X_4_11_s << 4) + (X_4_11_s << 2) + (X_4_11_s << 1) + X_4_11_s);
    assign X9_4 = -((X_4_11_s << 1)) + ((X_3_12_s << 4) + (X_3_12_s << 2) + (X_3_12_s << 1) + (X_3_12_s));

    assign Pre_X_7 = X7_1 - X7_2 - X7_3 + X7_4;
    assign Pre_X_9 = X9_1 - X9_2 - X9_3 + X9_4;

    // 11bit truncation
    wire signed [11-1:0] X_7_trunc, X_9_trunc;
    assign X_7_trunc = Pre_X_7[17-1:6];
    assign X_9_trunc = Pre_X_9[17-1:6];

    assign X_k_out = {X_0_trunc, X_1_trunc, X_2_trunc, X_3_trunc, X_4_trunc, X_5_trunc, X_6_trunc, X_7_trunc, X_8_trunc, X_9_trunc, X_10_trunc, X_11_trunc, X_12_trunc, X_13_trunc, X_14_trunc, X_15_trunc};


endmodule

module butterfly_st1(Out_add, Out_sub, in1, in2);
    output signed[9-1:0] Out_add;
    output signed[9-1:0] Out_sub;
    input [8-1:0] in1;
    input [8-1:0] in2;

    assign Out_add = in1 + in2;
    assign Out_sub = in1 - in2;

endmodule

// 여전히 여기 output도 unsigned로 계산해야함.
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