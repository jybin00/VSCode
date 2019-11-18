`include "sr.v"
module sr_tb;

reg S,R;
wire Q,nQ;

sr_latch sr1 (S,R,Q,nQ);

initial begin
    $dumpfile("sr_tb.vcd");
    $dumpvars(0,sr_tb);
        S<= 0; R <= 0;
    #20;
        S<= 0; R <= 1;
    #20;
        S<= 1; R <= 0;
    #20;
        S<= 1; R <= 1;
    #20;
    $finish;
end 

endmodule

