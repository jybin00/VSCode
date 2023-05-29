// butterfly module
// lattice 구조를 가지는 butterfly module을 설계하고, (진짜 butterfly모듈만, 주변 모듈 x)
// 이를 이용하여 8 point FFT를 구현한다.
module Butterfly(C1, C2, A, B);
    output [24-1:0] C1, C2; // C1 = A + B, C2 = A - B
    input [24-1:0] A, B; // A = A_r + j*A_i, B = B_r + j*B_i

    wire signed[12-1:0] A_r, A_i, B_r, B_i;  // A, B 자체는 합쳐져 있어서 signed bit 없지만,
    wire signed[13-1:0] C1_r, C1_i, C2_r, C2_i; // real, imaginary는 signed bit으로 지정.

    assign A_r = A[24-1:12];  assign A_i = A[12-1:0];
    assign B_r = B[24-1:12];  assign B_i = B[12-1:0];
    assign C1_r = A_r + B_r;  assign C1_i = A_i + B_i;
    assign C2_r = A_r - B_r;  assign C2_i = A_i - B_i;

    assign C1 = {C1_r[12:1], C1_i[12:1]}; assign C2 = {C2_r[12:1], C2_i[12:1]};


endmodule