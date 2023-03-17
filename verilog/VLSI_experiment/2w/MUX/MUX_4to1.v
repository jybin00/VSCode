// 4 to 1 mux

module MUX_4to1 (out, a[3:0], s[1:0]);

    output out;     // output zz
    input [3:0]a;   // input 8bits
    input [1:0]s;   // select 3bits

    wire andout[3:0];  // and gate output

    and a0(andout[0], ~s[1], ~s[0], a[0]);
    and a1(andout[1], ~s[1],  s[0], a[1]);
    and a2(andout[2],  s[1], ~s[0], a[2]);
    and a3(andout[3],  s[1],  s[0], a[3]);

    or or1(out, andout[0], andout[1], andout[2], andout[3]);

endmodule

