module BCD_to_seven(binary,Sseg);

input [3:0]binary;
output reg [7:0]Sseg;
reg dummy;

always@(binary)
case (binary)
    4'b0000: Sseg <= 7'b1111110;
    4'b0001: Sseg <= 7'b0110000;
    4'b0010: Sseg <= 7'b1101101;
    4'b0011: Sseg <= 7'b1111001;
    4'b0100: Sseg <= 7'b0110011;
    4'b0101: Sseg <= 7'b1011011;
    4'b0110: Sseg <= 7'b1011111;
    4'b0111: Sseg <= 7'b1110010;
    4'b1000: Sseg <= 7'b1111111;
    4'b1001: Sseg <= 7'b1111011;
    default: Sseg <= {dummy};
endcase

endmodule