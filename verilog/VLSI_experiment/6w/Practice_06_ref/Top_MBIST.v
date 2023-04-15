`timescale 1 ns / 10 ps
`include "rflp128x52mx4.v"

module Top_MBIST(DATA_out, MBIST_done, MBIST_start, clk, rstn);
    output [52-1:0] DATA_out;
    output reg MBIST_done;
    input  MBIST_start;
    input  clk;
    input  rstn;

    wire [7-1:0] ADDR;
    wire [3-1:0] State_counter;
    reg [5-1:0] RA;
    reg [2-1:0] CA;
    reg NWRT, NCE;
    reg [52-1:0] Data_IN;
    counter_10b count({State_counter, ADDR}, clk, rstn);

    rflp128x52mx4 sram(DATA_out, Data_IN, RA, CA, NWRT, NCE, clk);

    always@ (posedge clk)
    begin
        if (MBIST_start == 1'b1)
            begin
                NCE <= 1'b0;
            end

        else if(State_counter[0] == 1'b0)
            begin
                NWRT <= 1'b0; // 메모리에 쓰기 시작.
                case (State_counter[2:1])
                    2'b00 : Data_IN <= 52'h0;
                    2'b01 : Data_IN <= 52'hfffffffffffff;
                    2'b10 : Data_IN <= 52'h5555555555555;
                    2'b11 : Data_IN <= 52'haaaaaaaaaaaaa;
                endcase
                {RA, CA} <= ADDR;
            end
        else if (State_counter[0] == 1'b1)
            begin
                NWRT <= 1'b1; // 메모리에서 읽기 시작.
                {RA, CA} <= ADDR;
            end
        if({State_counter, ADDR} == 10'b1111111111)
        begin
            MBIST_done <= 1'b1;
        end

        else
        begin end
    end
endmodule

module counter_10b (cnt, clk, rstn);
    output [10-1:0] cnt;
    input  clk, rstn;
    reg [10-1:0] cnt;

    always@(posedge clk or rstn)
    begin
        if(~rstn)
            begin  
                cnt <= 10'b0;
            end
        else if(cnt == 10'b1111111111)
            begin
                cnt <= 10'b0;
            end
        else
            begin
                cnt <= cnt + 1'b1;
            end
    end
endmodule