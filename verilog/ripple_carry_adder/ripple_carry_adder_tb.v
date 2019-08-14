`include "ripple_carry_adder.v"

module ripple_carry_adder_tb;

reg [9:0] A,B;
reg C_in;
wire [9:0] Sum;
wire C_out;

ripple_carry_adder rca(A,B,C_in,Sum,C_out);

initial begin
$dumpfile("ripple_carry_adder_tb.vcd");
$dumpvars(0,ripple_carry_adder_tb);

    A <= 10'd20; B <= 10'd30; C_in <= 10'd0;
#5  A <= 10'd31; B <= 10'd41; C_in <= 10'd1;
#5
$finish;
end




endmodule