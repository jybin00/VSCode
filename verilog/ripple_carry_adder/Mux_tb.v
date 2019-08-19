`include "Mux.v"

module Mux_tb;

reg [3:0] In; // 변하는 값은 reg
reg [1:0] Sel; // 변하는 값은 reg // reg는 initial or alaways 구문 안에서만 할당 가능
wire Out;
integer i;

Mux mux0 (In,Sel,Out);

initial begin
    $dumpfile("Mux_tb.vcd");
    $dumpvars(0,Mux_tb);
    for(i = 0; i < 4; i = i+1) 
    begin
        In <= 4'b1001;
        Sel <= i;
        #500;
    end
    #500
    $finish;
end

endmodule // In,