`include "reg.v"
module register_tb;

reg SI,CLK;
wire [3:0]SO;

always #5 CLK <= ~CLK;

register reg1(CLK, SI, SO);

initial begin
    $dumpfile("reg_tb.vcd");
    $dumpvars(0,register_tb);
    CLK <= 1'b0;
    SI <= 1'b0; #50;
    SI <= 1'b1; #50;
    SI <= 1'b0; #50;
    SI <= 1'b1; #50;
    SI <= 1'b0; #50;
    $finish;
end

endmodule