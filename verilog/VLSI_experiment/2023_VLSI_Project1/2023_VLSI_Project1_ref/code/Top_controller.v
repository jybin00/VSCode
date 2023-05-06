`include "rflp4096x8mx4.v"
`include "rflp4096x22mx4.v"

// 64X64 MEM A에 있는 값과 64X64 MEM B에 있는 값을 불러와서 곱하고 다시 64X64 MEM C에 써넣는 회로 만들기
// MEM A에 있는 값은 주소 값을 1씩 증가시키면서 불러오고, MEM B에 있는 값은 주소값을 64씩 증가시키면서 읽어오기.
// 곱셈기는 누적 곱셈기여서 64번 곱하는 동안 값이 계속 누적됨.
// 근데 그걸 어떻게 만들지? ㅎㅎ

module Top_controller (done, start, clk, rstn);

    output done;
    input start, clk, rstn;
    // memory control signal
    reg done, flag, nwrt_A, nwrt_B, nwrt_C, NCE_C, NCE;
    wire [22-1:0]mul_out;

    // counter output
    wire [18-1:0] cnt_out;
    counter_18b memory_controller(cnt_out, clk, flag, start);

    // memory output;
    wire [8-1:0] Out_A, Out_B;
    wire [22-1:0] Out_C;

    // memory address
    wire [12-1:0] Addr_A, Addr_B, Addr_C;
    assign Addr_A = {cnt_out[18-1:12], cnt_out[6-1:0]};
    assign Addr_B = {cnt_out[6-1:0], cnt_out[12-1:6]};
    assign Addr_C = address_C[18-1:6];

    // memory module
    rflp4096x8mx4  MEM_A(Out_A, 8'b0, Addr_A[12-1:2], Addr_A[2-1:0], nwrt_A, NCE, clk);
    rflp4096x8mx4  MEM_B(Out_B, 8'b0, Addr_B[12-1:2], Addr_B[2-1:0], nwrt_B, NCE, clk);
    rflp4096x22mx4 MEM_C(Out_C, mul_out, Addr_C[12-1:2], Addr_C[2-1:0], nwrt_C, NCE, clk);
    
    // matrix accumulation
    MAC Matrix_Accumulation(mul_out, Out_A, Out_B, clk, cnt_out[6-1:0]);
    reg [18-1:0] control_cnt;
    reg [18-1:0] address_C;

    always @(posedge clk) begin
        control_cnt <= cnt_out;
        // Address C is needed to be pull one clk.
        address_C <= control_cnt;
        // Make done flag on if cnt is over
        if (done == 1'b1) begin
            NCE <= 1'b1;
            NCE_C <= 1'b1;
            done <= 1'b0;
        end
        if(flag == 1'b1 && control_cnt == 18'h3ffff) begin 
            done <= 1'b1;
            flag <= 1'b0; end
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

    always @(posedge start)
    begin
        flag <= 1'b1;
        done <= 1'b0;
    end

endmodule


// 18bits counter for memory controll 
module counter_18b(cnt, clk, rstn, start);
    output [18-1:0]cnt;
    input clk, rstn;
    input start;
    reg [18-1:0]cnt;

    always@(posedge clk)
    begin
        if(rstn == 1'b0) cnt <= 18'b0;
        else if(start == 1'b1) cnt <= 18'b0;
        else cnt <= cnt + 1;
    end
endmodule

module MAC (matrix_mul_out, a, b, clk, q);
    output [22-1:0] matrix_mul_out;
    input [8-1:0]a, b;
    input clk;
    input [6-1:0] q;

    wire [16-1:0]temp_mul;
    assign temp_mul = a * b;

    reg [22-1:0] matrix_mul_out;
    reg [6-1:0] cnt;

    always@(posedge clk) begin
        cnt <= q;
        if(a >= 0 && b >=0) begin
            if(cnt == 6'b0) matrix_mul_out <= temp_mul + 1'b0;
            else begin
                matrix_mul_out <= matrix_mul_out + temp_mul;
            end
        end
        else begin
            matrix_mul_out <= 22'b0;
        end
    end
endmodule