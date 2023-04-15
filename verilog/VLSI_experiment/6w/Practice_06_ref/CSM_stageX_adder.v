// 2번째부터 마지막-1 까지는 cin을 받으므로 fa로 구성. 
// 마지막은 마찬가지로 마지막은 그대로 다음 스테이지 에더로 넣어주면 됨.
`include "full_adder_1b.v"

module CSM_stageX_adder(out, cout, a, b, cin);
    output [26-1:0] out;
    output [25-1:0] cout;
    input [25-1:0] a;
    input [26-1:0] b;
    input [25-1:0] cin;

    full_adder_1b fa0 (out[0], cout[0], a[0], b[0], cin[0]);
    full_adder_1b fa1 (out[1], cout[1], a[1], b[1], cin[1]);
    full_adder_1b fa2 (out[2], cout[2], a[2], b[2], cin[2]);
    full_adder_1b fa3 (out[3], cout[3], a[3], b[3], cin[3]);
    full_adder_1b fa4 (out[4], cout[4], a[4], b[4], cin[4]);
    full_adder_1b fa5 (out[5], cout[5], a[5], b[5], cin[5]);
    full_adder_1b fa6 (out[6], cout[6], a[6], b[6], cin[6]);
    full_adder_1b fa7 (out[7], cout[7], a[7], b[7], cin[7]);
    full_adder_1b fa8 (out[8], cout[8], a[8], b[8], cin[8]);
    full_adder_1b fa9 (out[9], cout[9], a[9], b[9], cin[9]);
    full_adder_1b fa10 (out[10], cout[10], a[10], b[10], cin[10]);
    full_adder_1b fa11 (out[11], cout[11], a[11], b[11], cin[11]);
    full_adder_1b fa12 (out[12], cout[12], a[12], b[12], cin[12]);
    full_adder_1b fa13 (out[13], cout[13], a[13], b[13], cin[13]);
    full_adder_1b fa14 (out[14], cout[14], a[14], b[14], cin[14]);
    full_adder_1b fa15 (out[15], cout[15], a[15], b[15], cin[15]);
    full_adder_1b fa16 (out[16], cout[16], a[16], b[16], cin[16]);
    full_adder_1b fa17 (out[17], cout[17], a[17], b[17], cin[17]);
    full_adder_1b fa18 (out[18], cout[18], a[18], b[18], cin[18]);
    full_adder_1b fa19 (out[19], cout[19], a[19], b[19], cin[19]);
    full_adder_1b fa20 (out[20], cout[20], a[20], b[20], cin[20]);
    full_adder_1b fa21 (out[21], cout[21], a[21], b[21], cin[21]);
    full_adder_1b fa22 (out[22], cout[22], a[22], b[22], cin[22]);
    full_adder_1b fa23 (out[23], cout[23], a[23], b[23], cin[23]);
    full_adder_1b fa24 (out[24], cout[24], a[24], b[24], cin[24]);
    and(out[25], b[25], 1); 


endmodule