// 8 to 1 MUX behavior

module MUX_8to1_behav (out, a[7:0], s[2:0]);

    output reg out;
    input [7:0]a;
    input [2:0]s;

    always@(a[7:0], s[2:0]) begin
        case(s[2:0])
            3'b000 : out = a[0];
            3'b001 : out = a[1];
            3'b010 : out = a[2];
            3'b011 : out = a[3];
            3'b100 : out = a[4];
            3'b101 : out = a[5];
            3'b110 : out = a[6];
            3'b111 : out = a[7];
            default: out = 3'b000;
        endcase

    end


endmodule

