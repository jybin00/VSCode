module DeMux (In,Out,Sel);

input In; // input에는 net 타입만 할당 가능, net 타입의 종류 중 가장 유명한 net이 wire
output [3:0] Out;
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