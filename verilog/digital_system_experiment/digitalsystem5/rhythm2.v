
module rhythm(menu1, menu2, // menu button
             back, sel, CLK, piezo, led, key,
	           en,q, // comparator
             RESETN,LCD_E,LCD_RS,LCD_RW,LCD_DATA, // Text LCD button
             R,G,B); // LED 

    input menu1, menu2, back; // (dip 1,2, push *)
    input [2:0]sel; // music select button (dip 3,4,5)
    input [7:0]key; // answer input butoon (push 1,2,3,4,5,6,7,8)
    input CLK, RESETN; // clock, reset button, (AB11, psuh #)
    reg [2:0]state_game; // states of game
    reg [2:0]state_lcd; // states of lcd

    input en; // comparator enable
    output q; // score output

    ////////////////////////// piezo //////////////////////////////
    output piezo;
    output [7:0] led; // led 1~8
    wire [3:0]notes,notes2; // music 1, 2
    reg s1 = 1'b0; 
    wire [3:0]music_input;
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
    lcd_menu U0 (RESETN,C_OUT,state_lcd,LCD_E,LCD_RS,LCD_RW,LCD_DATA);
    doremi U1(RESETN, CLK, music_input, piezo);
    rgb L1(RESETN, CLK, R_IN, G_IN, B_IN, R,G,B);
    counter1 U2(RESETN, CLK, C_OUT);
    counter2  U3(RESETN, C_OUT, C_OUT2);
    //counter_100bit count3(RESETN, C_OUT2, C_OUT3);
    led8 led8(CLK, music_input, led);
    music_1 music1(C_OUT2, notes, sel[2]); // if there is posedge sel[1], then notes initialized.
    
    comparator(en,led,key,q,clk); // score

	always @ (posedge CLK)
		begin
			if(q>=60)
				G_IN=2'b11;
			else if(q>=30)
				B_IN=2'b11;
			else if(q>=0)
				R_IN=2'b11;
			end

    assign music_input = s1 ? notes : 4'bZ;
    
   // always @(posedge CLK) begin
     //       case(state_game) 
       //         3'b000 : state_lcd <= 3'b000; /// initial screen
         //       3'b001 : state_lcd <= 3'b001; /// game start screen
           //     3'b010 : state_lcd = 3'b010;  /// score screen
             //   default : state_lcd = 3'b000; /// default is initial screen
            //endcase
        //end

    //always @(posedge CLK) begin
      //  case(state_game) 
        //    3'b000 : {R_IN,G_IN,B_IN} <= 6'b100000;  /// initial : RED
          //  3'b001 : {R_IN,G_IN,B_IN} <= 6'b001000;  /// game : GREEN
            //3'b010 : {R_IN,G_IN,B_IN} <= 6'b000010;  /// score : BLUE
            //default : {R_IN,G_IN,B_IN} <= 6'b100000; /// default : RED
        //endcase
    //end


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
                else if(sel) begin // if sel is 1
                    if(sel == 3'b100) begin // if sel == 3'b100
                      s1 = 1'b1; // select music1
                    end
                end
            end
        else if(state_game == 3'b010) // when score mode
            begin
                if(back) begin // if we push back button, we come back to initial screen.
                    state_game = 3'b000;
                    end
            end
    end

endmodule