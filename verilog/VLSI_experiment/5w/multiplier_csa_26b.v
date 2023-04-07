// 26-bit Carry Save Multiplier merging adder가 SRCSA인 경우
`include "CSM_stage_and.v"
`include "CSM_stage0_adder.v"
`include "CSM_stageX_adder.v"
`include "srcsa_25b.v"

module multiplier_csa_26b(out, a_input, b_input, clk, reset);

    output [52-1:0] out;
    input  [26-1:0] a_input, b_input;
    input  clk, reset;

    wire   [52-1:0] mul_out;
    wire   [26-1:0] a, b;

    D_FF_26bit dff26a (a, a_input, clk, reset);
    D_FF_26bit dff26b (b, b_input, clk, reset);
    D_FF_52bit dff52  (out, mul_out, clk, reset);

// stage 0
    wire   [25-1:0] stage0_out;
    CSM_stage_and and_out0 ({stage0_out, mul_out[0]}, a, b[0]);

// stage 1
    wire   [26-1:0] stage1_in;
    wire   [25-1:0] stage1_out, stage1_cout;
    CSM_stage_and and_out1 (stage1_in, a, b[1]);
    CSM_stage0_adder half0 ({stage1_out, mul_out[1]}, stage1_cout, stage0_out, stage1_in);

// stage 2
    wire   [26-1:0] stage2_in;
    wire   [25-1:0] stage2_out, stage2_cout; 
    CSM_stage_and and_out2 (stage2_in, a, b[2]);
    CSM_stageX_adder full1 ({stage2_out, mul_out[2]}, stage2_cout, stage1_out, stage2_in, stage1_cout);

// stage 3
    wire   [26-1:0] stage3_in;
    wire   [25-1:0] stage3_out, stage3_cout; 
    CSM_stage_and and_out3 (stage3_in, a, b[3]);
    CSM_stageX_adder full2 ({stage3_out, mul_out[3]}, stage3_cout, stage2_out, stage3_in, stage2_cout);

// stage 4
    wire   [26-1:0] stage4_in;
    wire   [25-1:0] stage4_out, stage4_cout;
    CSM_stage_and and_out4 (stage4_in, a, b[4]);
    CSM_stageX_adder full3 ({stage4_out, mul_out[4]}, stage4_cout, stage3_out, stage4_in, stage3_cout);

// stage 5
    wire   [26-1:0] stage5_in;
    wire   [25-1:0] stage5_out, stage5_cout;
    CSM_stage_and and_out5 (stage5_in, a, b[5]);
    CSM_stageX_adder full4 ({stage5_out, mul_out[5]}, stage5_cout, stage4_out, stage5_in, stage4_cout);

// stage 6
    wire   [26-1:0] stage6_in;
    wire   [25-1:0] stage6_out, stage6_cout;
    CSM_stage_and and_out6 (stage6_in, a, b[6]);
    CSM_stageX_adder full5 ({stage6_out, mul_out[6]}, stage6_cout, stage5_out, stage6_in, stage5_cout);

// stage 7
    wire   [26-1:0] stage7_in;
    wire   [25-1:0] stage7_out, stage7_cout;
    CSM_stage_and and_out7 (stage7_in, a, b[7]);
    CSM_stageX_adder full6 ({stage7_out, mul_out[7]}, stage7_cout, stage6_out, stage7_in, stage6_cout);

// stage 8
    wire   [26-1:0] stage8_in;
    wire   [25-1:0] stage8_out, stage8_cout;
    CSM_stage_and and_out8 (stage8_in, a, b[8]);
    CSM_stageX_adder full7 ({stage8_out, mul_out[8]}, stage8_cout, stage7_out, stage8_in, stage7_cout);

// stage 9
    wire   [26-1:0] stage9_in;
    wire   [25-1:0] stage9_out, stage9_cout;
    CSM_stage_and and_out9 (stage9_in, a, b[9]);
    CSM_stageX_adder full8 ({stage9_out, mul_out[9]}, stage9_cout, stage8_out, stage9_in, stage8_cout);

// stage 10
    wire   [26-1:0] stage10_in;
    wire   [25-1:0] stage10_out, stage10_cout;
    CSM_stage_and and_out10 (stage10_in, a, b[10]);
    CSM_stageX_adder full9 ({stage10_out, mul_out[10]}, stage10_cout, stage9_out, stage10_in, stage9_cout);

// stage 11
    wire   [26-1:0] stage11_in;
    wire   [25-1:0] stage11_out, stage11_cout;
    CSM_stage_and and_out11 (stage11_in, a, b[11]);
    CSM_stageX_adder full10 ({stage11_out, mul_out[11]}, stage11_cout, stage10_out, stage11_in, stage10_cout);

// stage 12
    wire   [26-1:0] stage12_in;
    wire   [25-1:0] stage12_out, stage12_cout;
    CSM_stage_and and_out12 (stage12_in, a, b[12]);
    CSM_stageX_adder full11 ({stage12_out, mul_out[12]}, stage12_cout, stage11_out, stage12_in, stage11_cout);

