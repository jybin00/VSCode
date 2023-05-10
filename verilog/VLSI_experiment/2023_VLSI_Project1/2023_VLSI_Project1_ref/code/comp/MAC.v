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
endmodule