module d_ff (q,clk,reset,out);

input [4:0] q;
input clk;
input reset;
output reg [4:0] out;

always@ (posedge clk)
begin
if(~reset)
    begin
        out<= 5'b00000;
    end
else
    begin
        out <= q;
    end
end

endmodule