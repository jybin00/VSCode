// full adder 1bit 이어서 26bits adder 만들기
`include "full_adder_1b.v"

module rca_25b(sum, a, b, c_in);

    output  [26-1:0]sum;
    input   [25-1:0]a, b;
    input   c_in;

    wire [25-1:0]c;  // carry output

    full_adder_1b fa0  ( sum[0], c[0],    a[0],  b[0],  c_in);
    full_adder_1b fa1  ( sum[1], c[1],    a[1],  b[1],  c[0]);
    full_adder_1b fa2  ( sum[2], c[2],    a[2],  b[2],  c[1]);
    full_adder_1b fa3  ( sum[3], c[3],    a[3],  b[3],  c[2]);

    full_adder_1b fa4  ( sum[4], c[4],    a[4],  b[4],  c[3]);
    full_adder_1b fa5  ( sum[5], c[5],    a[5],  b[5],  c[4]);
    full_adder_1b fa6  ( sum[6], c[6],    a[6],  b[6],  c[5]);
    full_adder_1b fa7  ( sum[7], c[7],    a[7],  b[7],  c[6]);

    full_adder_1b fa8  ( sum[8], c[8],    a[8],  b[8],  c[7]);
    full_adder_1b fa9  ( sum[9], c[9],    a[9],  b[9],  c[8]);
    full_adder_1b fa10 (sum[10], c[10],   a[10], b[10], c[9]);
    full_adder_1b fa11 (sum[11], c[11],   a[11], b[11], c[10]);

    full_adder_1b fa12 (sum[12], c[12],   a[12], b[12], c[11]);
    full_adder_1b fa13 (sum[13], c[13],   a[13], b[13], c[12]);
    full_adder_1b fa14 (sum[14], c[14],   a[14], b[14], c[13]);
    full_adder_1b fa15 (sum[15], c[15],   a[15], b[15], c[14]);

    full_adder_1b fa16 (sum[16], c[16],   a[16], b[16], c[15]);
    full_adder_1b fa17 (sum[17], c[17],   a[17], b[17], c[16]);
    full_adder_1b fa18 (sum[18], c[18],   a[18], b[18], c[17]);
    full_adder_1b fa19 (sum[19], c[19],   a[19], b[19], c[18]);

    full_adder_1b fa20 (sum[20], c[20],   a[20], b[20], c[19]);
    full_adder_1b fa21 (sum[21], c[21],   a[21], b[21], c[20]);
    full_adder_1b fa22 (sum[22], c[22],   a[22], b[22], c[21]);
    full_adder_1b fa23 (sum[23], c[23],   a[23], b[23], c[22]);

    full_adder_1b fa24 (sum[24], sum[25],   a[24], b[24], c[23]);

endmodule