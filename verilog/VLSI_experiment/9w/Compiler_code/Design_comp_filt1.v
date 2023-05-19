`include "Filter1.v"

module Design_comp_filt1(out, in, clk, rstn, c0, c1, c2, c3, c4 );

    output [22-1:0] out;
    input clk, rstn;
    input [12-1:0] in;
    input signed[12-1:0] c0, c1, c2, c3, c4;

    wire [22-1:0] direct_out;

    wire [12-1:0] direct_in, trans_in;
    d_ff_12bit DIRECT_INPUT_MEM(direct_in, in, clk, rstn);

    Filter1 Filter1(direct_out, direct_in, clk, rstn, c0, c1, c2, c3, c4);

    d_ff_22bit DIRECT_OUTPUT_MEM(out, direct_out, clk, rstn);


endmodule


module d_ff_22bit(out, q, clk, rstn);

    output reg[22-1:0] out;
    input [22-1:0] q;
    input clk, rstn;

    always@ (posedge clk)
    begin
        if(rstn == 1'b0) out<= 22'b0;
        else out <= q;
    end

endmodule

module d_ff_12bit(out, q, clk, rstn);

    output reg[12-1:0] out;
    input [12-1:0] q;
    input clk, rstn;

    always@ (posedge clk)
    begin
        if(rstn == 1'b0) out<= 12'b0;
        else out <= q;
    end

endmodule