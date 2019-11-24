// 모드 선택, 재생, 정지, 입력, 저장, 채점, 채점 결과 출력
`include "doremi.v" // 피에조 모듈 사용
`include "rgb.v"    // full color led 사용
`include "lcd_menu.v" // Text lcd 사용
`include "ram.v"    // RAM 사용

module rythm(menu1, menu2, // 메뉴 버튼
             back, sel, key, CLK, piezo, // 취소, 노래 선택, 음계 입력, 클럭, 피에조 버튼
             RESETN,LCD_E,LCD_RS,LCD_RW,LCD_DATA, // Text LCD 버튼
             R,G,B); // LED 출력 버튼

    input menu1, menu2, back; // dip 1,2,6
    input [2:0]sel; // 노래 선택 버튼, 음계 입력 버튼
    input CLK, RESETN; // 클럭 버튼, reset 버튼, AB11, #
    reg [2:0]state_game; // 게임의 스테이트 
    reg [2:0]state_lcd; // lcd의 스테이트

    ////////////////////////// piezo //////////////////////////////
    input  [7:0] key;
    output piezo;
    ///////////////////////////////////////////////////////////////

    /////////////////////////// LCD ////////////////////////////////
    output LCD_E,LCD_RS,LCD_RW; // enable read mode, read write
    output [7:0]LCD_DATA; // 데이터 

    ///////////////////////////////////////////////////////////////

    ////////////////////////// LED ////////////////////////////////
    output [3:0] R,G,B;
    integer CNT;
    integer R_REG, G_REG, B_REG;

    reg [1:0] R_IN,G_IN,B_IN;
    ///////////////////////////////////////////////////////////////

    LCD lcd_menu (RESETN,CLK,state_lcd,LCD_E,LCD_RS,LCD_RW,LCD_DATA);
    doremi doremi  (RESETN, CLK, key, piezo);
    HB_FULL_LED led (RESETN, CLK, R_IN, G_IN, B_IN, R,G,B);

    always @(posedge RESETN) begin
        state_game = 3'b000;
        end

    always @(posedge CLK) begin
            case(state_game) 
            3'b000 : state_lcd = 3'b000;  /// 처음 화면
            3'b001 : state_lcd = 3'b001;  /// 게임 시작 화면
            3'b010 : state_lcd = 3'b010;  /// 스코어 화면
            default : state_lcd = 3'b000; /// 디폴트는 처음 화면
            endcase
        end

    always @(posedge CLK) begin
        if(state_game == 3'b000) 
            begin
                if(menu1) begin
                    state_game = 3'b001;
                    end
                else if(menu2) begin
                    state_game = 3'b010;
                    end
            end
        else if(state_game == 3'b001)
            begin
                if(back) begin
                    state_game = 3'b000;
                    end
            end
        else if(state_game == 3'b010)
            begin
                if(back) begin
                    state_game = 3'b000;
                    end
            end
    end

        
    


endmodule