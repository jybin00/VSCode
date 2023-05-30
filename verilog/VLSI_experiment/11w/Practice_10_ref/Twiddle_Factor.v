// Twiddle factor module
// Butterfly 출력을 받아서 twiddle factor를 곱하는 모듈을 설계.

module Twiddle_Factor(out, C, T);

    output [24-1:0] out;
    input [24-1:0] C;
    input [24-1:0] T;

    wire signed[12-1:0] C_r, C_i, T_r, T_i;  // (12.10)
    assign {C_r, C_i} = C;
    assign {T_r, T_i} = T;

    // 곱셈 임시 변수
    wire signed[24-1:0] tmp_r1, tmp_r2, tmp_i1, tmp_i2;
    assign tmp_r1 = C_r * T_r;  // (24.20) => 24.22 (실제로는)
    assign tmp_r2 = C_i * T_i;  // (24.20)
    assign tmp_i1 = C_r * T_i;  // (24.20)
    assign tmp_i2 = C_i * T_r;  // (24.20)

    // 덧셈 임시 변수
    wire signed[25-1:0] tmp_r, tmp_i;
    assign tmp_r = tmp_r1 - tmp_r2; // (25.20)
    assign tmp_i = tmp_i1 + tmp_i2; // (25.20)

    // 출력 (앞에서 3bit, 뒤에서 10bit truncate)
    // twiddle factor는  -1<=T<1이므로 곱해질 때, 거의 정수부 한 자리가 줄어듦.(-1인 경우 안 줄어 듦.)
    // 그래서 곱해진 수 두 개를 더하거나 빼도, 정수부는 2자리만 써도 표현 가능.
    assign out = {tmp_r[21:10], tmp_i[21:10]};

endmodule