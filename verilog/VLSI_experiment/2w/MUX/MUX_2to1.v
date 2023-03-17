// 2 to 1 mux

module MUX_2to1 (out, i1, i2, s);

    output out;     // output zz
    input i1, i2;   // input 8bits
    input s;   // select 3bits

    wire andout[1:0];  // and gate output

    and a0(andout[0], ~s, i1);
    and a1(andout[1],  s, i2);

    or or1(out, andout[0], andout[1]);

endmodule