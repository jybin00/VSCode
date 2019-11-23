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

    integer CNT;
    integer R_REG, G_REG, B_REG;

    reg [3:0] R,G,B;
    reg state1[2:0];

    always @(posedge RESETN) begin
        state1 = 3'b000;
        end

    always @(state1) begin

    


endmodule