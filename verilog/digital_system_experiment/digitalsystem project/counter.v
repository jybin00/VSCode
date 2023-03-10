module counter_100bit (reset, clk, c_out);

input reset, clk;
output c_out;

reg [5:0]count = 6'b000000;
reg q = 1'b0;
assign c_out = q;

always@(posedge clk) begin
    if(reset) begin
        count <= 6'b000000;
        q <= 1'b0;
        end
    else begin
        count = count + 1;
        if(count == 6'b110010) begin
            q <= ~q;
            count <= 6'b000000;
        end
    end
end

endmodule