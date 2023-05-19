// 5 tap FIR filter
`include "direct_filt_comp.v"

module top_FIR_filter(DOd, NWRT_O, NCE_O, NWRT_I, NCE_I, clk, rstn);

    
    output signed [22-1:0] DOd;
    output reg NWRT_O, NCE_O;
    output reg NWRT_I;
    output NCE_I;
    input clk, rstn;

    assign NCE_I = ~rstn;
    wire signed [12-1:0] direct_in;
    wire signed [22-1:0] direct_out;
    wire [8-1:0] ADDR;


    counter_8bit Address(ADDR, clk, rstn);
    D_FF_12bit INPUT_MEM(direct_in, 12'h000, clk, rstn);
    
    direct_filt Direct_filter(direct_out, direct_in, clk, rstn);

    D_FF_22bit OUTPUT_MEM(DOd, direct_out, clk, rstn);
    
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
        if(rstn == 1'b0) count <= 8'b0;
        else count <= count + 1'b1;;
    end

endmodule