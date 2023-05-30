`include "Butterfly.v"
`include "Twiddle_Factor.v"

module top_FFT(out, in, clk, rstn);

    output [24-1:0] out;
    input [24-1:0] in;
    input clk, rstn;

    wire [24-1:0] W0, W1, W2, W3;
    assign W0 = 24'h400000; 
    assign W1 = 24'h2D4D2C;
    assign W2 = 24'hC00;
    assign W3 = 24'hD2CD2C;

    // A는 입력, B는 FIFO 출력.
    wire [24-1:0]A1, A2, A3, B1, B2, B3;
    // C1은 더해서 나온 결과, C2는 빼서 나온 결과.
    wire [24-1:0]C1_1, C1_2, C1_3, C2_1, C2_2, C2_3;
    // FIFO 입력, Twiddle Factor 입력
    wire [24-1:0]F4_in, F2_in, F3_in;
    wire [24-1:0]T1_in, T2_in, T3_in;
    wire [24-1:0]T1_out, T2_out, T3_out;
    wire [24-1:0]st1_out, st2_out, st3_out;
    // twiddle factor
    reg [24-1:0]T1, T2, T3; 
    // mux select bit
    reg sel1, sel2, sel3;
    wire st1_cont, st2_cont;
    wire [3-1:0] cnt1;
    wire [2-1:0] cnt2;
    cnt4 ST1_CNT (cnt1, st1_cont, clk, rstn);
    cnt2 ST2_CNT (cnt2, st2_cont, clk, rstn);
    FIFO1 ST1_IN (A1, in, clk, rstn);

    Butterfly BF1(C1_1, C2_1, A1, B1);
    mux M1_2 (F4_in, A1, C2_1, sel1);
    FIFO4 F4 (B1, F4_in, clk, reset);
    mux M1_1 (T1_in, B1, C1_1, sel1);
    Twiddle_Factor TW1(T1_out, T1_in, T1);
    mux M1_3 (st1_out, T1_out, T1_in, sel1);

    FIFO1 ST2_IN (A2, st1_out, clk, rstn);

    Butterfly BF2(C1_2, C2_2, A2, B2);
    mux M2_2 (F2_in, A2, C2_2, sel2);
    FIFO2 F2 (B2, F2_in, clk, reset);
    mux M2_1 (T2_in, B2, C1_2, sel2);
    Twiddle_Factor TW2(T2_out, T2_in, T2);
    mux M2_3 (st2_out, T2_out, T2_in, sel2);

    FIFO1 ST3_IN (A3, st2_out, clk, rstn);

    Butterfly BF3(C1_3, C2_3, A3, B3);
    mux M3_2 (st3_out, A3, C2_3, sel3);
    FIFO1 F1 (B3, F3_in, clk, reset);
    mux M3_1 (st3_out, B3, C1_3, sel3);

    FIFO1 FFT_OUT (out, st3_out, clk, rstn);

    // FSM을 병렬적으로 3개 만들어서, 각각의 FSM에서 계산하도록 설계.
    reg[1:0] st1_cur, st1_nxt;
    reg[1:0] st2_cur, st2_nxt;
    reg[1:0] st3_cur, st3_nxt;

    parameter idle = 2'b00, calc_add = 2'b01, calc_mult = 2'b10, finish = 2'b11;

    // state register를 위한 always sequential block
    always@(posedge clk) begin
        if(~rstn) begin
            st1_cur <= idle;
            st2_cur <= idle;
            st3_cur <= idle;
        end
        else begin
            st1_cur <= st1_nxt;
            st2_cur <= st2_nxt;
            st3_cur <= st3_nxt;
        end
    end

    always@(st1_cont, st2_cont, st1_cur, st2_cur, st3_cur) begin
        st1_nxt = st1_cur;
        st2_nxt = st2_cur;
        st3_nxt = st3_cur;
        case(st1_cur)
            idle: begin
                if(A1 >= 0) begin
                    st1_nxt = calc_mult;
                    sel1 = 1'b0;
                end
                else begin
                    st1_nxt = idle;
                end
            end
            calc_add: begin
                if(st1_cont == 1'b0) begin
                    st1_nxt = calc_mult;
                    sel1 = 1'b0;
                end
                else st1_nxt = calc_add;
            end
            calc_mult: begin
                case (cnt1)
                    3'b001: T1 = W0;
                    3'b010: T1 = W1;
                    3'b011: T1 = W2;
                    3'b000: T1 = W3;
                    default : T1 = 24'b0;
                endcase
                if(st1_cont == 1'b1) begin
                    st1_nxt = calc_add;
                    sel1 = 1'b1;
                end
                else st1_nxt = calc_mult;
            end
            finish: begin
                st1_nxt = idle;
            end
        endcase
        case(st2_cur)
            idle: begin
              if(A2 >= 0) begin
                    st2_nxt = calc_mult;
                    sel2 = 1'b0;
                end
                else begin
                    st2_nxt = idle;
                end
            end
            calc_add: begin
                if(st2_cont == 1'b0) begin
                    st2_nxt = calc_mult;
                    sel2 = 1'b0;
                end
                else st2_nxt = calc_add;
            end
            calc_mult: begin
                case (cnt2)
                    2'b10: T2 = W0;
                    2'b00: T2 = W2;
                    default : T2 = 24'b0;
                endcase
                if(st2_cont == 1'b1) begin
                    st2_nxt <= calc_add;
                    sel2 = 1'b1;
                end
                else st2_nxt = calc_mult;
            end
            finish: begin
                st2_nxt = idle;
            end
        endcase
        case(st3_cur)
            idle: begin
              if(A3 >= 0) begin
                    st3_nxt = calc_mult;
                end
                else begin
                    st3_nxt = idle;
                end
            end
            calc_add: begin
                sel3 = 1'b0;
                st3_nxt = calc_mult;
            end
            calc_mult: begin
                sel3 = 1'b1;
                st3_nxt = calc_add;
            end
            finish: begin
                st3_nxt = idle;
            end
        endcase
    end

endmodule

module FIFO4 (out, in, clk, rstn);
    output reg[24-1:0] out;
    input [24-1:0] in;
    reg [24-1:0] q0, q1, q2;
    input clk, rstn;
    always@(posedge clk) begin
        if(~rstn) begin
            out <= 24'b0;
            q0 <= 24'b0;
            q1 <= 24'b0;
            q2 <= 24'b0;
        end
        else begin
            q0 <= in;
            q1 <= q0;
            q2 <= q1;
            out <= q2;
        end
    end
endmodule

module FIFO2 (out, in, clk, rstn);
    output reg[24-1:0] out;
    input [24-1:0] in;
    reg [24-1:0] q0;
    input clk, rstn;
    always@(posedge clk) begin
        if(~rstn) begin
            out <= 24'b0;
            q0 <= 24'b0;
        end
        else begin
            q0 <= in;
            out <= q0;
        end
    end
endmodule

module FIFO1 (out, in, clk, rstn);
    output reg[24-1:0] out;
    input [24-1:0] in;
    reg [24-1:0] q0;
    input clk, rstn;
    always@(posedge clk) begin
        if(~rstn) begin
            out <= 24'b0;
        end
        else begin
            out <= in;
        end
    end
endmodule

// 2to1 mux
module mux(out, in0, in1, sel);
    output [24-1:0] out;
    input [24-1:0] in0, in1;
    input sel;

    // 0이면 in0, 1이면 in1
    assign out = ~sel ? in0 : in1;
endmodule

module cnt4 (cnt, flag, clk, rstn);
    output reg flag;
    output reg [2:0] cnt;
    input clk, rstn;
    always@(posedge clk) begin
        if(~rstn) begin
            cnt <= 3'b0;
            flag <= 1'b0;
        end
        else if(cnt == 3'b11) begin
            flag <= ~flag;
            cnt <= 3'b0;
        end
        else begin
            cnt <= cnt + 1'b1;
        end
    end
endmodule

module cnt2 (cnt, flag, clk, rstn);
    output reg flag;
    output reg [1:0]cnt;
    input clk, rstn;
    always@(posedge clk) begin
        if(~rstn) begin
            cnt <= 2'b0;
            flag <= 1'b0;
        end
        else if (cnt == 2'b01) begin
            cnt <= 2'b0;
            flag <= ~flag;
        end
        else begin
            cnt <= cnt + 1'b1;
        end
    end
endmodule