`include "rhythm.v"
`timescale 1us/100ns

module rtb;

reg menu1, menu2, back;
reg CLK, RESETN;
reg [7:0]key;
wire [7:0]led;
wire piezo;

wire LCD_E, LCD_RS, LCD_RW;
wire [7:0]LCD_DATA;

wire [3:0] R,G,B;

rhythm rhythm(menu1, menu2, back, CLK, piezo, led, key, RESETN, LCD_E,
            LCD_RS, LCD_RW, LCD_DATA, R, G, B);

always #1 CLK <= ~CLK;

initial 
    begin
        $dumpfile("rtb.vcd");
        $dumpvars(0,rtb);
        CLK <= 1'b0; back<= 1'b0; menu2 <= 1'b0; 
        key <= 0;
        RESETN <= 1'b1; #100;
        RESETN <= 1'b0; #10;
        menu1 <= 1'b1; #1000;
        menu1 <= 1'b0; back<= 1'b1; #1000;
        back <= 1'b0; menu2 <= 1'b1; #1000;
        menu2 <= 1'b0; back <= 1'b1; #1000;
        back <= 1'b0; menu1 <= 1'b1; #1000;
        key <= 8'b00000001; #1500;
        key <= 0; #100;
        key <= 8'b00000001; #1000;
        key <= 8'b00000010; #40000;
        back <= 1'b1; #1000;
        back <= 1'b0; #1000;
        key <= 8'b00000010; #4000;
        key <= 0; #40000;

        $finish;
    end
endmodule