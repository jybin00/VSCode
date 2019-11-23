// 모드 선택, 재생, 정지, 입력, 저장, 채점, 채점 결과 출력
`include "doremi.v" // 피에조 모듈 사용
`include "rgb.v"    // full color led 사용

module rythm(menu1, menu2, // 메뉴 버튼
             back, sel, doremi, CLK, piezo, // 취소, 노래 선택, 음계 입력, 클럭, 피에조 버튼
             RESETN,LCD_E,LCD_RS,LCD_RW,LCD_DATA, // Text LCD 버튼
             R,G,B); // LED 출력 버튼

    input menu1, menu2, back; // dip 1,2,6
    input [2:0]sel, [7:0]doremi; // 노래 선택 버튼, 음계 입력 버튼
    input CLK, RESETN; // 클럭 버튼, reset 버튼, AB11, #

    output [3:0] R,G,B;

    ///////////////// LCD ////////////////////////////////////
    output LCD_E,LCD_RS,LCD_RW; // enable read mode, read write
    output [7:0]LCD_DATA; // 데이터 

    wire LCD_E; // enable
    reg LCD_RS,LCD_RW; // read mode, read write
    reg[7:0] LCD_DATA; // data 
    reg[2:0] state; // 상태
    ////////////////////////////////////////////////////////

    integer CNT;
    integer R_REG, G_REG, B_REG;

    reg [3:0] R,G,B;
    reg state_game[2:0]; // 게임의 스테이트 
    reg state_lcd[2:0]; // lcde의 스테이트

    LCD lcd_menu (RESETN,CLK,state_lcd,LCD_E,LCD_RS,LCD_RW,LCD_DATA);

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

    


endmodule