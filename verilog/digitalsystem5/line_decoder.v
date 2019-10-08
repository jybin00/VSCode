module line_decoder(A,S);

input [3:0] A;
output reg[3:0] S;
reg dummy;

always@(A)
    case(A)
    4'b0000 : S <= 4'b0000;
    4'b0001 : S <= 4'b0001;
    4'b0010 : S <= 4'b0010;
    4'b0011 : S <= 4'b0011;
    4'b0100 : S <= 4'b0100;
    4'b0101 : S <= 4'b1000;
    4'b0110 : S <= 4'b1001;
    4'b0111 : S <= 4'b1010;
    4'b1000 : S <= 4'b1011;
    4'b1001 : S <= 4'b1100;
    default : S <= {dummy};
    endcase
endmodule