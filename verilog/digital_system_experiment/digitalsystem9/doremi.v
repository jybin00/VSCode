`timescale 1us/100ns
module doremi (reset, clk, key, piezo);

input clk,reset;
input [7:0] key;
output piezo;
reg buff;
integer cnt, limit;
wire piezo;

assign piezo = buff;

always@(key)
begin
    case(key)
        8'b10000000: limit = 12'd1911; // 높은 도
        8'b01000000: limit = 12'd2025; // 시
        8'b00100000: limit = 12'd2273; // 라
        8'b00010000: limit = 12'd2551; // 솔
        8'b00001000: limit = 12'd2864; // 파
        8'b00000100: limit = 12'd3034; // 미
        8'b00000010: limit = 12'd3405; // 레
        8'b00000001: limit = 12'd3822; // 도
        default : limit = 1'b0;
    endcase
end

always@(posedge clk)
begin
    if(reset)
        begin
            buff <= 1'b0;
            cnt <= 1'b0;
        end
    else
        begin
            if(buff == 1'b0)
            begin
                for(cnt= 1'b0; cnt < limit/2; cnt = cnt +1)
                begin
                    #1;
                end
                buff <= 1'b1;
            end
            else 
            begin
                for(cnt= 1'b0; cnt < limit/2; cnt = cnt +1)
                begin
                    #1;
                end
                buff <= 1'b0;
            end
        end
end

endmodule
