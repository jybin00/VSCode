// full adder 1bit 이어서 26bits adder 만들기
`include "Full_adder_1bit.v"

module Full_adder_26bits(sum, a, b, c_in);

    output  [27-1:0]sum;
    input   [26-1:0]a, b;
    input   c_in;

    wire [25-1:0]c;  // carry output

    Full_adder_1bit fa0  ( sum[0], c[0],    a[0],  b[0],  c_in);
    Full_adder_1bit fa1  ( sum[1], c[1],    a[1],  b[1],  c[0]);
    Full_adder_1bit fa2  ( sum[2], c[2],    a[2],  b[2],  c[1]);
    Full_adder_1bit fa3  ( sum[3], c[3],    a[3],  b[3],  c[2]);

    Full_adder_1bit fa4  ( sum[4], c[4],    a[4],  b[4],  c[3]);
    Full_adder_1bit fa5  ( sum[5], c[5],    a[5],  b[5],  c[4]);
    Full_adder_1bit fa6  ( sum[6], c[6],    a[6],  b[6],  c[5]);
    Full_adder_1bit fa7  ( sum[7], c[7],    a[7],  b[7],  c[6]);

    Full_adder_1bit fa8  ( sum[8], c[8],    a[8],  b[8],  c[7]);
    Full_adder_1bit fa9  ( sum[9], c[9],    a[9],  b[9],  c[8]);
    Full_adder_1bit fa10 (sum[10], c[10],   a[10], b[10], c[9]);
    Full_adder_1bit fa11 (sum[11], c[11],   a[11], b[11], c[10]);

    Full_adder_1bit fa12 (sum[12], c[12],   a[12], b[12], c[11]);
    Full_adder_1bit fa13 (sum[13], c[13],   a[13], b[13], c[12]);
    Full_adder_1bit fa14 (sum[14], c[14],   a[14], b[14], c[13]);
    Full_adder_1bit fa15 (sum[15], c[15],   a[15], b[15], c[14]);

    Full_adder_1bit fa16 (sum[16], c[16],   a[16], b[16], c[15]);
    Full_adder_1bit fa17 (sum[17], c[17],   a[17], b[17], c[16]);
    Full_adder_1bit fa18 (sum[18], c[18],   a[18], b[18], c[17]);
    Full_adder_1bit fa19 (sum[19], c[19],   a[19], b[19], c[18]);

    Full_adder_1bit fa20 (sum[20], c[20],   a[20], b[20], c[19]);
    Full_adder_1bit fa21 (sum[21], c[21],   a[21], b[21], c[20]);
    Full_adder_1bit fa22 (sum[22], c[22],   a[22], b[22], c[21]);
    Full_adder_1bit fa23 (sum[23], c[23],   a[23], b[23], c[22]);

    Full_adder_1bit fa24 (sum[24], c[24],   a[24], b[24], c[23]);
    Full_adder_1bit fa25 (sum[25], sum[26], a[25], b[25], c[24]);

endmodule