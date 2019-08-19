`include "Mux.v"
`include "d_ff.v"
`include "d_ff2.v"

module CSA (A,B,Out,clk,reset);

input clk,reset;
input [19:0] A,B;
input wire C_in;
reg [4:0] d_ff000,d_ff001,
          d_ff100,d_ff101,
          d_ff200,d_ff201,
          d_ff300,d_ff301,
          d_ff400,d_ff401;
output wire [20:0] Out;
output wire [4:0]Carry;
wire [4:0]Mux_in00, Mux_in01, Mux_in10, Mux_in11,
          Mux_in20, Mux_in21, Mux_in30, Mux_in31,
          Mux_in40, Mux_in41;
wire [19:0]Sum;



Mux_2to1 mux0 (Mux_in00, Mux_in01, 1'b0,     Sum[3:0],   Carry[0]);
Mux_2to1 mux1 (Mux_in10, Mux_in11, Carry[0], Sum[7:4],   Carry[1]);
Mux_2to1 mux2 (Mux_in20, Mux_in21, Carry[1], Sum[11:8],  Carry[2]);
Mux_2to1 mux3 (Mux_in30, Mux_in31, Carry[2], Sum[15:12], Carry[3]);
Mux_2to1 mux4 (Mux_in40, Mux_in41, Carry[3], Sum[19:16], Carry[4]);

d_ff d00 (d_ff000,clk,reset,Mux_in00);
d_ff d01 (d_ff001,clk,reset,Mux_in01);
d_ff d10 (d_ff100,clk,reset,Mux_in10);
d_ff d11 (d_ff101,clk,reset,Mux_in11);
d_ff d20 (d_ff200,clk,reset,Mux_in20);
d_ff d21 (d_ff201,clk,reset,Mux_in21);
d_ff d30 (d_ff300,clk,reset,Mux_in30);
d_ff d31 (d_ff301,clk,reset,Mux_in31);
d_ff d40 (d_ff400,clk,reset,Mux_in40);
d_ff d41 (d_ff401,clk,reset,Mux_in41);

d_ff2 d200 ({Carry[4],Sum},clk,reset,Out);


always @ * begin
    d_ff000[4:0] <= A[3:0] + B[3:0] + 1'b0;
    d_ff001[4:0] <= A[3:0] + B[3:0] + 1'b1;

    d_ff100[4:0] <= A[7:4] + B[7:4] + 1'b0;
    d_ff101[4:0] <= A[7:4] + B[7:4] + 1'b1;

    d_ff200[4:0] <= A[11:8] + B[11:8] + 1'b0;
    d_ff201[4:0] <= A[11:8] + B[11:8] + 1'b1;

    d_ff300[4:0] <= A[15:12] + B[15:12] + 1'b0;
    d_ff301[4:0] <= A[15:12] + B[15:12] + 1'b1;

    d_ff400[4:0] <= A[19:16] + B[19:16] + 1'b0;
    d_ff401[4:0] <= A[19:16] + B[19:16] + 1'b1;
end

endmodule