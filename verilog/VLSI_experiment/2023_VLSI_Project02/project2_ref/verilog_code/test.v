module tb;
    reg [3:0] in;
    wire [10:0] out;

    reg clk;
    initial #5 clk <= ~clk;
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb);
        in <= 4'b1; #10;
        in <= 4'b10; #10;
        in <= 4'b11; #10;
        in <= 4'b1001; #10;
        $finish;    
    end
    sign_extention sign_extention_0(out, in);


endmodule

module sign_extention(out, in);
    input [3:0] in;
    wire [3:0] test;

    output [10:0] out;

    assign out = {{7{in[3]}}, in};
    

endmodule