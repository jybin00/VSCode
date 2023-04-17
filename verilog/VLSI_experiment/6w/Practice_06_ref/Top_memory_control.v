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

    // 곱셈기 출력 받아서 바로 DATA_out으로 출력.
    multiplier_csa_26b mul (out, DO[52-1:26], DO[25:0], clk, rstn);  

    // out은 클럭에 동기화 시키지 말고 바로 DIN하고 연결 해줘야 함.
    rflp128x52mx4 MEMORY (DO, out, RA, CA, NWRT, NCE, clk);  
    
    assign DATA_out = DO;

    initial
    begin 
        if(rstn == 1'b0)
        begin
            // rstn이 0일 때, 카운터가 바로 시작되도록 stimulus가 코딩되어 있어서
            // 이런 식으로 미리 값을 넣어줌. stimulus에서 MEMORY를 봐보면 이 값이 한 클럭 후에 들어가는 것을 알 수 있음.
            // 한 클럭 후에 들어가는게 딱 수업 자료에서 보이는 그림하고 똑같은 상황
            NCE <= 1'b0; NWRT <= 1'b1; {RA, CA} <= ADDR; 
        end
    end

    always@ (posedge clk)
        begin
            if(rstn)
            begin
                // 이 케이스 문도 시뮬레이션에서는 Read와 Wrtie가 한 클럭씩 밀려서 들어가는 것 처럼 보일텐데
                // 그 이유가 조교님이 제공해주신 SRAM 안에도 FF이 들어 있어서 그럼.
                // 그래서 마치 write가 다음 주소에 들어가는 것 '처럼' 보이지만, 실제로는 그 전 주소에 잘 들어가는 걸로 생각하면 됨.
                case(State_counter)
                2'b00: begin NCE <= 1'b0; NWRT <= 1'b1; {RA, CA} <= ADDR; end // Read 
                2'b01: begin NCE <= 1'b1; NWRT <= 1'b0;  end  
                2'b10: begin NCE <= 1'b1; NWRT <= 1'b0;  end   
                2'b11: begin NCE <= 1'b0; NWRT <= 1'b0; {RA, CA} <= ADDR; end // Write
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