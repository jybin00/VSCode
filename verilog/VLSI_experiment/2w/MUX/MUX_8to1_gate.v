// 8 to 1 mux

module MUX_8to1_gate (out, a[7:0], s[2:0]);

    output out;     // output zz
    input [7:0]a;   // input 8bits
    input [2:0]s;   // select 3bits

    wire andout[7:0];  // and gate output

    and a0(andout[0],  s[2], ~s[1], ~s[0], a[0]);
    and a1(andout[1],  s[2], ~s[1],  s[0], a[1]);
    and a2(andout[2],  s[2],  s[1], ~s[0], a[2]);
    and a3(andout[3],  s[2],  s[1],  s[0], a[3]);
    and a4(andout[4], ~s[2], ~s[1], ~s[0], a[4]);
    and a5(andout[5], ~s[2], ~s[1],  s[0], a[5]);
    and a6(andout[6], ~s[2],  s[1], ~s[0], a[6]);
    and a7(andout[7], ~s[2],  s[1],  s[0], a[7]);

    or or1(out, andout[0], andout[1], andout[2], andout[3], 
                andout[4], andout[5], andout[6], andout[7]);

endmodule

