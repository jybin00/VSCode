`include "rflp4096x8mx4.v"
`include "rflp4096x22mx4.v"

// 64X64 MEM A에 있는 값과 64X64 MEM B에 있는 값을 불러와서 곱하고 다시 64X64 MEM C에 써넣는 회로 만들기
// MEM A에 있는 값은 주소 값을 1씩 증가시키면서 불러오고, MEM B에 있는 값은 주소값을 64씩 증가시키면서 읽어오기.
// 곱셈기는 누적 곱셈기여서 64번 곱하는 동안 값이 계속 누적됨.
// 근데 그걸 어떻게 만들지? ㅎㅎ

module Top_controller (done, start, clk, rstn);

    output done;
    input start, clk, rstn;

    rflp4096x8mx4 MEM_A(DO, DIN, RA, CA, NWRT, NCE, CLK);
    rflp4096x8mx4 MEM_B(DO, DIN, RA, CA, NWRT, NCE, CLK);
    rflp4096x22mx4 MEM_C(DO, DIN, RA, CA, NWRT, NCE, CLK);


endmodule

