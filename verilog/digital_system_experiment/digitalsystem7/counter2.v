module updncounter(clk, reset, updn, q);
input clk, reset, updn;
output [3:0]q;
reg [3:0]q;
always @ (posedge reset or posedge clk)
begin
if (reset) 
    q=4'b0000;
else if (~updn)
    if (q==4'b1111) 
        q=4'b0000;
    else q=q+1'b1;

else if(updn)
    if(q==4'b0000) 
        q=4'b1111;
else 
    q=q-1'b1;
end
endmodule