module D_FF(q, d, clk, reset);

output q;
input d, clk, reset;

reg q;

always @ (negedge clk)  // negative edge일 때 아래 실행
begin 
    if (reset) // rest이 1이면 q에 0을 넣는다.
        q <= 1'b0;
    else 
        q <= d;
end

endmodule