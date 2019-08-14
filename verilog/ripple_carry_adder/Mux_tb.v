`include "Mux.v"

module Mux_tb;

reg [3:0] In;
reg [1:0] Sel;
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