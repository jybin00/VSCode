`timescale 100us/1us
`include "counter.v"

module counter_tb;

reg clk;
reg reset;
wire c_out;

always #5 clk <= ~clk;

counter_10bit counter(reset, clk, c_out);

initial begin
    $dumpfile("counter_tb.vcd");
    $dumpvars(0,counter_tb);
    reset <= 1; clk <= 1; #10;
    reset <= 0; #1000;
    $finish;
end

endmodule


