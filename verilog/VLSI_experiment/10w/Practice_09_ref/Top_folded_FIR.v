// folded FIR filter
`include "rflp256x12mx4.v"
`include "rflp256x22mx4.v"
`include "folded_FIR.v"

module Top_folded_FIR(direct_out, clk100, clk20, rstn, c0, c1, c2, c3, c4);
    output [22-1:0]direct_out;
    input clk100, clk20, rstn;
    input signed [12-1:0]c0, c1, c2, c3, c4;

    reg NWRT_IN, NWRT_OUT, NCE_OUT;
    wire NCE_IN;
    wire signed [22-1:0] direct_out;
    wire signed [22-1:0] filter_out;
    wire signed [12-1:0] direct_in;

    wire [8-1:0] ADDR;
    wire [6-1:0] RA;
    wire [2-1:0] CA;
    counter_8b counter (ADDR, clk20, rstn);
    assign {RA, CA} = ADDR;
    assign NCE_IN = ~rstn;

    rflp256x12mx4 DIRECT_INPUT_MEM(NWRT_IN, 12'b0, RA, CA, NCE_IN, clk20, direct_in);
    folded_FIR folded_FIR(direct_out, direct_in, clk100, clk20, rstn, c0, c1, c2, c3, c4);
    rflp256x22mx4 DIRECT_OUTPUT_MEM(NWRT_OUT, direct_out, RA, CA, NCE_OUT, clk20, filter_out);

    always@(posedge clk20) begin
        if(ADDR == 8'd6) begin
            NWRT_OUT <= 1'b0;
            NCE_OUT <= 1'b0;  end
        if(rstn == 1'b0) begin 
            NWRT_IN <= 1'b1;
            NCE_OUT <= 1'b1; NWRT_OUT <= 1'b1; end
    end

endmodule

module counter_8b(out, clk, rstn);

    output reg[8-1:0] out;
    input clk, rstn;

    always@ (posedge clk)
    begin
        if(rstn == 1'b0) out<= 8'b0;
        else out <= out + 1'b1;
    end

endmodule