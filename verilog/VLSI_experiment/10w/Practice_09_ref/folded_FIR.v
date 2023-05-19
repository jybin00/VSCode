
// filter_in 12.10
// coefficient 12.11
module folded_FIR (filter_out, filter_in, clk100, clk20, reset, c0, c1, c2, c3, c4);
    
    output reg signed [22-1:0] filter_out;
    input signed [12-1:0] filter_in;
    input clk100, clk20, reset;
    input signed [12-1:0] c0, c1, c2, c3, c4;

    wire signed [12-1:0] x1_1, x1_2, x1_3, x1_4, x1_5;
    d_ff_12bit dff01(x1_1, filter_in, clk20, reset);
    d_ff_12bit dff02(x1_2, x1_1,      clk20, reset);
    d_ff_12bit dff03(x1_3, x1_2,      clk20, reset);
    d_ff_12bit dff04(x1_4, x1_3,      clk20, reset);
    d_ff_12bit dff05(x1_5, x1_4,      clk20, reset);

    reg signed [12-1:0] mux_x;
    reg signed [12-1:0] mux_c;
    wire [3-1:0] control_bit;
    //reg [3-1:0] control_bit;
    counter_3b counter(control_bit, clk100, reset);
    // 중간 계산 값 저장용
    reg signed [22-1:0] filt_temp_out = 22'b0;
    // 곱한 값을 우선 와이어로 받고
    wire signed [24-1:0] temp_mul_out;
    // 받은 값을 잘라주고,
    wire signed [20-1:0] mul_out_round;


    always@(posedge clk100) begin

        if(control_bit == 3'b100) begin
            filt_temp_out <= mul_out_round;
            filter_out <= filt_temp_out;
            mux_x <= x1_1;
            mux_c <= c0; 
            end

        else begin
            if(filt_temp_out >= 22'b0) begin
                case(control_bit)
                    3'b000: begin mux_x <= x1_2; mux_c <= c1; filt_temp_out <= filt_temp_out + mul_out_round; end
                    3'b001: begin mux_x <= x1_3; mux_c <= c2; filt_temp_out <= filt_temp_out + mul_out_round; end
                    3'b010: begin mux_x <= x1_4; mux_c <= c3; filt_temp_out <= filt_temp_out + mul_out_round; end
                    3'b011: begin mux_x <= x1_5; mux_c <= c4; filt_temp_out <= filt_temp_out + mul_out_round; end
                    default : begin mux_x = 12'b0; mux_c <= 12'b0; filt_temp_out <= 22'b0; end
                endcase
                filter_out <= filter_out;
            end
        end
    end
    // 곱하기.
    assign temp_mul_out = mux_x * mux_c;
    // 자르기.
    assign mul_out_round = temp_mul_out[23-1:3] + (temp_mul_out[2]);
   
endmodule

module d_ff_12bit(out, q, clk, rstn);

    output reg signed[12-1:0] out;
    input signed[12-1:0] q;
    input clk, rstn;

    always@ (posedge clk or rstn)
    begin
        if(rstn == 1'b0) out<= 12'b0;
        else out <= q;
    end

endmodule

module d_ff_22bit(out, q, clk, rstn);

    output reg signed [22-1:0] out;
    input signed[22-1:0] q;
    input clk, rstn;

    always@ (posedge clk or rstn)
    begin
        if(rstn == 1'b0) out<= 22'b0;
        else out <= q;
    end

endmodule

module counter_3b(out, clk, rstn);

    output reg[3-1:0] out;
    input clk, rstn;
    always@ (posedge clk)
    begin
        if(rstn == 1'b0) out<= 3'b0;
        else if(out == 3'b100) out <= 3'b000;
        else out <= out + 1'b1; 
    end

endmodule