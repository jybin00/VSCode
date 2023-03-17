`include "MUX_8to1_gate.v"
`include "MUX_8to1_behav.v"
`timescale 1ns/10ps

module MUX_tb;
    
    reg [7:0]in;
    reg [2:0]s;
    wire gate_out, behav_out;
    integer i = 0;

    MUX_8to1_gate mux_gate (gate_out, in, s[2:0]);
    MUX_8to1_behav mux_behav(behav_out, in, s[2:0]);

    initial begin
        $dumpfile("MUX_tb.vcd");
        $dumpvars(0,MUX_tb);
        in = 8'b10101010;
        s = 3'b000;
        #10;
        for(i = 0; i<7; i++) begin
            s = s + 3'b001;
            #10;
        end

        for(i = 8; i>1; i--) begin
            s = s - 3'b001;
            #10;
        end

        $finish;
        
    end
    
endmodule