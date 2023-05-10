module MAC (matrix_mul_out, a, b, clk, q, done, start);
    output [22-1:0] matrix_mul_out;
    input [8-1:0]a, b;
    input clk, done, start;
    input [6-1:0] q;

    wire [16-1:0]temp_mul;
    assign temp_mul = a * b;

    reg [22-1:0] matrix_mul_out;
    reg [6-1:0] cnt;
    reg flag;

    always@(posedge clk) begin
        if(flag == 1'b1) begin
            cnt <= q;
            if(a >= 0 && b >=0) begin
                if(cnt == 6'b0) matrix_mul_out <= temp_mul + 1'b0;
                else begin
                    matrix_mul_out <= matrix_mul_out + temp_mul;
                end
            end
            else begin
                matrix_mul_out <= 22'bx;
            end
        end
        else if(start == 1'b1) flag <= 1'b1;
        else if(done == 1'b1) flag <= 1'b0;
        else matrix_mul_out <= 22'bx;
    end

endmodule