`timescale 1 ns / 1 ps
`include "full_adder.v"
`include "dff.v"
`include "mux_2to1.v"

module pipe_carry_select_adder_20b(
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

    wire c0_pipe;
    wire [1:0] c1_pipe, c2_pipe, c3_pipe, c4_pipe;
    wire [4-1:0] sum_stage000;
    wire [4-1:0] sum_stage100, sum_stage101;
    wire [4-1:0] sum_stage200, sum_stage201;
    wire [4-1:0] sum_stage300, sum_stage301;
    wire [4-1:0] sum_stage400, sum_stage401;


    dff_20b DFF0(.out(a_q), .in(a), .clk(clk), .rstn(rstn)); // out에 a_q를 넣는다는 뜻
    dff_20b DFF1(.out(b_q), .in(b), .clk(clk), .rstn(rstn)); // out에 b_q를 넣는다는 뜻

    //Stage_0_4bit
    full_adder_4b STAGE_0_FA0(.sum(sum_stage000), .cout(c[0]), .a(a_q[3:0]), .b(b_q[3:0]), .cin(cin));
    dff_4b DFF_400 (sum_d[3:0], sum_stage000, clk, rstn);
    dff_1b DFF_100 (c0_pipe, c[0], clk, rstn);  // c[0]를 받아서 stage1 먹스의 cin으로 넣어줌.

    //Stage_1_4bit
    full_adder_4b STAGE_1_FA0(.sum(sum_d0[3:0]), .cout(c0[0]), .a(a_q[7:4]), .b(b_q[7:4]), .cin(1'b0));
    full_adder_4b STAGE_1_FA1(.sum(sum_d1[3:0]), .cout(c1[0]), .a(a_q[7:4]), .b(b_q[7:4]), .cin(1'b1));

    dff_4b DFF_410 (sum_stage100, sum_d0[3:0], clk, rstn);
    dff_4b DFF_411 (sum_stage101, sum_d1[3:0], clk, rstn);
    dff_1b DFF_110 (c1_pipe[0], c0[0], clk, rstn);
    dff_1b DFF_111 (c1_pipe[1], c1[0], clk, rstn);

    mux_2to1_4b STAGE_1_M0(.out(sum_d[7:4]), .i0(sum_stage100), .i1(sum_stage101), .sel(c0_pipe));
    mux_2to1_1b STAGE_1_M1(.out(c[1]), .i0(c1_pipe[0]), .i1(c1_pipe[1]), .sel(c0_pipe));

    //Stage_2_4bit
    full_adder_4b STAGE_2_FA0(.sum(sum_d0[7:4]), .cout(c0[1]), .a(a_q[11:8]), .b(b_q[11:8]), .cin(1'b0));
    full_adder_4b STAGE_2_FA1(.sum(sum_d1[7:4]), .cout(c1[1]), .a(a_q[11:8]), .b(b_q[11:8]), .cin(1'b1));

    dff_4b DFF_420 (sum_stage200, sum_d0[7:4], clk, rstn);
    dff_4b DFF_421 (sum_stage201, sum_d1[7:4], clk, rstn);
    dff_1b DFF_120 (c2_pipe[0], c0[1], clk, rstn);
    dff_1b DFF_121 (c2_pipe[1], c1[1], clk, rstn);

    mux_2to1_4b STAGE_2_M0(.out(sum_d[11:8]), .i0(sum_stage200), .i1(sum_stage201), .sel(c[1]));
    mux_2to1_1b STAGE_2_M1(.out(c[2]), .i0(c2_pipe[0]), .i1(c2_pipe[1]), .sel(c[1]));

    //Stage_3_4bit
    full_adder_4b STAGE_3_FA0(.sum(sum_d0[11:8]), .cout(c0[2]), .a(a_q[15:12]), .b(b_q[15:12]), .cin(1'b0));
    full_adder_4b STAGE_3_FA1(.sum(sum_d1[11:8]), .cout(c1[2]), .a(a_q[15:12]), .b(b_q[15:12]), .cin(1'b1));

    dff_4b DFF_430 (sum_stage300, sum_d0[11:8], clk, rstn);
    dff_4b DFF_431 (sum_stage301, sum_d1[11:8], clk, rstn);
    dff_1b DFF_130 (c3_pipe[0], c0[2], clk, rstn);
    dff_1b DFF_131 (c3_pipe[1], c1[2], clk, rstn);

    mux_2to1_4b STAGE_3_M0(.out(sum_d[15:12]), .i0(sum_stage300), .i1(sum_stage301), .sel(c[2]));
    mux_2to1_1b STAGE_3_M1(.out(c[3]), .i0(c3_pipe[0]), .i1(c3_pipe[1]), .sel(c[2]));

    //Stage_4_4bit
    full_adder_4b STAGE_4_FA0(.sum(sum_d0[15:12]), .cout(c0[3]), .a(a_q[19:16]), .b(b_q[19:16]), .cin(1'b0));
    full_adder_4b STAGE_4_FA1(.sum(sum_d1[15:12]), .cout(c1[3]), .a(a_q[19:16]), .b(b_q[19:16]), .cin(1'b1));

    dff_4b DFF_440 (sum_stage400, sum_d0[15:12], clk, rstn);
    dff_4b DFF_441 (sum_stage401, sum_d1[15:12], clk, rstn);
    dff_1b DFF_140 (c4_pipe[0], c0[3], clk, rstn);
    dff_1b DFF_141 (c4_pipe[1], c1[3], clk, rstn);

    mux_2to1_4b STAGE_4_M0(.out(sum_d[19:16]), .i0(sum_stage400), .i1(sum_stage401), .sel(c[3]));
    mux_2to1_1b STAGE_4_M1(.out(sum_d[20]), .i0(c4_pipe[0]), .i1(c4_pipe[1]), .sel(c[3]));

    dff_21b DFF2(.out(sum), .in(sum_d), .clk(clk), .rstn(rstn));
 
    endmodule
     