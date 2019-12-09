`include "CTL.v"
module CTLtb;

reg clk; 
reg I3,I2,I1,I0,N_Reset;
wire [7:0] SEG_COM, SEG_DATA;

always #5 clk = ~clk;

Control CTL(clk, I3, I2, I1, I0, N_Reset, SEG_COM, SEG_DATA);

always@(posedge clk) begin
    N_Reset <= 1'b1; #10;
    N_Reset <= 1'b0; #10;
    I3<= 1'b1; I2<= 1'b0; I1<= 1'b0; I0<=1'b0; #100;
    //I3<= 1'b0; I2<= 1'b1; I1<= 1'b0; I0<=1'b0; #100;
    //I3<= 1'b1; I2<= 1'b1; I1<= 1'b1; I0<=1'b0; #100;
    //I3<= 1'b0; I2<= 1'b0; I1<= 1'b1; I0<=1'b1; #100;
    //I3<= 1'b0; I2<= 1'b0; I1<= 1'b0; I0<=1'b1; #100;
end
endmodule