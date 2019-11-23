// 모드 선택, 재생, 정지, 입력, 저장, 채점, 채점 결과 출력

module rythm(menu1, menu2, // 메뉴 버튼
             back, sel, doremi, clk, piezo, // 취소, 노래 선택, 음계 입력, 클럭, 피에조 버튼
             resetn,LCD_E,LCD_RS,LCD_RW,LCD_DATA, // Text LCD 버튼
             R,G,B); // LED 출력 버튼

input menu1, menu2, back; // dip 1,2,6
input [2:0]sel, [7:0]doremi; // 노래 선택 버튼, 음계 입력 버튼
input clk; // 클럭 버튼
output 