`timescale 1 ns / 1 ps
module full_adder_1b(
    output sum,
    output cout,
    input a,
    input b,
    input cin);

    wire s1, c1, s2;

    xor(s1, a, b);
    and(c1, a, b);

    and(s2, s1, cin);
    xor(sum, s1, cin);

    xor(cout, s2, c1);

    endmodule

module full_adder_4b(
    output [4-1:0] sum,
    output cout,
    input [4-1:0] a,
    input [4-1:0] b,
    input cin);

    wire [3-1:0] c;

    full_adder_1b FA0(.sum(sum[0]), .cout(c[0]), .a(a[0]), .b(b[0]), .cin(cin));
    full_adder_1b FA1(.sum(sum[1]), .cout(c[1]), .a(a[1]), .b(b[1]), .cin(c[0]));
    full_adder_1b FA2(.sum(sum[2]), .cout(c[2]), .a(a[2]), .b(b[2]), .cin(c[1]));
    full_adder_1b FA3(.sum(sum[3]), .cout(cout), .a(a[3]), .b(b[3]), .cin(c[2]));

    endmodule