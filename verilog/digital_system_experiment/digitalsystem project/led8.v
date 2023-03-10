module led8 (clk, key, led);

input [3:0]key;

input clk;
output [7:0]led;
reg [7:0]q;
assign led = q;

always@(posedge clk) begin
case (key)
4'd00 : q = 8'b00000001;
4'd01 : q = 8'b00000010;
4'd02 : q = 8'b00000100;
4'd03 : q = 8'b00001000;
4'd04 : q = 8'b00010000;
4'd05 : q = 8'b00100000;
4'd06 : q = 8'b01000000;
4'd07 : q = 8'b10000000;
4'd08 : q = 8'b00000001;
4'd09 : q = 8'b00000010;
4'd10 : q = 8'b00000100;
4'd11 : q = 8'b00001000;
4'd12 : q = 8'b00010000;
4'd13 : q = 8'b00100000;
4'd14 : q = 8'b00000000;
endcase
end
endmodule