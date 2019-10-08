module Mux (In,Sel,Out);

input [1:0] In;
output reg Out;
input Sel;

always @(In,Sel)
begin
    case (Sel)
        2'b00: Out = In[0];
        2'b01: Out = In[1];
    endcase
end
endmodule