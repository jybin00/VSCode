`include "Full_adder_1bit.v"
`include "mux10to5.v"
`include "mux12to6.v"
`include "mux14to7.v"
`include "mux16to8.v"

module Square_Root_CSA_26bits (sum_output, a, b, c_in);

output [27-1:0] sum_output; // ok
input  [26-1:0] a, b; // ok
input   c_in;

wire [21:0] sum_z; // ok zero
wire [21:0] sum_o; // ok one

wire [21:0] c_z; // ok
wire [21:0] c_o; // ok

wire [6:0] c ; // ok

//FA 1 * 4
Full_adder_1bit FA1_1 ( sum_output[0], c[0], a[0], b[0], c_in );
Full_adder_1bit FA1_2 ( sum_output[1], c[1], a[1], b[1], c[0] ); 
Full_adder_1bit FA1_3 ( sum_output[2], c[2], a[2], b[2], c[1] ); 
Full_adder_1bit FA1_4 ( sum_output[3], c[3], a[3], b[3], c[2] ); 

//FA 4 * 2 + MUX
// c = 0
Full_adder_1bit FA4_1_0 ( sum_z[0], c_z[0], a[4], b[4], 1'b0 );
Full_adder_1bit FA4_2_0 ( sum_z[1], c_z[1], a[5], b[5], c_z[0] ); 
Full_adder_1bit FA4_3_0 ( sum_z[2], c_z[2], a[6], b[6], c_z[1] ); 
Full_adder_1bit FA4_4_0 ( sum_z[3], c_z[3], a[7], b[7], c_z[2] ); 
// c = 1
Full_adder_1bit FA4_1_1 ( sum_o[0], c_o[0], a[4], b[4], 1'b1 );
Full_adder_1bit FA4_2_1 ( sum_o[1], c_o[1], a[5], b[5], c_o[0] ); 
Full_adder_1bit FA4_3_1 ( sum_o[2], c_o[2], a[6], b[6], c_o[1] ); 
Full_adder_1bit FA4_4_1 ( sum_o[3], c_o[3], a[7], b[7], c_o[2] ); 

// out, a, b, s
mux10to5 Mu1 ( {sum_output[7:4], c[4]}, {sum_z[3:0], c_z[3]}, {sum_o[3:0], c_o[3]}, c[3] );

//FA 5 * 2 + MUX
// c = 0
Full_adder_1bit FA5_1_0 ( sum_z[4], c_z[4], a[8],  b[8],  1'b0 );
Full_adder_1bit FA5_2_0 ( sum_z[5], c_z[5], a[9],  b[9],  c_z[4] ); 
Full_adder_1bit FA5_3_0 ( sum_z[6], c_z[6], a[10], b[10], c_z[5] ); 
Full_adder_1bit FA5_4_0 ( sum_z[7], c_z[7], a[11], b[11], c_z[6] ); 
Full_adder_1bit FA5_5_0 ( sum_z[8], c_z[8], a[12], b[12], c_z[7] ); 
// c = 1
Full_adder_1bit FA5_1_1 ( sum_o[4], c_o[4], a[8],  b[8],  1'b1 );
Full_adder_1bit FA5_2_1 ( sum_o[5], c_o[5], a[9],  b[9],  c_o[4] ); 
Full_adder_1bit FA5_3_1 ( sum_o[6], c_o[6], a[10], b[10], c_o[5] ); 
Full_adder_1bit FA5_4_1 ( sum_o[7], c_o[7], a[11], b[11], c_o[6] ); 
Full_adder_1bit FA5_5_1 ( sum_o[8], c_o[8], a[12], b[12], c_o[7] ); 

mux12to6 Mu2 ( {sum_output[12:8], c[5]}, {sum_z[8:4],c_z[8]}, {sum_o[8:4],c_o[8]}, c[4] );

//FA 6 + MUX
// c = 0
Full_adder_1bit FA6_1_0 ( sum_z[9],  c_z[9],  a[13], b[13],  1'b0 );
Full_adder_1bit FA6_2_0 ( sum_z[10], c_z[10], a[14], b[14], c_z[9] ); 
Full_adder_1bit FA6_3_0 ( sum_z[11], c_z[11], a[15], b[15], c_z[10] ); 
Full_adder_1bit FA6_4_0 ( sum_z[12], c_z[12], a[16], b[16], c_z[11] ); 
Full_adder_1bit FA6_5_0 ( sum_z[13], c_z[13], a[17], b[17], c_z[12] ); 
Full_adder_1bit FA6_6_0 ( sum_z[14], c_z[14], a[18], b[18], c_z[13] ); 
// c = 1
Full_adder_1bit FA6_1_1 ( sum_o[9],  c_o[9],  a[13], b[13],  1'b1 );
Full_adder_1bit FA6_2_1 ( sum_o[10], c_o[10], a[14], b[14], c_o[9] ); 
Full_adder_1bit FA6_3_1 ( sum_o[11], c_o[11], a[15], b[15], c_o[10] ); 
Full_adder_1bit FA6_4_1 ( sum_o[12], c_o[12], a[16], b[16], c_o[11] ); 
Full_adder_1bit FA6_5_1 ( sum_o[13], c_o[13], a[17], b[17], c_o[12] ); 
Full_adder_1bit FA6_6_1 ( sum_o[14], c_o[14], a[18], b[18], c_o[13] ); 

mux14to7 Mu3 ( {sum_output[18:13], c[6]}, {sum_z[14:9],c_z[14]}, {sum_o[14:9],c_o[14]}, c[5] ); 

//FA 7 + MUX
// c = 0
Full_adder_1bit FA7_1_0 ( sum_z[15], c_z[15], a[19], b[19],  1'b0 );
Full_adder_1bit FA7_2_0 ( sum_z[16], c_z[16], a[20], b[20], c_z[15] ); 
Full_adder_1bit FA7_3_0 ( sum_z[17], c_z[17], a[21], b[21], c_z[16] ); 
Full_adder_1bit FA7_4_0 ( sum_z[18], c_z[18], a[22], b[22], c_z[17] ); 
Full_adder_1bit FA7_5_0 ( sum_z[19], c_z[19], a[23], b[23], c_z[18] ); 
Full_adder_1bit FA7_6_0 ( sum_z[20], c_z[20], a[24], b[24], c_z[19] ); 
Full_adder_1bit FA7_7_0 ( sum_z[21], c_z[21], a[25], b[25], c_z[20] );
// c = 1
Full_adder_1bit FA7_1_1 ( sum_o[15], c_o[15], a[19], b[19],  1'b1 );
Full_adder_1bit FA7_2_1 ( sum_o[16], c_o[16], a[20], b[20], c_o[15] ); 
Full_adder_1bit FA7_3_1 ( sum_o[17], c_o[17], a[21], b[21], c_o[16] ); 
Full_adder_1bit FA7_4_1 ( sum_o[18], c_o[18], a[22], b[22], c_o[17] ); 
Full_adder_1bit FA7_5_1 ( sum_o[19], c_o[19], a[23], b[23], c_o[18] ); 
Full_adder_1bit FA7_6_1 ( sum_o[20], c_o[20], a[24], b[24], c_o[19] ); 
Full_adder_1bit FA7_7_1 ( sum_o[21], c_o[21], a[25], b[25], c_o[20] );

mux16to8 Mu4 ( sum_output[26:19], {c_z[21], sum_z[21:15]}, {c_o[21], sum_o[21:15]}, c[6] ); 


endmodule





