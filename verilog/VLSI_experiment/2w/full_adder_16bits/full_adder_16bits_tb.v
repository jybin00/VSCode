// full adder testbench
`include "full_adder_16bits.v"

module full_adder_16bits_tb;

wire [17-1:0] sum;
reg [16-1:0] a, b;
reg [17-1:0] mat_sum;

reg [16-1:0] mat_a_input [0:99];
reg [16-1:0] mat_b_input [0:99];
reg [17-1:0] mat_sum_output [0:99];

full_adder_16bits gate(sum, a, b, 1'b0);

integer i;
integer err;

initial begin
    $dumpfile("full_adder_16bits_tb.vcd");
    $dumpvars(0, full_adder_16bits_tb);
    $readmemh("Practice_02_ref/a_input.txt", mat_a_input);
    $readmemh("Practice_02_ref/b_input.txt", mat_b_input);
    $readmemh("Practice_02_ref/sum_output.txt", mat_sum_output);

    i = 0;
    err = 0;
    #(1);

    for (i = 0; i < 100; i = i + 1)
        begin
            a = mat_a_input[i];
            b = mat_b_input[i];
            mat_sum = mat_sum_output[i];
            #(1)
            if(sum != mat_sum)
                err = err + 1;
            #(10);
        end
    $finish;
end

endmodule