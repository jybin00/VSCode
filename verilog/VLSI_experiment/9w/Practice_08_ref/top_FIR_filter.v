// 5 tap FIR filter
`include "rflp256x12mx4.v"
`include "rflp256x22mx4.v"
`include "direct_filt_subexpression.v"

module top_FIR_filter(clk, rstn);

    input clk, rstn;
    // 12.11 fixed point
    input [12-1:0] c0, c1, c2, c3, c4;

    assign NCE_I = ~rstn;
    wire signed [12-1:0] direct_in;
    wire signed [22-1:0] direct_out;
    wire signed [22-1:0] DOd;

    reg NWRT_I, NWRT_O, NCE_O;
    wire [8-1:0] ADDR;  

    counter_8bit Address(ADDR, clk, rstn);

    rflp256x12mx4 DIRECT_INPUT_MEM(NWRT_I, 12'h000, ADDR[8-1:2], ADDR[1:0], NCE_I, clk, direct_in);
    
    direct_filt Direct_filter(direct_out, direct_in, clk, rstn);

    rflp256x22mx4 DIRECT_OUTPUT_MEM(NWRT_O, direct_out, ADDR[8-1:2], ADDR[1:0], NCE_O, clk, DOd);

    always@(posedge clk) begin
        if(ADDR == 8'd6) begin
            NWRT_O <= 1'b0;
            NCE_O <= 1'b0;  end
        if(rstn == 1'b0) begin 
            NWRT_I <= 1'b1;
            NCE_O <= 1'b1; NWRT_O <= 1'b1; end
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