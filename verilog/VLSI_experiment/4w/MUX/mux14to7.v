module mux14to7 (out, a, b, s);

output [6:0] out;
input  [6:0] a, b;
input  s;
wire   [6:0]w1;
wire   [6:0]w2;

and (w1[0], a[0], ~s);
and (w2[0], b[0], s);

or (out[0], w1[0], w2[0]);

and (w1[1], a[1], ~s);
and (w2[1], b[1], s);

or (out[1], w1[1], w2[1]);

and (w1[2], a[2], ~s);
and (w2[2], b[2], s);

or (out[2], w1[2], w2[2]);

and (w1[3], a[3], ~s);
and (w2[3], b[3], s);

or (out[3], w1[3], w2[3]);

and (w1[4], a[4], ~s);
and (w2[4], b[4], s);

or (out[4], w1[4], w2[4]);

and (w1[5], a[5], ~s);
and (w2[5], b[5], s);

or (out[5], w1[5], w2[5]);

and (w1[6], a[6], ~s);
and (w2[6], b[6], s);

or (out[6], w1[6], w2[6]);
endmodule