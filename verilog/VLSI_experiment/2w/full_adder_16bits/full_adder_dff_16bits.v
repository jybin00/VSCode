// full adder 1bit 이어서 16bits adder 만들기
`include "full_adder_16bits.v"

module full_adder_dff_16bits(sum[16:0], a[15:0], b[15:0], c_in, clk, reset);

    output  [16:0]sum;
    input   [15:0]a, b;
    input   c_in;
    input   clk, reset;
    reg [16-1:0] a_q, b_q;   // input flip flop
    reg [17-1:0] sum;        // output flip flop
    reg c_in_ff;

    wire [14:0]c;  // carry output
    wire [17-1:0] sum_d;

    full_adder_16bits fa16 (sum_d, a_q, b_q, c_in_ff );

    // full_adder_1bit fa0  (sum_d[0],  c[0],    a_q[0],  b_q[0],  c_in_ff);
    // full_adder_1bit fa1  (sum_d[1],  c[1],    a_q[1],  b_q[1],  c[0]);
    // full_adder_1bit fa2  (sum_d[2],  c[2],    a_q[2],  b_q[2],  c[1]);
    // full_adder_1bit fa3  (sum_d[3],  c[3],    a_q[3],  b_q[3],  c[2]);
    // full_adder_1bit fa4  (sum_d[4],  c[4],    a_q[4],  b_q[4],  c[3]);
    // full_adder_1bit fa5  (sum_d[5],  c[5],    a_q[5],  b_q[5],  c[4]);
    // full_adder_1bit fa6  (sum_d[6],  c[6],    a_q[6],  b_q[6],  c[5]);
    // full_adder_1bit fa7  (sum_d[7],  c[7],    a_q[7],  b_q[7],  c[6]);
    // full_adder_1bit fa8  (sum_d[8],  c[8],    a_q[8],  b_q[8],  c[7]);
    // full_adder_1bit fa9  (sum_d[9],  c[9],    a_q[9],  b_q[9],  c[8]);
    // full_adder_1bit fa10 (sum_d[10], c[10],   a_q[10], b_q[10], c[9]);
    // full_adder_1bit fa11 (sum_d[11], c[11],   a_q[11], b_q[11], c[10]);
    // full_adder_1bit fa12 (sum_d[12], c[12],   a_q[12], b_q[12], c[11]);
    // full_adder_1bit fa13 (sum_d[13], c[13],   a_q[13], b_q[13], c[12]);
    // full_adder_1bit fa14 (sum_d[14], c[14],   a_q[14], b_q[14], c[13]);
    // full_adder_1bit fa15 (sum_d[15], sum_d[16], a_q[15], b_q[15], c[14]);

always @ (negedge clk) 
begin
if(reset) begin
    a_q <= 16'h0000;
    b_q <= 16'h0000;
    sum <= 17'b0; 
    c_in_ff <= 1'b0; end
else begin
    c_in_ff <= c_in;
    a_q <= a;
    b_q <= b;
    sum <= sum_d; end
end

endmodule