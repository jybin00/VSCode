// Sub-expression Sharing in FIR Filter

module direct_filt(direct_out, direct_in, clk, rstn, c0, c1, c2, c3, c4);

    // 22.18
    output signed[22-1:0] direct_out;
    // 12.10
    input signed [12-1:0] direct_in;
    input clk, rstn;
    // 12.11
    input signed[12-1:0] c0, c1, c2, c3, c4;

    wire signed [12-1:0] x_n_1, x_n_2, x_n_3, x_n_4;
    wire signed [22-1:0] x1, x2, x3, x4;

    wire signed [22-1:0] x1_1, x1_2, x1_3, x1_4;
    wire signed [22-1:0] x2_1, x2_2, x2_3, x2_4;
    wire signed [22-1:0] x3_1, x3_2, x3_3, x3_4;

    D_FF_12bit FF01(x_n_1, direct_in, clk, rstn);
    D_FF_12bit FF02(x_n_2, x_n_1, clk, rstn);
    D_FF_12bit FF03(x_n_3, x_n_2, clk, rstn);

    assign x1 = x_n_1 >> 2 + x_n_1 >> 5;
    assign x2 = x_n_1 >> 6 - x_n_1 >> 9 + x_n_1 >> 11;
    assign x3 = -x_n_1 + x_n_2 >> 1;

    D_FF_22bit FF011(x1_1, x1, clk, rstn);
    D_FF_22bit FF012(x1_2, x1_1, clk, rstn);
    D_FF_22bit FF013(x1_3, x1_2, clk, rstn);
    D_FF_22bit FF014(x1_4, x1_3, clk, rstn);

    D_FF_22bit FF021(x2_1, x2, clk, rstn);
    D_FF_22bit FF022(x2_2, x2_1, clk, rstn);

    D_FF_22bit FF031(x3_1, x3, clk, rstn);
    D_FF_22bit FF032(x3_2, x3_1, clk, rstn);
    D_FF_22bit FF033(x3_3, x3_2, clk, rstn);

    assign direct_out = x1 + x1_1 << 1 + x1_3 << 1 + x1_4 + x1_4 >> 5 +
                    x2 + x2_1 + x2_2 + x3_1 + x3_3 + x1_4 >> 6;


    
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
