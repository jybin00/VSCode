`timescale 1 ns / 1 ps
module mux_2to1_1b(
    output out,
    input i0,
    input i1,
    input sel);

    wire w0, w1;

    and(w0, i0, ~sel);
    and(w1, i1, sel);
    or(out, w0, w1);

    endmodule

module mux_2to1_4b(
    output [4-1:0] out,
    input [4-1:0] i0,
    input [4-1:0] i1,
    input sel);


    mux_2to1_1b M0(.out(out[0]), .i0(i0[0]), .i1(i1[0]), .sel(sel));
    mux_2to1_1b M1(.out(out[1]), .i0(i0[1]), .i1(i1[1]), .sel(sel));
    mux_2to1_1b M2(.out(out[2]), .i0(i0[2]), .i1(i1[2]), .sel(sel));
    mux_2to1_1b M3(.out(out[3]), .i0(i0[3]), .i1(i1[3]), .sel(sel));

    endmodule