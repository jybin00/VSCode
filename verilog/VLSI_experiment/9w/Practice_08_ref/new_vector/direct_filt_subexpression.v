// Sub-expression Sharing in FIR Filter

module direct_filt(direct_out, direct_in, clk, rstn);

    // 22.18
    output signed[22-1:0] direct_out;
    wire signed[26-1:0] temp_out;
    // 12.10
    input signed [12-1:0] direct_in;
    input clk, rstn;
    // 12.11
    // 받아도 쓰지 않아서 주석 처리.
    // input signed[12-1:0] c0, c1, c2, c3, c4;

    wire signed [12-1:0] x1, x1_1, x1_2, x1_3;
    wire signed [16-1:0] x2, x2_1, x2_2, x2_3, x2_4;
    wire signed [13-1:0] x3, x3_1, x3_2;
    wire signed [16-1:0] x4, x4_1, x4_2, x4_3;

    
    D_FF_12bit FF01(x1, direct_in, clk, rstn);
    //24.22
    D_FF_12bit FF11(x1_1, x1, clk, rstn);
    D_FF_12bit FF12(x1_2, x1_1, clk, rstn);
    D_FF_12bit FF13(x1_3, x1_2, clk, rstn);

    // FF을 최소한으로 사용하기 위해서 가장 작은 비트에서 subexpression 구성.
    assign x2 = (x1 <<< 3) + x1;    // 노란색 15 + 12 => 16
    assign x3 = x1 + x1_2;          // 초록색 12 + 12 => 13
    assign x4 = (x1 <<< 3) - x1;    // 빨간색 15 - 12 => 16

    D_FF_16bit FF021(x2_1, x2, clk, rstn);
    D_FF_16bit FF022(x2_2, x2_1, clk, rstn);
    D_FF_16bit FF023(x2_3, x2_2, clk, rstn);
    D_FF_16bit FF024(x2_4, x2_3, clk, rstn);

    D_FF_13bit FF031(x3_1, x3, clk, rstn);
    D_FF_13bit FF032(x3_2, x3_1, clk, rstn);
    
    D_FF_16bit FF041(x4_1, x4, clk, rstn);
    D_FF_16bit FF042(x4_2, x4_1, clk, rstn);
    D_FF_16bit FF043(x4_3, x4_2, clk, rstn);

    wire signed [18-1:0] x1_out; 
    wire signed [24-1:0] x2_out; 
    wire signed [26-1:0] x3_out; 
    wire signed [26-1:0] x4_out; // 24 + 24 => 25
    
    // 대괄호를 사용하면 unsigned로 인식하고, 괄호로 묶어야 signed로 인식함.
    assign x1_out = x1_1 + (x1_3 <<< 5); // 12 + 17 => 18
    assign x2_out = (x2 <<< 6) + (x2_4 <<< 6) + (x2_4 <<< 1); // 22 + 22 + 22 => 24
    assign x3_out = x3 + (x3_2 <<< 10); // 13 + 23 => 24
    assign x4_out = (x4 <<< 2) + (x4_1 <<< 2) + (x4_2 <<< 2) - (x4_1 <<< 7)  - (x4_3 <<< 7) ;    
    // 18 + 18 + 23 + 23 => 25

    // 18 + 24 + 24 + 25 => 27
    assign temp_out = x1_out + x2_out + x3_out + x4_out;

    // 최대가 sum(abs(c0~c4))=:2.xx이고 입력값의 범위가 +-2 따라서 두 개의 곱이 대략 +-5.x정도니까 4bit 필요.
    //26.21 -> 22.18
    wire signed [22-1:0] mul_out;
    assign mul_out = temp_out[25-1:3] + {1'b0 , temp_out[2]};

    D_FF_22bit FFout(direct_out, mul_out, clk, rstn);
    
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


module D_FF_13bit (FF_out, FF_in, clk, rstn);
    output signed [13-1:0] FF_out;
    input signed [13-1:0] FF_in;
    input clk, rstn;

    reg signed [13-1:0] FF_out;

    always @ (posedge clk) begin
        if(~rstn)
            FF_out <= 1'b0;
        else 
            FF_out <= FF_in;
    end
endmodule


module D_FF_16bit (FF_out, FF_in, clk, rstn);
    output signed [16-1:0] FF_out;
    input signed [16-1:0] FF_in;
    input clk, rstn;

    reg signed [16-1:0] FF_out;

    always @ (posedge clk) begin
        if(~rstn)
            FF_out <= 1'b0;
        else 
            FF_out <= FF_in;
    end
endmodule

module D_FF_15bit (FF_out, FF_in, clk, rstn);
    output signed [15-1:0] FF_out;
    input signed [15-1:0] FF_in;
    input clk, rstn;

    reg signed [15-1:0] FF_out;

    always @ (posedge clk) begin
        if(~rstn)
            FF_out <= 1'b0;
        else 
            FF_out <= FF_in;
    end
endmodule
