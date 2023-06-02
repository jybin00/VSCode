// Shift register with 4 stages
module FIFO4 (out, in, clk, rstn);
    output [24-1:0] out;
    input [24-1:0] in;
    reg [24-1:0] q0, q1, q2, q3;
    input clk, rstn;
    always@(posedge clk) begin
        if(~rstn) begin
            q0 <= 24'b0;
            q1 <= 24'b0;
            q2 <= 24'b0;
            q3 <= 24'b0;
        end
        else begin
            q0 <= in;
            q1 <= q0;
            q2 <= q1;
            q3 <= q2;
        end
    end
    assign out = q3;
endmodule