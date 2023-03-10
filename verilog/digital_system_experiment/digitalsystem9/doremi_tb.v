`include "doremi.v"
`timescale 1us/100ns
module doremi_tb;

reg [7:0]key;
reg reset,clk;
wire piezo;

doremi do(reset, clk, key, piezo);

always begin 
    #10 clk <= ~clk; 
    end

initial begin
    $dumpfile("doremi_tb.vcd");
    $dumpvars(0,doremi_tb);

    reset = 1; clk = 0; #15;
    reset = 0; #5;

    key = 8'b00000001; #10000;
    key = 8'b00000100; #10000;
    key = 8'b00010000; #10000;
    key = 8'b01000000; #10000;


    $finish;

end


endmodule