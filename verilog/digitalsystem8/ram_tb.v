`include "ram.v"

module ram_tb;

reg [3:0]Data,Address;
reg WR,RD;
reg clk;
wire [3:0]Out;


ram  ram1(Data, Out, WR, RD, Address, clk);

always begin 
    #1 clk <= ~clk; 
    end

initial begin
    $dumpfile("ram_tb.vcd");
    $dumpvars(0,ram_tb);
    clk <= 1'b0;
    WR <= 1'b1; RD <= 1'b0;
    Address <= 4'b1010;
    Data <= 4'b0011; #1.5;

    WR <= 1'b1; RD <= 1'b0;
    Address <= 4'b0111;
    Data <= 4'b1001; #1.5;

    WR <= 1'b0; RD <= 1'b1;
    Address <= 4'b1010; #1.5;

    WR <= 1'b0; RD <= 1'b1;
    Address <= 4'b0111; #1.5;

    WR <= 1'b0; RD <= 1'b1;
    Address <= 4'b0011; #1.5;
    $finish;
    end

endmodule