   module HB_FULL_LED (RESETN, CLK, R_IN, G_IN, B_IN, R,G,B);

    input RESETN,CLK;
    input [1:0] R_IN,G_IN,B_IN;
    output [3:0] R,G,B;

    integer CNT;
    integer R_REG, G_REG, B_REG;

    reg[3:0] R, G, B;

always @ (posedge RESETN or posedge CLK) begin
if(RESETN)
R_REG=0;
else
case(R_IN)
2'b00 : R_REG = 0;
2'b01 : R_REG = 33;
2'b10 : R_REG = 66;
2'b11 : R_REG = 100;
endcase
end

always @ (posedge RESETN or posedge CLK) begin
if(RESETN)
G_REG=0;
else
case(G_IN)
2'b00 : G_REG = 0;
2'b01 : G_REG = 33;
2'b10 : G_REG = 66;
2'b11 : G_REG = 100;
endcase
end

always @ (posedge RESETN or posedge CLK) begin
if(RESETN)
B_REG=0;
else
case(B_IN)
2'b00 : B_REG = 0;
2'b01 : B_REG = 33;
2'b10 : B_REG = 66;
2'b11 : B_REG = 100;
endcase
end


always @(posedge RESETN or posedge CLK) begin
   if (RESETN)
      CNT = 0;
   else
      if (CNT>=99) CNT = 0;
      else CNT = CNT + 1;
   end

    always @(posedge RESETN or posedge CLK) begin
        if(RESETN) R = 4'b0000;
        else if (CNT < R_REG) R = 4'b1111;
        else R = 4'b0000;
    end

    always @(posedge RESETN or posedge CLK) begin
        if(RESETN) G = 4'b0000;
        else if (CNT < G_REG) G = 4'b1111;
        else G = 4'b0000;
    end

    always @(posedge RESETN or posedge CLK) begin
        if(RESETN) B = 4'b0000;
        else if (CNT < B_REG) B = 4'b1111;
        else B = 4'b0000;
    end

endmodule