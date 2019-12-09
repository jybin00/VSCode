module counter_10bit (reset, clk, c_out);

input reset, clk;
output c_out;

reg [3:0]count = 4'b0000;
reg q = 1'b0;
assign c_out = q;

always@(posedge clk) begin
    if(reset) begin
        count <= 4'b0000;
        q <= 1'b0;
        end
    else begin
        count = count + 1;
        if(count == 4'b0101) begin
            q <= ~q;
            count <= 4'b0000;
        end
    end
end

endmodule