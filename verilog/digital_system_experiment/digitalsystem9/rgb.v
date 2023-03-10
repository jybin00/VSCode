module HB_FULL_LED (RESETN, CLK, R_IN, G_IN, B_IN, R,G,B);

    input RESETN,CLK;
    input [1:0] R_IN,G_IN,B_IN;
    output [3:0] R,G,B;

    integer CNT;
    integer R_REG, G_REG, B_REG;

    reg[3:0] R, G, B;





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