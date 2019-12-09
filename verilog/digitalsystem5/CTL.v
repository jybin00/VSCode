`include "BCD_converter.v"
`include "BCD_to_seven.v"
`include "sevencon.v"

module Control(
    CLK,
    I3,I2,I1,I0,
    N_Reset,
    SEG_COM, SEG_DATA
);

input CLK, I3,I2,I1,I0,N_Reset;
output [7:0] SEG_COM, SEG_DATA;

wire [9:0]T;
wire A1,B1,C1,D1,E1,F1,G1,A2,B2,C2,D2,E2,F2,G2;

BCD_converter u1({I3,I2,I1,I0}, {T9,T8,T7,T6,T5,T4,T3,T2,T1,T0});

BCD_to_seven u2_1({T3,T2,T1,T0}, {A1,B1,C1,D1,E1,F1,G1,Z});
BCD_to_seven U2_2({T7,T6,T5,T4}, {A2,B2,C2,D2,E2,F2,G2,Z});
SevenSeg_CTRL u3(CLK, N_Reset, {A1,B1,C1,D1,E1,F1,G1,1'b0},{A2,B2,C2,D2,E2,F2,G2,1'b0},8'b0,8'b0,8'b0,8'b0,8'b0,8'b0, SEG_COM, SEG_DATA);

endmodule