module ram (Data, Out1, Out2, WR1, WR2, RD1, RD2, Address1, Address2, clk);

input WR1,RD1; // 입력 출력 버튼 2개씩
input WR2,RD2;
input [3:0] Address1,Address2;
input [3:0] Data;
input clk;
output [3:0]Out1, Out2;
reg [3:0] SRAM1 [15:0];
reg [3:0] SRAM2 [15:0];
reg [3:0] Q1,Q2;

assign Out1 = Q1;
assign Out2 = Q2;


always @ (posedge clk || RD1 || Address1)
    if(WR1 == 1 && RD1 == 0) 
        begin
        SRAM1[Address1] <= Data;
        Q1 <= 4'bZ;
        end 
    else if(RD1 == 1)
        begin
        Q1 <= SRAM1[Address1];
        end
    else if (WR1 == 1)
        begin
        SRAM1[Address1] <= Data;
        end

always @ (posedge clk || RD2 || Address2)
    if(WR2 == 1 && RD2 == 0) 
        begin
        SRAM2[Address2] <= Data+1'b1;
        Q2 <= 4'bZ;
        end 
    else if(RD2 == 1)
        begin
        Q2 <= SRAM2[Address2];
        end
    else if (WR2 == 1)
        begin
        SRAM2[Address2] <= Data+1'b1;
        end

endmodule