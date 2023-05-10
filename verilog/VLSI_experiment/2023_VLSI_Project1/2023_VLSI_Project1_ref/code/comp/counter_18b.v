// 18bits counter for memory controll 
module counter_18b(cnt, clk, rstn, start);
    output [18-1:0]cnt;
    input clk, rstn;
    input start;
    reg [18-1:0]cnt;

    always@(posedge clk)
    begin
        if(rstn == 1'b0) cnt <= 18'b0;
        else if(start == 1'b1) cnt <= 18'b0;
        else cnt <= cnt + 1;
    end
endmodule