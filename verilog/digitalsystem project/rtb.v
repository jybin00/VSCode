`include "rythm.v"
`timescale 1us/100ns

module rtb;

reg menu1, menu2, back;
reg [2:0]sel;
reg CLK, RESETN;
reg [7:0] key;
wire piezo;

wire LCD_E, LCD_RS, LCD_RW;
wire [7:0]LCD_DATA;

wire [3:0] R,G,B;

rythm rythm(menu1, menu2, back, sel, key,CLK, piezo, RESETN, LCD_E,
            LCD_RS, LCD_RW, LCD_DATA, R, G, B);

always #1 CLK <= ~CLK;

initial 
    begin
        $dumpfile("rtb.vcd");
        $dumpvars(0,rtb);
        CLK <= 1'b0; back<= 1'b0; menu2 <= 1'b0; 
        RESETN <= 1'b1; #1000;
        RESETN <= 1'b0; #10;
        menu1 <= 1'b1; #10000;
        menu1 <= 1'b0; back<= 1'b1; #1000;
        back <= 1'b0; menu2 <= 1'b1; #10000;
        $finish;
    end
endmodule