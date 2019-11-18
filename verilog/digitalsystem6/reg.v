`include "d_ff.v"
module register(CLK, SI, SO);
   input SI, CLK;
   output [3:0] SO;
   wire[3:0] SO;
   D_FF F1(.CLK(CLK), .D(SI), .set(1'b0),.Q(SO[0]), .nQ());
   D_FF F2(.CLK(CLK), .D(SO[0]),.set(1'b0), .Q(SO[1]), .nQ());
   D_FF F3(.CLK(CLK), .D(SO[1]),.set(1'b0), .Q(SO[2]), .nQ());
   D_FF F4(.CLK(CLK), .D(SO[2]),.set(1'b0), .Q(SO[3]), .nQ());
endmodule