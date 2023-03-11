`include "ripple_carry_counter_5bits.v"
`timescale 1ns/10ps

module r_counter_tb;

reg clk;
reg reset;
wire [4:0] q;


// instatiate the desian block 
ripple_carry_counter_5bits r1(.clk(clk), .reset(reset), .q(q));

// Control the clk signal that drives the design block.
// cycle time = 10

initial
    clk = 1'b0; // set clk to 0
always
    #5 clk = ~clk; // toggle clk every 5 time units

// Control the reset signal that drives the design block.
// reset is asserted from 0 to 20 and from 200 to 220.
initial
begin
$dumpfile("r_counter_tb.vcd");
$dumpvars(0,r_counter_tb);

             reset = 1'b1;
    #15;     reset = 1'b0;
    #180;    reset = 1'b1;
    #10;     reset = 1'b0;
    #20;     $finish;  // terminate the simulation

end

// Monitor the outputs initial
//initial
//$monitor ($time, " Output q = %d", q);
endmodule