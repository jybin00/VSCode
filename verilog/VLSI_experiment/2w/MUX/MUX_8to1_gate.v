// 8 to 1 mux

`include "MUX_2to1.v"
`include "MUX_4to1.v"

module MUX_8to1_gate (out, a[7:0], s[2:0]);

    output out;     // output 
    input [7:0]a;   // input 8bits
    input [2:0]s;   // select 3bits

    wire mux_out[1:0];  // and gate output

    MUX_4to1 mux4_1(mux_out[0], a[3:0], s[1:0]);
    MUX_4to1 mux4_2(mux_out[1], a[7:4], s[1:0]);
    MUX_2to1 mux2_1(out, mux_out[0], mux_out[1], s[2]);

endmodule

