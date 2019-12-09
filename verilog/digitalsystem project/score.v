module score(clk,reset,a,b,light,en);
   
input clk,en,reset;
input [7:0]a,b;
output [5:0]light;
reg [7:0]r;
reg [5:0]q;
reg [5:0]rgb;

assign light = rgb;

always@(posedge clk) begin
    if(reset) begin
        q = 0;
        end
    else if(en == 1'b1 )begin
        r = a^b;   
        if(r == 8'b00000000)   
            q = q + 1'b1;
        else
            q = q;
    end
end

always @(posedge clk) begin
    if(q>=60) begin
        rgb = 6'b001100; // green
        end

    else if(q>=30 && q <60) begin
        rgb = 6'b000011; // blue
        end

    else if(q>=0 && q <30) begin
        rgb = 6'b110000; // red
        end
end

endmodule