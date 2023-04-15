`timescale 1 ns/ 10 ps

`include "rflp128x52mx4.v"
`include "multiplier_csa_26b.v"

module Top_memory_control(DATA_out, clk, rstn);
    output [52-1:0] DATA_out;
    input clk, rstn;

    wire [7-1:0] ADDR;
    wire [2-1:0] State_counter;
    wire [52-1:0] DO;
    wire [52-1:0] out;
    reg [2-1:0] CA;
    reg [5-1:0] RA;
    reg NCE, NWRT;

    counter_9b counter ({ADDR, State_counter}, clk, rstn);
    multiplier_csa_26b mul (out, DO[52-1:26], DO[25:0], clk, rstn);
    rflp128x52mx4 MEMORY (DO, out, RA, CA, NWRT, NCE, clk);  // out은 클럭에 동기화 시키지 말고 바로 DIN하고 연결 해줘야 함.
    
    assign DATA_out = DO;

    initial
    begin 
        if(rstn == 1'b0)
        begin
            NCE <= 1'b0; NWRT <= 1'b1; {RA, CA} <= ADDR;
        end
    end

    always@ (posedge clk)
        begin
            if(rstn)
            begin
                case(State_counter)
                2'b00: begin NCE <= 1'b0; NWRT <= 1'b1; {RA, CA} <= ADDR; end  
                2'b01: begin NCE <= 1'b1; NWRT <= 1'b0;  end  
                2'b10: begin NCE <= 1'b1; NWRT <= 1'b0;  end   
                2'b11: begin NCE <= 1'b0; NWRT <= 1'b0; {RA, CA} <= ADDR; end
 
                endcase
            end
            else begin end

        end

endmodule

module counter_9b (cnt, clk, rstn);
    output [9-1:0] cnt;
    input  clk, rstn;
    reg [9-1:0] cnt;
    
    always@ (posedge clk or rstn)
    begin
        if (~rstn) begin cnt <= 9'b0; end
        else if(cnt == 9'b111111111)
            begin
                cnt <= 9'b0;
            end
        else
            begin
                cnt <= cnt + 1'b1;
            end
    end

endmodule