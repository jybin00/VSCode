module ram (Data, Out, WR, RD, Address, clk);

input WR,RD;
input [3:0] Address, Data;
input clk;
output [3:0]Out;
reg [3:0] SRAM [15:0];
reg [3:0] Q;
assign Out = Q;


always @ (posedge clk)
    if(WR == 1 && RD == 0) 
        begin
        SRAM[Address] <= Data;
        Q <= 4'bZ;
        end 
    else if(RD == 1)
        begin
        Q <= SRAM[Address];
        end
    else if (WR == 1)
        begin
        SRAM[Address] <= Data;
        end

endmodule