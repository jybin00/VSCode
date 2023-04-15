// stage0는 하프 에더로 이뤄져있음.
// 마지막은 어차피 하나의 입력만 있으므로 캐리X, sum도 필요 X
`include "half_adder_1b.v"

module CSM_stage0_adder (out, cout, a, b);
    output [26-1:0] out;
    output [25-1:0] cout;
    input [25-1:0] a;
    input [26-1:0] b;

    half_adder_1b h0(out[0], cout[0], a[0], b[0]);
    half_adder_1b h1(out[1], cout[1], a[1], b[1]);
    half_adder_1b h2(out[2], cout[2], a[2], b[2]);
    half_adder_1b h3(out[3], cout[3], a[3], b[3]);
    half_adder_1b h4(out[4], cout[4], a[4], b[4]);
    half_adder_1b h5(out[5], cout[5], a[5], b[5]);
    half_adder_1b h6(out[6], cout[6], a[6], b[6]);
    half_adder_1b h7(out[7], cout[7], a[7], b[7]);
    half_adder_1b h8(out[8], cout[8], a[8], b[8]);
    half_adder_1b h9(out[9], cout[9], a[9], b[9]);
    half_adder_1b h10(out[10], cout[10], a[10], b[10]);
    half_adder_1b h11(out[11], cout[11], a[11], b[11]);
    half_adder_1b h12(out[12], cout[12], a[12], b[12]);
    half_adder_1b h13(out[13], cout[13], a[13], b[13]);
    half_adder_1b h14(out[14], cout[14], a[14], b[14]);
    half_adder_1b h15(out[15], cout[15], a[15], b[15]);
    half_adder_1b h16(out[16], cout[16], a[16], b[16]);
    half_adder_1b h17(out[17], cout[17], a[17], b[17]);
    half_adder_1b h18(out[18], cout[18], a[18], b[18]);
    half_adder_1b h19(out[19], cout[19], a[19], b[19]);
    half_adder_1b h20(out[20], cout[20], a[20], b[20]);
    half_adder_1b h21(out[21], cout[21], a[21], b[21]);
    half_adder_1b h22(out[22], cout[22], a[22], b[22]);
    half_adder_1b h23(out[23], cout[23], a[23], b[23]);
    half_adder_1b h24(out[24], cout[24], a[24], b[24]);
    and(out[25], b[25], 1);  // 그대로 다음 스테이지 에더로 보내면 됨.

endmodule