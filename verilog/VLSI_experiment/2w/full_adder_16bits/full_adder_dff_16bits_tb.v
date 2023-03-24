// full adder testbench
`include "full_adder_dff_16bits.v"
`timescale 1ns/1ns

module full_adder_dff_16bits_tb;

wire [17-1:0] sum;
reg [16-1:0] a, b;
reg [17-1:0] mat_sum;
reg clk;
reg reset;

reg [16-1:0] mat_a_input [0:99];
reg [16-1:0] mat_b_input [0:99];
reg [17-1:0] mat_sum_output [0:99];

full_adder_dff_16bits gate(sum, a, b, 1'b0, clk, reset);

integer i,j;
integer err;

initial
    begin
    clk = 1'b0;
    reset = 1'b1;
    #7 reset = 1'b0;
    end
initial
    for (j = 0; j < 200; j = j + 1)
    begin
        #5 clk = ~clk;
    end

initial begin
    $dumpfile("full_adder_dff_16bits_tb.vcd");
    $dumpvars(0, full_adder_dff_16bits_tb);


    $readmemh("Practice_02_ref/a_input.txt", mat_a_input);
    $readmemh("Practice_02_ref/b_input.txt", mat_b_input);
    $readmemh("Practice_02_ref/sum_output.txt", mat_sum_output);

    i = 0;
    err = 0;
    #(10);

    for (i = 0; i < 100; i = i + 1)
        begin
            a = mat_a_input[i];
            b = mat_b_input[i];
            mat_sum = mat_sum_output[i-1];
            #(2);
            if(sum != mat_sum)
                err = err + 1;
            #(8);
        end
    #(20)
    $finish;
end

endmodule