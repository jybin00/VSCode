// folded FIR filter
`include "folded_FIR.v"

module Top_folded_FIR_comp(direct_out, ADDR, NCE_IN, NCE_OUT, NWRT_IN, NWRT_OUT, clk100, clk20, rstn, c0, c1, c2, c3, c4);
    output [22-1:0]direct_out;
    output reg [8-1:0] ADDR;
    output reg NCE_IN, NCE_OUT, NWRT_IN, NWRT_OUT;
    input clk100, clk20, rstn;
    input signed [12-1:0]c0, c1, c2, c3, c4;

    wire signed [22-1:0] direct_out;
    wire signed [22-1:0] filter_out;
    wire signed [12-1:0] direct_in;
    wire signed [12-1:0] temp_in;
    wire signed [22-1:0] temp_out;
    wire [8-1:0] address;

    counter_8b counter (address, clk20, rstn);
    
    d_ff_12bit DIRECT_INPUT_MEM(direct_in, temp_in, clk20, rstn);
    folded_FIR folded_FIR(direct_out, direct_in, clk100, clk20, rstn, c0, c1, c2, c3, c4);
    d_ff_22bit DIRECT_OUTPUT_MEM(temp_out, direct_out, clk20, rstn);

    always@(posedge clk20) begin
        ADDR <= address;
        if(ADDR == 8'd6) begin
            NWRT_OUT <= 1'b0;
            NCE_OUT <= 1'b0;  end
        if(rstn == 1'b0) begin 
            NWRT_IN <= 1'b1;
            NCE_IN <= 1'b0;
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