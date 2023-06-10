`include "DCT_1D_row_low_cost.v"
`include "DCT_1D_col_low_cost.v"
`include "TPMEM_16X16_11.v"
`include "TPMEM_16X16_12.v"

// DCT UNIT
module DCT_UNIT(X_k_out, x_n_in, clk, rstn, flag);

    output [16*12-1:0] X_k_out;
    input [128-1:0] x_n_in;
    input clk, rstn, flag;

    wire [16*11-1:0] Xk_row_out;
    wire [16*11-1:0] Xk_row_tp, Xk_row_tp1, Xk_row_tp2;
    wire [16*12-1:0] Xk_col_in;
    wire [16*12-1:0] Xk_out;

    reg int_flag;

    wire i_en1, i_en2, i_en3, i_en4;
    wire o_en1, o_en2, o_en3, o_en4;
    wire [16*11-1:0] dct_col_in;

    DCT_1D_row DCT_row (Xk_row_out, x_n_in, clk, rstn);

    TPmem_16x16_11 TPMEM1 (Xk_row_out, i_en1, clk, rstn, Xk_row_tp1, o_en1);
    TPmem_16x16_11 TPMEM2 (Xk_row_out, i_en2, clk, rstn, Xk_row_tp2, o_en2);
    
    assign dct_col_in = o_en1 ? Xk_row_tp1 : Xk_row_tp2;

    DCT_1D_col DCT_col (Xk_out, dct_col_in, clk, rstn, int_flag);

    nor(int, o_en1, o_en3);
    
    TPmem_16x16_12 TPMEM3 (Xk_col_in, i_en3, clk, rstn, Xk_out, o_en3);
    TPmem_16x16_12 TPMEM4 (Xk_col_in, i_en4, clk, rstn, Xk_out, o_en4);

    assign i_en1 = ~flag;
    assign i_en2 = flag;
    assign i_en3 = o_en1;
    assign i_en4 = o_en2;

    always@(posedge clk) begin
        int_flag <= int;
    end
endmodule