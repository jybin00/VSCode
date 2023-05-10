`timescale 1ns / 10ps
// SRAM Module import
`include "rflp4096x8mx4.v"
`include "rflp4096x22mx4.v"

module Top_controller (done, start, clk, rstn);
    // Output -> done
    // Input -> start, clk, rstn
    output done;
    input start, clk, rstn;

    // If done is negedge, then function verification starts.
    reg done = 1'b0; 
    // Define each memory control signal
    reg nwrt_A, nwrt_B, nwrt_C, NCE_C, NCE;


    // 19bit Counter module import and define counter output wire
    wire [19-1:0] cnt_out;
    counter_19b memory_controller(cnt_out, clk, start);


    // Memory output, actually we don't need Out_C but we define it for compile.
    wire [8-1:0] Out_A, Out_B;
    wire [22-1:0] Out_C;

    // Memory address, Address_C should be delayed for 2clocks, so we define it as register.
    wire [12-1:0] Addr_A, Addr_B;
    reg  [12-1:0] address_C = 12'b0; 
    assign Addr_A = {cnt_out[18-1:12], cnt_out[6-1:0]};
    assign Addr_B = {cnt_out[6-1:0], cnt_out[12-1:6]};
    
    // matrix accumulation module import
    // .sth(inner module) -> ()outer wire or reg
    wire [22-1:0] mul_out;
    MAC Matrix_Accumulation(.matrix_mul_out(mul_out), .a(Out_A), .b(Out_B), .clk(clk), .temp_cnt(cnt_out[6-1:0]), .done(done), .start(start));
    reg  [19-1:0] control_cnt = 19'b0;

    // memory module import
    rflp4096x8mx4  MEM_A(Out_A, 8'b0, Addr_A[12-1:2], Addr_A[2-1:0], nwrt_A, NCE, clk);
    rflp4096x8mx4  MEM_B(Out_B, 8'b0, Addr_B[12-1:2], Addr_B[2-1:0], nwrt_B, NCE, clk);
    rflp4096x22mx4 MEM_C(Out_C, mul_out, address_C[12-1:2], address_C[2-1:0], nwrt_C, NCE_C, clk);
    
    // Memory control logic
    always @(posedge clk) begin
        // Control singal 
        control_cnt <= cnt_out;
        // Address C is needed to be pull one clk than control_cnt.
        address_C <= control_cnt[18-1:6];

        if(start == 1'b1) begin // start 1되면 바로 반응함.
            done <= 1'b0;
            NCE <= 1'b0; nwrt_A <= 1'b1; nwrt_B <= 1'b1; 
        end

        else if(done == 1'b1)begin
            NCE <= 1'b1;
            NCE_C <= 1'b1;
            done <= 1'b0;
            nwrt_C <= 1'b1;
        end

        else begin 

            if(control_cnt[19-1] == 1'b0)begin
                if(rstn == 1'b1)begin
                    // If control_cnt 6bits are 1111111, then
                    if(control_cnt[6-1:0] == 6'h3f) begin
                        //Write data at SRAM_C
                        NCE_C <= 1'b0;
                        nwrt_C <= 1'b0;
                    end
                    // If control_cnt is not 111111, then
                    else begin
                        // Turn off SRAM_C
                        NCE_C <= 1'b1;
                        nwrt_C <= 1'b1;
                    end
                end
                else begin end
            end
            // When control_cnt[19-1] is 1'b1 then,
            else if(control_cnt[19-1] == 1'b1)begin
                // SRAM_C stop and turn on done.
                NCE_C <= 1'b1;
                nwrt_C <= 1'b1;
                done <= 1'b1;
            end
            else begin end
        end
    end
endmodule

// 19bits counter for memory controll 
module counter_19b(cnt, clk, start);
    output [19-1:0]cnt;
    input clk;
    input start;
    reg [19-1:0]cnt = 19'b0;

    always@(posedge clk)
    begin
        // If cnt MSB is one, then stop counter
        if(cnt[19-1] == 1'b1) cnt <= 19'bx;
        else if(start == 1'b1) cnt <= 19'b0;
        else cnt <= cnt + 1;
    end
endmodule


module MAC (matrix_mul_out, a, b, clk, temp_cnt, done, start);
    output [22-1:0] matrix_mul_out;
    input [8-1:0]a, b;
    input clk, done, start;
    input [6-1:0] temp_cnt;

    wire [16-1:0]temp_mul;
    assign temp_mul = a * b;

    reg [22-1:0] matrix_mul_out;
    reg [6-1:0] cnt;
    reg flag;

    always@(posedge clk) begin
        // Module was started
        if(flag == 1'b1) begin
            // Delay cnt one clock
            cnt <= temp_cnt;
            // When a and b is non negative
            if(a >= 0 && b >=0) begin
                // New calculation start
                if(cnt == 6'b0) matrix_mul_out <= temp_mul + 1'b0;
                // Accumulate previous value
                else begin
                    matrix_mul_out <= matrix_mul_out + temp_mul;
                end
            end
            // When a and b is not define or high z
            else begin
                // If done is signal is high, then flag turn off
                if(done == 1'b1) flag <= 1'b0;
                matrix_mul_out <= 22'b0;
            end
        end
        // When module received start signal, then turn on flag.
        else if(start == 1'b1) flag <= 1'b1;
        // If flag = 0 and start = 0 (start or end)
        else matrix_mul_out <= 22'bx;
    end
    // always@(posedge done) flag <= 1'b0;
    // always@(posedge start) flag <= 1'b1; 
endmodule