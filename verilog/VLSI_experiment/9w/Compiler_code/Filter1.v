module Filter1(direct_out, direct_in, clk, rstn, c0, c1, c2, c3, c4);

    output signed[22-1:0] direct_out;
    input signed [12-1:0] direct_in;
    input clk, rstn;
    input signed[12-1:0] c0, c1, c2, c3, c4;

    wire signed[12-1:0] x0; 
    d_ff_12bit stage0(x0, direct_in, clk, rstn); 
    wire signed[24-1:0] tmp0; 
    assign tmp0 = x0 * c0;

    wire signed[12-1:0] x1; 
    d_ff_12bit stage1(x1, x0, clk, rstn); 
    wire signed[24-1:0] tmp1; 
    assign tmp1 = x1 * c1;

    wire signed[12-1:0] x2; 
    d_ff_12bit stage2(x2, x1, clk, rstn); 
    wire signed[24-1:0] tmp2; 
    assign tmp2 = x2 * c2;

    wire signed[12-1:0] x3; 
    d_ff_12bit stage3(x3, x2, clk, rstn); 
    wire signed[24-1:0] tmp3; 
    assign tmp3 = x3 * c3;

    wire signed[12-1:0] x4; 
    d_ff_12bit stage4(x4, x3, clk, rstn); 
    wire signed[24-1:0] tmp4; 
    assign tmp4 = x4 * c4;

    wire signed[22-1:0] mul0, mul1, mul2, mul3, mul4;

    assign mul0 = {tmp0[22], tmp0[22], tmp0[22:3] + {1'b0,tmp0[2]}};
    assign mul1 = {tmp1[22], tmp1[22], tmp1[22:3] + {1'b0,tmp1[2]}};
    assign mul2 = {tmp2[22], tmp2[22], tmp2[22:3] + {1'b0,tmp2[2]}};
    assign mul3 = {tmp3[22], tmp3[22], tmp3[22:3] + {1'b0,tmp3[2]}};
    assign mul4 = {tmp4[22], tmp4[22], tmp4[22:3] + {1'b0,tmp4[2]}};

    // assign mul0 = {tmp0[22], tmp0[22], tmp0[22:3]};
    // assign mul1 = {tmp1[22], tmp1[22], tmp1[22:3]};
    // assign mul2 = {tmp2[22], tmp2[22], tmp2[22:3]};
    // assign mul3 = {tmp3[22], tmp3[22], tmp3[22:3]};
    // assign mul4 = {tmp4[22], tmp4[22], tmp4[22:3]};

    wire signed[22-1:0] mul_out;

    assign mul_out = mul0 + mul1 + mul2 + mul3 + mul4;

    d_ff_22bit filt_out (direct_out, mul_out, clk, rstn);


endmodule
/*
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

endmodule */