// stimulus에 들어가는 모듈
`include "rflp16384x128mx16.v"
`include "rfsp16384x192mx16.v"
`include "2D_DCT.v"

module top_memory_test(clk, reset)
    input clk, reset;
    
    rflp16384x128mx16 MEM_IN();
    rflp16384x192mx16 MEM_OUT();

endmodule