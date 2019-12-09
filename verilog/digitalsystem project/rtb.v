`include "rhythm.v"
`timescale 1us/100ns

module rtb;

reg menu1, menu2, back;
reg [2:0]sel;
reg CLK, RESETN;
reg [7:0]key;
wire [7:0]led;
wire piezo;

wire LCD_E, LCD_RS, LCD_RW;
wire [7:0]LCD_DATA;

wire [3:0] R,G,B;

rhythm rhythm(menu1, menu2, back, sel, CLK, piezo, led, key, RESETN, LCD_E,
            LCD_RS, LCD_RW, LCD_DATA, R, G, B);

always #1 CLK <= ~CLK;

initial 
    begin
        $dumpfile("rtb.vcd");
        $dumpvars(0,rtb);
        CLK <= 1'b0; back<= 1'b0; menu2 <= 1'b0; 
        sel <=3'b000;
        RESETN <= 1'b1; #100;
        RESETN <= 1'b0; #10;
        menu1 <= 1'b1; #1000;
        menu1 <= 1'b0; back<= 1'b1; #1000;
        back <= 1'b0; menu2 <= 1'b1; #1000;
        menu2 <= 1'b0; back <= 1'b1; #1000;
        back <= 1'b0; menu1 <= 1'b1; #1000;
        sel <= 3'b100; #150000;

        $finish;
    end
endmodule