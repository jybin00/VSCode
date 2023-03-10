`include "full_adder.v"
`timescale 100ps/1ps

module full_adder_tb;

reg A,B;
reg cin;
wire sum,cout;

full_adder fa0 (A,B,cin,sum,cout);

initial begin
    $dumpfile("full_adder_tb.vcd");
    $dumpvars(0,full_adder_tb);
        A<=1'b0; B<= 1'b0; cin <= 1'b0;
    #10 A<=1'b0; B<= 1'b0; cin <= 1'b1;
    #10 A<=1'b0; B<= 1'b1; cin <= 1'b0;
    #10 A<=1'b0; B<= 1'b1; cin <= 1'b1;
    #10 A<=1'b1; B<= 1'b0; cin <= 1'b0;
    #10 A<=1'b1; B<= 1'b0; cin <= 1'b1;
    #10 A<=1'b1; B<= 1'b1; cin <= 1'b0;
    #10 A<=1'b1; B<= 1'b1; cin <= 1'b1;
    $finish;

end

endmodule
