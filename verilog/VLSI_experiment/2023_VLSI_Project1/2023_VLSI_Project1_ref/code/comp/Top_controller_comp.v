
// 64X64 MEM A에 있는 값과 64X64 MEM B에 있는 값을 불러와서 곱하고 다시 64X64 MEM C에 써넣는 회로 만들기
// MEM A에 있는 값은 주소 값을 1씩 증가시키면서 불러오고, MEM B에 있는 값은 주소값을 64씩 증가시키면서 읽어오기.
// 곱셈기는 누적 곱셈기여서 64번 곱하는 동안 값이 계속 누적됨.
// 근데 그걸 어떻게 만들지? ㅎㅎ
`include "counter_18b.v"
`include "MAC.v"
`include "D_FF_22bit.v"
`include "D_FF_8bit.v"

module Top_controller (In_C, NCE_C, nwrt_C, address_C, In_A, In_B, done, start, clk, rstn);

    output [22-1:0]In_C; // SRAM_C로 들어가는 input data
    output [12-1:0] address_C;
    output NCE_C, nwrt_C;
    output done;
    input [8-1:0]In_A, In_B;
    input clk, rstn, start;
    // memory control signal
    reg done, flag, nwrt_A, nwrt_B, nwrt_C, NCE_C, NCE;
    wire [22-1:0]mul_out;

    // counter output
    wire [18-1:0] cnt_out;
    counter_18b memory_controller(cnt_out, clk, flag, start);

    // memory output;
    wire [8-1:0] Out_A, Out_B;

    // memory address
    wire [12-1:0] Addr_A, Addr_B;
    assign Addr_A = {cnt_out[18-1:12], cnt_out[6-1:0]};
    assign Addr_B = {cnt_out[6-1:0], cnt_out[12-1:6]};

    // memory module
    D_FF_22bit MEM_C(In_C, mul_out, clk, rstn);
    D_FF_8bit MEM_A(Out_A, In_A, clk, rstn);
    D_FF_8bit MEM_B(Out_B, In_B, clk, rstn);
    
    // matrix accumulation
    MAC Matrix_Accumulation(mul_out, Out_A, Out_B, clk, cnt_out[6-1:0], done, start);
    reg [18-1:0] control_cnt;
    reg [12-1:0] address_C;

    always @(posedge clk) begin
        control_cnt <= cnt_out;
        // Address C is needed to be pull one clk.
        address_C <= control_cnt[18-1:6];
        // Make done flag on if cnt is over
        if (done == 1'b1) begin
            NCE <= 1'b1;
            NCE_C <= 1'b1;
            done <= 1'b0;
        end
        else if(start == 1'b1) begin
            flag <= 1'b1;
            done <= 1'b0; 
            end
        else if(flag == 1'b1 && control_cnt == 18'h3ffff) flag <= 1'b0;
        else if(flag == 1'b0 && control_cnt == 18'b0) done <= 1'b1;

        // flag on and reset off
        else if(flag == 1'b1 && rstn == 1'b1)begin
            // memory A, B start
            NCE <= 1'b0;
            nwrt_A <= 1'b1; nwrt_B <= 1'b1; 
            if(control_cnt[6-1:0] == 6'b111111) begin
                NCE_C <= 1'b0;
                nwrt_C <= 1'b0;
            end
            else begin
                NCE_C <= 1'b1;
                nwrt_C <= 1'b1;
            end
        end
        else begin end; 
    end

endmodule







