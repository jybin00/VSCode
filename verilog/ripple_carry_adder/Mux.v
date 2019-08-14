module Mux (In,Sel,Out);

input [3:0] In;
output reg Out;
input [1:0]Sel;

always @(In,Sel)
begin
    case (Sel)
        2'b00: Out = In[0];
        2'b01: Out = In[1];
        2'b10: Out = In[2];
        2'b11: Out = In[3];
    endcase
end
endmodule