// stage 13
    wire   [26-1:0] stage13_in;
    wire   [25-1:0] stage13_out, stage13_cout;
    CSM_stage_and and_out13 (stage13_in, a, b[13]);
    CSM_stageX_adder full12 ({stage13_out, mul_out[13]}, stage13_cout, stage12_out, stage13_in, stage12_cout);

// stage 14
    wire   [26-1:0] stage14_in;
    wire   [25-1:0] stage14_out, stage14_cout;
    CSM_stage_and and_out14 (stage14_in, a, b[14]);
    CSM_stageX_adder full13 ({stage14_out, mul_out[14]}, stage14_cout, stage13_out, stage14_in, stage13_cout);

// stage 15
    wire   [26-1:0] stage15_in;
    wire   [25-1:0] stage15_out, stage15_cout;
    CSM_stage_and and_out15 (stage15_in, a, b[15]);
    CSM_stageX_adder full14 ({stage15_out, mul_out[15]}, stage15_cout, stage14_out, stage15_in, stage14_cout);

// stage 16
    wire   [26-1:0] stage16_in;
    wire   [25-1:0] stage16_out, stage16_cout;
    CSM_stage_and and_out16 (stage16_in, a, b[16]);
    CSM_stageX_adder full15 ({stage16_out, mul_out[16]}, stage16_cout, stage15_out, stage16_in, stage15_cout);

// stage 17
    wire   [26-1:0] stage17_in;
    wire   [25-1:0] stage17_out, stage17_cout;
    CSM_stage_and and_out17 (stage17_in, a, b[17]);
    CSM_stageX_adder full16 ({stage17_out, mul_out[17]}, stage17_cout, stage16_out, stage17_in, stage16_cout);

// stage 18
    wire   [26-1:0] stage18_in;
    wire   [25-1:0] stage18_out, stage18_cout;
    CSM_stage_and and_out18 (stage18_in, a, b[18]);
    CSM_stageX_adder full17 ({stage18_out, mul_out[18]}, stage18_cout, stage17_out, stage18_in, stage17_cout);

// stage 19
    wire   [26-1:0] stage19_in;
    wire   [25-1:0] stage19_out, stage19_cout;
    CSM_stage_and and_out19 (stage19_in, a, b[19]);
    CSM_stageX_adder full18 ({stage19_out, mul_out[19]}, stage19_cout, stage18_out, stage19_in, stage18_cout);

// stage 20
    wire   [26-1:0] stage20_in;
    wire   [25-1:0] stage20_out, stage20_cout;
    CSM_stage_and and_out20 (stage20_in, a, b[20]);
    CSM_stageX_adder full19 ({stage20_out, mul_out[20]}, stage20_cout, stage19_out, stage20_in, stage19_cout);

// stage 21
    wire   [26-1:0] stage21_in;
    wire   [25-1:0] stage21_out, stage21_cout;
    CSM_stage_and and_out21 (stage21_in, a, b[21]);
    CSM_stageX_adder full20 ({stage21_out, mul_out[21]}, stage21_cout, stage20_out, stage21_in, stage20_cout);

// stage 22
    wire   [26-1:0] stage22_in;
    wire   [25-1:0] stage22_out, stage22_cout;
    CSM_stage_and and_out22 (stage22_in, a, b[22]);
    CSM_stageX_adder full21 ({stage22_out, mul_out[22]}, stage22_cout, stage21_out, stage22_in, stage21_cout);

// stage 23
    wire   [26-1:0] stage23_in;
    wire   [25-1:0] stage23_out, stage23_cout;
    CSM_stage_and and_out23 (stage23_in, a, b[23]);
    CSM_stageX_adder full22 ({stage23_out, mul_out[23]}, stage23_cout, stage22_out, stage23_in, stage22_cout);

// stage 24
    wire   [26-1:0] stage24_in;
    wire   [25-1:0] stage24_out, stage24_cout;
    CSM_stage_and and_out24 (stage24_in, a, b[24]);
    CSM_stageX_adder full23 ({stage24_out, mul_out[24]}, stage24_cout, stage23_out, stage24_in, stage23_cout);

// stage 25
    wire   [26-1:0] stage25_in;
    wire   [25-1:0] stage25_out, stage25_cout;
    CSM_stage_and and_out25 (stage25_in, a, b[25]);
    CSM_stageX_adder full24 ({stage25_out, mul_out[25]}, stage25_cout, stage24_out, stage25_in, stage24_cout);

//vector merging adder
    srcsa_25b srcsa25 (mul_out[51:26], stage25_out, stage25_cout, 1'b0);
endmodule


module D_FF_26bit (q, d, clk, reset);

output [26-1:0] q;
input  [26-1:0] d;
input  clk, reset;

reg    [26-1:0] q;

always @ (posedge clk) begin
    if(~reset)
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule

module D_FF_52bit (q, d, clk, reset);

output [52-1:0] q;
input  [52-1:0] d;
input  clk, reset;

reg    [52-1:0] q;

always @ (posedge clk) begin
    if(~reset)
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule

