`timescale 1 ns / 1 ps
`include "full_adder.v"
`include "dff.v"
`include "mux_2to1.v"

module naive_carry_select_adder_20b(
    output [21-1:0] sum,
    input [20-1:0] a,
    input [20-1:0] b,
    input cin,
    input clk,
    input rstn);

    wire [20-1:0] a_q, b_q;
    wire [4-1:0] c0, c1;
    wire [4-1:0] c;
    wire [16-1:0] sum_d0, sum_d1;
    wire [21-1:0] sum_d;




    dff_20b DFF0(.out(a_q), .in(a), .clk(clk), .rstn(rstn));
    dff_20b DFF1(.out(b_q), .in(b), .clk(clk), .rstn(rstn));

    //Stage_0_4bit
    full_adder_4b STAGE_0_FA0(.sum(sum_d[3:0]), .cout(c[0]), .a(a_q[3:0]), .b(b_q[3:0]), .cin(cin));

    //Stage_1_4bit
    full_adder_4b STAGE_1_FA0(.sum(sum_d0[3:0]), .cout(c0[0]), .a(a_q[7:4]), .b(b_q[7:4]), .cin(1'b0));
    full_adder_4b STAGE_1_FA1(.sum(sum_d1[3:0]), .cout(c1[0]), .a(a_q[7:4]), .b(b_q[7:4]), .cin(1'b1));

    mux_2to1_4b STAGE_1_M0(.out(sum_d[7:4]), .i0(sum_d0[3:0]), .i1(sum_d1[3:0]), .sel(c[0]));
    mux_2to1_1b STAGE_1_M1(.out(c[1]), .i0(c0[0]), .i1(c1[0]), .sel(c[0]));

    //Stage_2_4bit
    full_adder_4b STAGE_2_FA0(.sum(sum_d0[7:4]), .cout(c0[1]), .a(a_q[11:8]), .b(b_q[11:8]), .cin(1'b0));
    full_adder_4b STAGE_2_FA1(.sum(sum_d1[7:4]), .cout(c1[1]), .a(a_q[11:8]), .b(b_q[11:8]), .cin(1'b1));

    mux_2to1_4b STAGE_2_M0(.out(sum_d[11:8]), .i0(sum_d0[7:4]), .i1(sum_d1[7:4]), .sel(c[1]));
    mux_2to1_1b STAGE_2_M1(.out(c[2]), .i0(c0[1]), .i1(c1[1]), .sel(c[1]));

    //Stage_3_4bit
    full_adder_4b STAGE_3_FA0(.sum(sum_d0[11:8]), .cout(c0[2]), .a(a_q[15:12]), .b(b_q[15:12]), .cin(1'b0));
    full_adder_4b STAGE_3_FA1(.sum(sum_d1[11:8]), .cout(c1[2]), .a(a_q[15:12]), .b(b_q[15:12]), .cin(1'b1));

    mux_2to1_4b STAGE_3_M0(.out(sum_d[15:12]), .i0(sum_d0[11:8]), .i1(sum_d1[11:8]), .sel(c[2]));
    mux_2to1_1b STAGE_3_M1(.out(c[3]), .i0(c0[2]), .i1(c1[2]), .sel(c[2]));

    //Stage_4_4bit
    full_adder_4b STAGE_4_FA0(.sum(sum_d0[15:12]), .cout(c0[3]), .a(a_q[19:16]), .b(b_q[19:16]), .cin(1'b0));
    full_adder_4b STAGE_4_FA1(.sum(sum_d1[15:12]), .cout(c1[3]), .a(a_q[19:16]), .b(b_q[19:16]), .cin(1'b1));

    mux_2to1_4b STAGE_4_M0(.out(sum_d[19:16]), .i0(sum_d0[15:12]), .i1(sum_d1[15:12]), .sel(c[3]));
    mux_2to1_1b STAGE_4_M1(.out(sum_d[20]), .i0(c0[3]), .i1(c1[3]), .sel(c[3]));

    dff_21b DFF2(.out(sum), .in(sum_d), .clk(clk), .rstn(rstn));
 
    endmodule