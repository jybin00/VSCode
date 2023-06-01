// Twiddle factor module
// Butterfly 출력을 받아서 twiddle factor를 곱하는 모듈을 설계.

module Twiddle_Factor(out, C, T);

    output signed[24-1:0] out;
    input signed[24-1:0] C;
    input signed[24-1:0] T;

    wire signed[12-1:0] C_r, C_i, T_r, T_i;  // (12.10)
    assign C_r = C[24-1:12]; assign C_i = C[12-1:0];
    assign T_r = T[24-1:12]; assign T_i = T[12-1:0];

    // 곱셈 임시 변수
    wire signed[24-1:0] tmp_r1, tmp_r2, tmp_i1, tmp_i2;
    assign tmp_r1 = C_r * T_r;  // (24.20)
    assign tmp_r2 = C_i * T_i;  // (24.20)
    assign tmp_i1 = C_r * T_i;  // (24.20)
    assign tmp_i2 = C_i * T_r;  // (24.20)

    // 덧셈 임시 변수
    wire signed[25-1:0] tmp_r, tmp_i;
    assign tmp_r = tmp_r1 - tmp_r2; // (25.20)
    assign tmp_i = tmp_i1 + tmp_i2; // (25.20)

    wire signed[12-1:0] out_r, out_i;
    assign out_r = tmp_r[22-1:10];  // (12.10)
    assign out_i = tmp_i[22-1:10];  // (12.10)

    // 출력 (앞에서 3bit, 뒤에서 10bit truncate)
    // twiddle factor는  -1<=T<1이므로 곱해질 때, 거의 정수부 한 자리가 줄어듦.(-1인 경우 안 줄어 듦.)
    // 그래서 곱해진 수 두 개를 더하거나 빼도, 정수부는 2자리만 써도 표현 가능.
    assign out = {out_r, out_i};

endmodule