`include "rflp4096x8mx4.v"
`include "rflp4096x22mx4.v"

// 64X64 MEM A에 있는 값과 64X64 MEM B에 있는 값을 불러와서 곱하고 다시 64X64 MEM C에 써넣는 회로 만들기
// MEM A에 있는 값은 주소 값을 1씩 증가시키면서 불러오고, MEM B에 있는 값은 주소값을 64씩 증가시키면서 읽어오기.
// 곱셈기는 누적 곱셈기여서 64번 곱하는 동안 값이 계속 누적됨.
// 근데 그걸 어떻게 만들지? ㅎㅎ

module Top_controller (done, start, clk, rstn);

    output done;
    input start, clk, rstn;
    reg flag;

    wire [18-1:0] cnt_out;
    counter_18b memory_controller(cnt_out, clk, rstn);
    wire [8-1:0] Out_A, Out_B;
    wire [22-1:0] Out_C;

    wire [12-1:0] Addr_A, Addr_B, Addr_C;
    assign Addr_A = {cnt_out[18-1:12], cnt_out[6-1:0]};
    assign Addr_B = {cnt_out[6-1:0], cnt_out[12-1:6]};
    assign Addr_C = cnt_out[18-1:6];

    rflp4096x8mx4  MEM_A(Out_A, 8'b0, Addr_A[12-1:2], Addr_A[2-1:0], NWRT, NCE, clk);


    rflp4096x8mx4  MEM_B(Out_B, 8'b0, Addr_B[12-1:2], Addr_B[2-1:0], NWRT, NCE, clk);


    rflp4096x22mx4 MEM_C(Out_C, 22'b0, Addr_C[12-1:2], Addr_C[2-1:0], NWRT, NCE, clk);

    always@(posedge clk)
    begin
        if(start == 1'b1) 




endmodule


// 18bits counter for memory controll 
module counter_18b(cnt, clk, rstn);
    output [18-1:0]cnt;
    input clk, rstn;
    reg [18-1:0]cnt;

    always@(posedge clk)
    begin
        if(rstn == 1'b0) cnt <= 18'b0;
        else cnt <= cnt + 1;
    end
endmodule