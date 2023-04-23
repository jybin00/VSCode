`include "Filter1.v"
`include "Filter2.v"
`include "rflp256x12mx4.v"
`include "rflp256x22mx4.v"

module top_FIR_filter(clk, rstn, c0, c1, c2, c3, c4 );

    input clk, rstn;
    input signed[12-1:0] c0, c1, c2, c3, c4;

    reg NWRT_IN, NWRT_OUT, NCE_OUT;

    assign NCE_IN = ~rstn;
    wire [8-1:0] ADDR;
    wire [6-1:0] RA;
    wire [2-1:0] CA;
    wire [22-1:0] direct_out;
    wire [22-1:0] trans_out;
    wire [22-1:0] DOt, DOd;
    
    counter_8bit counter(ADDR, clk, rstn);

    assign {RA, CA} = ADDR;

    wire [12-1:0] direct_in, trans_in;
    rflp256x12mx4 DIRECT_INPUT_MEM(NWRT_IN, 12'b0, RA, CA, NCE_IN, clk, direct_in);
    rflp256x12mx4 TRANS_INPUT_MEM(NWRT_IN, 12'b0, RA, CA, NCE_IN, clk, trans_in);

    Filter1 Filter1(direct_out, direct_in, clk, rstn, c0, c1, c2, c3, c4);
    Filter2 Filter2(trans_out, trans_in, clk, rstn, c0, c1, c2, c3, c4);

    rflp256x22mx4 DIRECT_OUTPUT_MEM(NWRT_OUT, direct_out, RA, CA, NCE_OUT, clk, DOd);
    rflp256x22mx4 TRANS_OUTPUT_MEM(NWRT_OUT, trans_out, RA, CA, NCE_OUT, clk, DOt);

    always@ (posedge clk)
    begin
        if(ADDR == 8'd6) begin
            NWRT_OUT <= 1'b0;
            NCE_OUT <= 1'b0;  end
        if(rstn == 1'b0) begin 
            NWRT_IN <= 1'b1;
            NCE_OUT <= 1'b1; NWRT_OUT <= 1'b1; end
    end

endmodule

module counter_8bit(count, clk, rstn);
    output reg[8-1:0]count;
    input clk, rstn;

    always@ (posedge clk)
    begin
        count <= count + 1'b1;
    end

    always@ (posedge rstn or rstn)
    begin
        if(rstn == 1'b0) count <= 8'b0;
        else count <= 8'b0;
    end

endmodule