// Sub-expression Sharing in FIR Filter

module direct_filt(direct_out, direct_in, clk, rstn, c0, c1, c2, c3, c4);

    // 22.18
    output signed[22-1:0] direct_out;
    output signed[27-1:0] temp_out;
    // 12.10
    input signed [12-1:0] direct_in;
    input clk, rstn;
    // 12.11
    input signed[12-1:0] c0, c1, c2, c3, c4;

    wire signed [12-1:0] x1, x1_1, x1_2, x1_3;
    wire signed [17-1:0] x2, x2_1, x2_2;
    wire signed [16-1:0] x3, x3_1, x3_2, x3_3, x3_4;
    wire signed [13-1:0] x4, x4_1, x4_2, x4_3;

    
    D_FF_12bit FF01(x1, direct_in, clk, rstn);
    //24.22
    D_FF_12bit FF11(x1_1, x1, clk, rstn);
    D_FF_12bit FF12(x1_2, x1_1, clk, rstn);
    D_FF_12bit FF13(x1_3, x1_2, clk, rstn);

    assign x2 = {x1, 5'b0} - {x1, 2'b0} + x1; // 노란색 17 이거는 어떻게 해야하는지 잘 모르겠다.
    assign x3 = {x1, 3'b0} + x1; // 파란색 16
    assign x4 = {x1, 1'b0} - x1_1; // 빨간색 14

    D_FF_17bit FF021(x2_1, x2, clk, rstn);
    D_FF_17bit FF022(x2_2, x2_1, clk, rstn);

    D_FF_16bit FF031(x3_1, x3, clk, rstn);
    D_FF_16bit FF032(x3_2, x3_1, clk, rstn);
    D_FF_16bit FF033(x3_3, x3_2, clk, rstn);
    D_FF_16bit FF034(x3_4, x3_3, clk, rstn);
    
    D_FF_13bit FF041(x4_1, x4, clk, rstn);
    D_FF_13bit FF042(x4_2, x4_1, clk, rstn);
    D_FF_13bit FF043(x4_3, x4_2, clk, rstn);

    wire signed [17-1:0] x1_out; 
    wire signed [19-1:0] x2_out; 
    wire signed [25-1:0] x3_out; // 22 + 23 + 23 + 22 => 25
    wire signed [25-1:0] x4_out; // 24 + 24 => 25

    assign x1_out = {x1_3, 5'b0}; // 17
    assign x2_out = {x2 + x2_1 + x2_2}; // 17 + 17 + 17 => 19
    assign x3_out = {{x3, 6'b0} + {x3_1, 7'b0} + {x3_3, 7'b0} + {x3_4, 6'b0} + {x3_4, 1'b0}};
    assign x4_out = - {x4_1, 10'b0} - {x4_3, 10'b0};    

    // 17 + 19 + 25 + 25 => 27
    assign temp_out = {x1_out + x2_out + x3_out + x4_out};

    // 최대가 sum((c0~c4))=:0.8이고 입력값의 범위가 +-2 따라서 두 개의 곱이 대충 +-1.6정도니까 3bit 필요.
    //27.21 -> 22.18
    wire signed [22-1:0] mul_out;
    assign mul_out = {temp_out[25-1:3]} + {1'b0 , temp_out[2]};

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

module D_FF_17bit (FF_out, FF_in, clk, rstn);
    output signed [17-1:0] FF_out;
    input signed [17-1:0] FF_in;
    input clk, rstn;

    reg signed [17-1:0] FF_out;

    always @ (posedge clk) begin
        if(~rstn)
            FF_out <= 1'b0;
        else 
            FF_out <= FF_in;
    end
endmodule
