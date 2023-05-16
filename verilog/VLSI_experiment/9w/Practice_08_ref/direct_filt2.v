// Sub-expression Sharing in FIR Filter

module direct_filt(direct_out, direct_in, clk, rstn, c0, c1, c2, c3, c4);

    // 22.18
    output signed[22-1:0] direct_out;
    output signed[26-1:0] temp_out;
    // 12.10
    input signed [12-1:0] direct_in;
    input clk, rstn;
    // 12.11
    input signed[12-1:0] c0, c1, c2, c3, c4;

    wire signed [12-1:0] x_n_1, x_n_2, x_n_3, x_n_4;
    wire signed [12-1:0] x0;
    wire signed [23-1:0] x1, x2, x3, x4;

    wire signed [24-1:0] x1_1, x1_2, x1_3, x1_4;
    wire signed [24-1:0] x2_1, x2_2, x2_3, x2_4;
    wire signed [24-1:0] x3_1, x3_2;
    wire signed [24-1:0] x4_1, x4_2, x4_3;

    
    D_FF_12bit FF01(x0, direct_in, clk, rstn);
    //23.21
    assign x1 = {x0, 11'b0};
    D_FF_24bit FF11(x1_1, x1, clk, rstn);
    D_FF_24bit FF12(x1_2, x1_1, clk, rstn);
    D_FF_24bit FF13(x1_3, x1_2, clk, rstn);

    // 굳이 사인 익스텐션 할 필요가 없는건가?
    assign x2 = x1 + (x1 >>> 3);
    assign x3 = x1 - (x1 >>> 3) + (x1 >>> 5);
    assign x4 = -x1 + (x1_1 >>> 1);

    D_FF_24bit FF021(x2_1, x2, clk, rstn);
    D_FF_24bit FF022(x2_2, x2_1, clk, rstn);
    D_FF_24bit FF023(x2_3, x2_2, clk, rstn);
    D_FF_24bit FF024(x2_4, x2_3, clk, rstn);

    D_FF_24bit FF031(x3_1, x3, clk, rstn);
    D_FF_24bit FF032(x3_2, x3_1, clk, rstn);
    
    D_FF_24bit FF041(x4_1, x4, clk, rstn);
    D_FF_24bit FF042(x4_2, x4_1, clk, rstn);
    D_FF_24bit FF043(x4_3, x4_2, clk, rstn);

    wire signed [24-1:0] x1_out, x2_out, x3_out, x4_out;

    assign x1_out = (x1_3 >>> 6);
    assign x2_out = (x2 >>> 2) + (x2_1 >>> 1) + (x2_3 >>> 1) + (x2_4 >>> 2) + 
                    (x2_4 >>> 7);
    assign x3_out = ((x3 >>> 6) + (x3_1 >>> 6) + (x3_2 >>> 6));
    assign x4_out = (x4_1 + x4_3);    

    // assign temp_out = (x2 >>> 2) + (x2_1 >>> 1) + (x2_3 >>> 1) + (x2_4 >>> 2) + 
    //                 (x2_4 >>> 7) + (x3 >>> 6) + (x3_1 >>> 6) + (x3_2 >>> 6) + 
    //                 x4_1 + x4_3 + (x1_3 >>> 6);
    assign temp_out = x1_out + x2_out + x3_out + x4_out;

    // 최대가 sum(abs(c0~c4))=2.42이고 입력값의 범위가 +-2 따라서 두 개의 곱이 대충 +-5정도니까 4bit 필요.
    //24.22 (2 + 22)-> 22.18 (2+2 + 18)
    wire signed [22-1:0] mul_out;
    assign mul_out = temp_out[25-1:3] + {1'b0 , temp_out[2]};

    D_FF_22bit FFout(direct_out, mul_out, clk, rstn);
    
endmodule

module D_FF_24bit (FF_out, FF_in, clk, rstn);
    output signed [24-1:0] FF_out;
    input signed [24-1:0] FF_in;
    input clk, rstn;

    reg signed [24-1:0] FF_out;

    always @ (posedge clk) begin
        if(~rstn)
            FF_out <= 1'b0;
        else 
            FF_out <= FF_in;
    end
endmodule

module D_FF_22bit (FF_out, FF_in, clk, rstn);
    output signed [22-1:0] FF_out;
    input signed [22-1:0] FF_in;
    input clk, rstn;

    reg signed [22-1:0] FF_out;

    always @ (posedge clk) begin
        if(~rstn)
            FF_out <= 1'b0;
        else 
            FF_out <= FF_in;
    end
endmodule

module D_FF_12bit (FF_out, FF_in, clk, rstn);
    output signed [12-1:0] FF_out;
    input signed [12-1:0] FF_in;
    input clk, rstn;

    reg signed [12-1:0] FF_out;

    always @ (posedge clk) begin
        if(~rstn)
            FF_out <= 1'b0;
        else 
            FF_out <= FF_in;
    end
endmodule
