module DeMux (In,Out,Sel);

input In;
output reg [3:0] Out;
input [1:0] Sel;

always @(In,Sel)
begin
    case (Sel)
        2'b00: Out[0] <= In;
        2'b01: Out[1] <= In;
        2'b10: Out[2] <= In;
        2'b11: Out[3] <= In;
    endcase
end

endmodule