module d_ff2 (q,clk,reset,out);

input [20:0]q;
input clk;
input reset;
output reg [20:0]out;

always@ (posedge clk)
begin
    if(~reset)
    begin
        out <= 21'b0;
    end
    else 
    begin
        out <= q;
    end

end

endmodule