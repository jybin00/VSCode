`include "DCT_1D_row_low_cost_U.v"
`include "DCT_1D_col_low_cost_U.v"
`include "tpmem_st1.v"
`include "tpmem_st2.v"

// DCT UNIT
module DCT_UNIT(X_k_out, x_n_in, clk, rstn, flag, o_en3, o_en4);

    output [16*12-1:0] X_k_out;
    output o_en3, o_en4;
    input [128-1:0] x_n_in;
    input clk, rstn, flag;

    wire [16*11-1:0] Xk_row_out;
    wire [16*11-1:0] Xk_row_tp, Xk_row_tp1, Xk_row_tp2;
    wire [16*11-1:0] Xk_col_in;
    wire [192-1:0] Xk_out;
    wire [192-1:0] X_k_out3, X_k_out4;

    reg int_flag;
    reg control;

    wire i_en1, i_en2, i_en3, i_en4;
    wire o_en1, o_en2, o_en3, o_en4;
    wire [16*11-1:0] dct_col_in;

    DCT_1D_row DCT_row (Xk_row_out, x_n_in, clk, rstn);

    tpmem_st1 TPMEM1 (Xk_row_out, i_en1, clk, rstn, Xk_row_tp1, o_en1);
    tpmem_st1 TPMEM2 (Xk_row_out, i_en2, clk, rstn, Xk_row_tp2, o_en2);
    
    assign dct_col_in = o_en1 ? Xk_row_tp1 : Xk_row_tp2;

    DCT_1D_col DCT_col (Xk_out, dct_col_in, clk, rstn, int_flag);

    xor(int, i_en2, i_en3);
    
    tpmem_st2 TPMEM3 (Xk_out, i_en3, clk, rstn, X_k_out3, o_en3);
    tpmem_st2 TPMEM4 (Xk_out, i_en4, clk, rstn, X_k_out4, o_en4);

    assign X_k_out = o_en3 ? X_k_out3 : X_k_out4;

    assign i_en1 = flag;
    assign i_en2 = ~flag && rstn;
    assign i_en3 = o_en1;
    assign i_en4 = o_en2;

    always@(posedge clk) begin
        int_flag <= int;
        control <= flag;
    end
endmodule