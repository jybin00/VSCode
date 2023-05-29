// ID : 2018170921 Department : Eletrical Engineering Name : Yubeen Jo.
// Building Matrix Multiplier

`timescale 1ns / 10ps
// Module import
`include "counter_19b.v"
`include "MAC.v"
`include "D_FF_22bit.v"
`include "D_FF_8bit.v"

module Top_controller (In_C, NCE_C, nwrt_C, address_C, done, In_A, In_B, start, clk, rstn);
    // Output -> In_C, NCE_C, nwrt_C, address_C, done
    // Input -> In_A, In_B, start, clk, rstn
    output [22-1:0]In_C; // SRAM_C로 들어가는 input data
    output [12-1:0] address_C;
    output NCE_C, nwrt_C;
    output done;
    input [8-1:0]In_A, In_B;
    input clk, rstn, start;

    // If done is negedge, then function verification starts.
    reg done = 1'b0; 
    // Define each memory control signal
    reg nwrt_A, nwrt_B, nwrt_C, NCE_C, NCE;


    // 19bit Counter module import and define counter output wire
    wire [19-1:0] cnt_out;
    counter_19b memory_controller(cnt_out, clk, start);


    // Memory output, actually we don't need Out_C but we define it for compile.
    wire [8-1:0] Out_A, Out_B;
    wire [22-1:0] In_C;

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

    // memory module
    D_FF_22bit MEM_C(In_C, mul_out, clk, rstn);
    D_FF_8bit MEM_A(Out_A, In_A, clk, rstn);
    D_FF_8bit MEM_B(Out_B, In_B, clk, rstn);
    
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