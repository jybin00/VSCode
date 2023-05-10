// 19bits counter for memory controll 
module counter_19b(cnt, clk, start);
    output [19-1:0]cnt;
    input clk;
    input start;
    reg [19-1:0]cnt = 19'b0;

    always@(posedge clk)
    begin
        // If cnt MSB is one, then stop counter
        if(cnt[19-1] == 1'b1) cnt <= 19'bx;
        else if(start == 1'b1) cnt <= 19'b0;
        else cnt <= cnt + 1;
    end
endmodule