`include "doremi.v"     // piezo module
`include "rgb.v"        // full color led 
`include "lcd_menu.v"   // Text lcd
`include "counter.v"    // 100bit counter
`include "led8.v"       // led module -> syncrhronized with music
`include "music_1.v"    // saved notes
`include "music2.v"     // saved notes2
`include "music3.v"     // saved notes3
`include "counter2.v"   // 10bit counter
`include "score.v"      // score module

module rhythm(menu1, menu2, // menu button
             back, CLK, piezo, led, key,
             RESETN,LCD_E,LCD_RS,LCD_RW,LCD_DATA, // Text LCD button
             R,G,B); // LED 

    input menu1, menu2, back; // (dip 1,2, push *)
    //input [2:0]sel; // music select button (dip 3,4,5)
    input [7:0]key; // answer input butoon (push 1,2,3,4,5,6,7,8)
    input CLK, RESETN; // clock, reset button, (AB11, psuh #)
    reg [2:0]state_game; // states of game
    reg [2:0]state_lcd; // states of lcd
    reg en; // when game starts, reset score
    wire [5:0] rgb;
    wire em1,em2,em3;
    ////////////////////////// piezo //////////////////////////////
    output piezo;
    output [7:0] led; // led 1~8
    wire [3:0]notes, notes2, notes3; // music 1, 2, 3
    reg [3:0]music_input;
    ///////////////////////////////////////////////////////////////

    /////////////////////////// LCD ////////////////////////////////
    output LCD_E,LCD_RS,LCD_RW; // enable read mode, read write
    output [7:0]LCD_DATA; // data

    ///////////////////////////////////////////////////////////////

    ////////////////////////// LED ////////////////////////////////
    output [3:0] R,G,B;
    integer CNT;
    reg [1:0] R_IN,G_IN,B_IN;
    ///////////////////////////////////////////////////////////////
    LCD lcd_menu (RESETN,C_OUT,state_lcd,LCD_E,LCD_RS,LCD_RW,LCD_DATA);
    doremi doremi (RESETN, CLK, music_input, piezo); // reset, clk, input music, output piezo
    HB_FULL_LED LED (RESETN, CLK, R_IN, G_IN, B_IN, R,G,B); // reset, clk, input rgb, output rgb
    counter_100bit count1(RESETN, CLK, C_OUT);
    counter_100bit  count2(RESETN, C_OUT, C_OUT2); // make frequency 1/100
    //counter_100bit count3(RESETN, C_OUT2, C_OUT3);
    led8 led8(CLK, music_input, led); // clk, input music, output led
    music1 music1(C_OUT2, notes, key[0], em1); // if there is posedge sel[1], then notes initialized.
    music2 music2(C_OUT2, notes2, key[1], em2); // clk, output music, reset key, end music, key[1] is number 2
    music3 music3(C_OUT2, notes3, key[2], em3); // clk, output music, reset key, end music,key[2] is number 3
    score score(C_OUT2,RESETN,key,led,rgb,en); // clk, reset, input key, input led, output rgb, input en
    // if en is 1 start scoring
    
    always @(posedge CLK) begin
            case(state_game) 
                3'b000 : state_lcd = 3'b000; /// initial screen
                3'b001 : state_lcd = 3'b001; /// game start screen
                3'b010 : state_lcd = 3'b010;  /// score screen
                3'b011 : state_lcd = 3'b011; /// music1
                3'b100 : state_lcd = 3'b100; /// music2
                3'b101 : state_lcd = 3'b101; /// music3
                default : state_lcd = 3'b000; /// default is initial screen
            endcase
        end

    always @(posedge CLK) begin
        case(state_game) 
            3'b000 : {R_IN,G_IN,B_IN} <= 6'b100000;  /// initial : RED
            3'b001 : {R_IN,G_IN,B_IN} <= 6'b001000;  /// game : GREEN
            3'b010 : {R_IN,G_IN,B_IN} <= 6'b000010;  /// score : BLUE
            3'b011 : {R_IN,G_IN,B_IN} <= rgb;        /// music1
            3'b100 : {R_IN,G_IN,B_IN} <= rgb;        /// music2
            3'b101 : {R_IN,G_IN,B_IN} <= rgb;        /// music3
            default : {R_IN,G_IN,B_IN} <= 6'b100000; /// default : RED
        endcase
    end


    always @(posedge CLK or posedge RESETN) begin
        if (RESETN)
            begin
               state_game = 3'b000;
            end
        else if(state_game == 3'b000) // when initial screen
            begin
                if(menu1) begin  // if menu1 is 1
                    state_game = 3'b001; // initial screen -> game start
                    end
                else if(menu2) begin // if menu2 is 1
                    state_game = 3'b010; // initial screen -> score
                    end
            end
        else if(state_game == 3'b001) // when game start
            begin
                if(back) begin // if we push back button, we come back to initial screen.
                    state_game = 3'b000;
                    end
                else if(key) begin // if sel is 1
                    if(key == 8'b00000001) begin
                        en = 1'b1;
                        state_game = 3'b011; // music 1 start
                        end
                    else if(key == 8'b00000010) begin
                        en = 1'b1;
                        state_game = 3'b100;
                        end
                    else if(key == 8'b00000100) begin
                        en = 1'b1;
                        state_game = 3'b101;
                        end
                    else begin
                        music_input = 4'd14;
                        end
                end
            end
        else if(state_game == 3'b010) // when score mode
            begin
                if(back) begin // if we push back button, we come back to initial screen.
                    state_game = 3'b000; //start screen
                    end
            end
        else if(state_game == 3'b011)  // music1
            begin
                music_input = notes; // 
                if(back) begin // if we push back button, we come back to initial screen.
                    en = 1'b0;
                    state_game = 3'b001; //game mode
                    end
                else if(em1 == 1'b1) begin
                    en = 1'b0;
                    state_game = 3'b001;
                    end
            end
        else if(state_game == 3'b100)  // music2
            begin
                music_input = notes2; 
                if(back) begin // if we push back button, we come back to initial screen.
                    en = 1'b0;
                    state_game = 3'b001; //game mode
                    end
                else if(em2 == 1'b1) begin
                    en = 1'b0;
                    state_game = 3'b001;
                    end
            end
        else if(state_game == 3'b101)  // music3
            begin
                music_input = notes3;
                if(back) begin // if we push back button, we come back to initial screen.
                    en = 1'b0;
                    state_game = 3'b001; //game mode
                    end
                else if(em3 == 1'b1) begin
                    en = 1'b0;
                    state_game = 3'b001;
                    end
            end

    end

endmodule