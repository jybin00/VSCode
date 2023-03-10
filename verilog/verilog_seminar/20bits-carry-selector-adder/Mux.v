module Mux_2to1 (A,B,Sel,Out,Carry);

input [4:0] A,B; // A,B는 계산되어서 들어오는 값임. 원래 입력되는 값 X
input Sel;
output reg Carry;
output reg [3:0] Out; // MSB는 carry_out임 헷갈리지 마셈.

always @ * begin
    case(Sel)
    1'b0 : begin
            Out[3:0] <= A[3:0];  // 계산한 값은 d_ff에 넣어주고
            Carry <= A[4];       // 케리는 옆에 adder로 넘겨주기
           end
    1'b1 : begin 
            Out[3:0] <= B[3:0];
            Carry <= B[4];
           end
    endcase
end

endmodule