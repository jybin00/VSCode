// 문제점 : 클락이 동기화가 되어 있지 않아서 모든 플립플랍의 결과가 밀려서 출력되는 경우가 있다. 항상 동시에 변화하지 않을 수도 있다. 
// 동기화된 클락을 사용하지 않아서 발생하는 문제.

`include "T_FF.v"

module ripple_carry_counter_5bits (q, clk, reset);

output [4:0] q;
input clk, reset;
T_FF tff0 (q[0], clk, reset);
T_FF tff1 (q[1], q[0], reset);
T_FF tff2 (q[2], q[1], reset);
T_FF tff3 (q[3], q[2], reset);
T_FF tff4 (q[4], q[3], reset);

endmodule