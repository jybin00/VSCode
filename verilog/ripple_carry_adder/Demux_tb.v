`include "Demux.v"

module Demux_tb;

reg In;
wire [3:0] Out;
reg [1:0] Sel;
integer i;

DeMux demux0 (In,Out,Sel);

initial begin
    $dumpfile("Demux_tb.vcd");
    $dumpvars(0,Demux_tb);
    for(i = 0; i < 4; i = i+1) 
    begin
        Out <= 4'b1111;
        In <= 1'b1;
        Sel <= i;
        #500;
    end
    $finish;
end



endmodule // In,Ouel

