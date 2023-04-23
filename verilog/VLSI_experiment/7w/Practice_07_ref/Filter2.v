
module Filter2(trans_out, trans_in, clk, rstn, c0, c1, c2, c3, c4);

    output signed[22-1:0] trans_out; // (22.18)
    input signed[12-1:0] trans_in;   // (12.10)
    input clk, rstn;
    input signed[12-1:0] c0, c1, c2, c3, c4; // (12.11)


    wire signed[20-1:0] mul0, mul1, mul2, mul3, mul4; // (20.18)

    wire signed[12-1:0] x0; 
    d_ff_12bit stage0(x0, trans_in, clk, rstn); 

    wire signed[24-1:0] tmp4;
    assign tmp4 = x0 * c4;
    assign mul4 = tmp4[22:3];
    wire signed[20-1:0] x4; 
    d_ff_20bit stage4(x4, mul4, clk, rstn); 

    wire signed[24-1:0] tmp3;
    assign tmp3 = x0 * c3;
    assign mul3 = tmp3[22:3];
    wire signed[22-1:0] x3, sum3; 
    assign sum3 = x4 + mul3;
    d_ff_22bit stage3(x3, sum3, clk, rstn); 

    wire signed[24-1:0] tmp2;
    assign tmp2 = x0 * c2;
    assign mul2 = tmp2[22:3];
    wire signed[22-1:0] x2, sum2; 
    assign sum2 = x3 + mul2; // 위에서 받은 값과 필터 계수랑 곱한 값을 더함.
    d_ff_22bit stage2(x2, sum2, clk, rstn);

    wire signed[24-1:0] tmp1;
    assign tmp1 = x0 * c1;
    assign mul1 = tmp1[22:3];
    wire signed[22-1:0] x1, sum1; 
    assign sum1 = x2 + mul1;
    d_ff_22bit stage1(x1, sum1, clk, rstn);

    wire signed[24-1:0] tmp0;
    assign tmp0 = x0 * c0;
    assign mul0 = tmp0[22:3];
    wire signed[22-1:0] trans_out, sum0; 
    assign sum0 = x1 + mul0;
    d_ff_22bit filt_out(trans_out, sum0, clk, rstn);

endmodule

module d_ff_12bit(out, q, clk, rstn);

    output reg[12-1:0] out;
    input [12-1:0] q;
    input clk, rstn;

    always@ (posedge clk or rstn)
    begin
        if(rstn == 1'b0) out<= 12'b0;
        else out <= q;
    end

endmodule

module d_ff_22bit(out, q, clk, rstn);

    output reg[22-1:0] out;
    input [22-1:0] q;
    input clk, rstn;

    always@ (posedge clk or rstn)
    begin
        if(rstn == 1'b0) out<= 22'b0;
        else out <= q;
    end

endmodule

module d_ff_20bit(out, q, clk, rstn);

    output reg[20-1:0] out;
    input [20-1:0] q;
    input clk, rstn;

    always@ (posedge clk or rstn)
    begin
        if(rstn == 1'b0) out<= 20'b0;
        else out <= q;
    end

endmodule