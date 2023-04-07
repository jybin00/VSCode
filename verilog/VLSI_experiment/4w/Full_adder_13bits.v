// full adder 1bit 이어서 26bits adder 만들기
`include "Full_adder_1bit.v"

module Full_adder_13bits(sum, a, b, c_in);

    output  [14-1:0]sum;
    input   [13-1:0]a, b;
    input   c_in;

    wire [13-1:0]c;  // carry output

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

    Full_adder_1bit fa12 (sum[12], sum[13],   a[12], b[12], c[11]);

endmodule