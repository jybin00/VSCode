module top_FFT (out, in, clk, reset);
output signed	[24-1:0]	out;
input  signed   [24-1:0]	in;
input		clk, reset;

wire [4-1:0] counter_M; // 4bit counter
wire 	counter_8row_mux_sel_1_2, counter_8row_mux_sel_3, 
	counter_4row_mux_sel_1_2, counter_4row_mux_sel_7,
	counter_2row_mux_sel_1_2, counter_2row_mux_sel_11, counter_2row_mux_sel_12,
	counter_1row_mux_sel_1_2;

wire [3-1:0] counter_8row_mux_sel_4;
wire [2-1:0] counter_4row_mux_sel_8;

wire signed [24-1:0] but8_B,but8_A,but8_C1,but8_C2,twid8;
wire signed [24-1:0] but4_B,but4_A,but4_C1,but4_C2,twid4;
wire signed [24-1:0] but2_B,but2_A,but2_C1,but2_C2,twid2;
wire signed [24-1:0] but1_B,but1_A,but1_C1,but1_C2;

counter_master counter (counter_M, counter_8row_mux_sel_1_2,counter_8row_mux_sel_3, counter_8row_mux_sel_4, 
			counter_4row_mux_sel_1_2, counter_4row_mux_sel_7, counter_4row_mux_sel_8,
			counter_2row_mux_sel_1_2, counter_2row_mux_sel_11, counter_2row_mux_sel_12, 
			counter_1row_mux_sel_1_2 ,clk, reset);

d_ff_24b  			dff_8    (.q(but8_B),   .d(in),          .clk(clk), .reset(reset));
d_ff_8row 			dff_8row (.out(but8_A), .in(but8_C2), .clk(clk), .reset(reset));

d_ff_24b  			dff_4	 (.q(but4_B),	.d(twid8),	.clk(clk),	.reset(reset));
d_ff_4row 			dff_4row (.out(but4_A), .in(but4_C2), .clk(clk), .reset(reset));

d_ff_24b		 	dff_2	 (.q(but2_B),	.d(twid4),	.clk(clk),	.reset(reset));
d_ff_2row 			dff_2row (.out(but2_A), .in(but2_C2), .clk(clk), .reset(reset));

d_ff_24b 			dff_1	 (.q(but1_B),	.d(twid2),	.clk(clk),	.reset(reset));
d_ff_24b 			dff_1row (.q(but1_A),	.d(but1_C2),	.clk(clk),	.reset(reset));
d_ff_24b 			dff_out	 (.q(out),	.d(but1_C1),	.clk(clk),	.reset(reset));

Butterfly_add_mux2		but_8    (.C1(but8_C1),.C2(but8_C2),.A(but8_A),.B(but8_B),	.mux_sel_1_2(counter_8row_mux_sel_1_2));
Butterfly_add_mux2		but_4	 (.C1(but4_C1),.C2(but4_C2),.A(but4_A),.B(but4_B),	.mux_sel_1_2(counter_4row_mux_sel_1_2));
Butterfly_add_mux2		but_2	 (.C1(but2_C1),.C2(but2_C2),.A(but2_A),.B(but2_B),	.mux_sel_1_2(counter_2row_mux_sel_1_2));
Butterfly_add_mux2		but_1	 (.C1(but1_C1),.C2(but1_C2),.A(but1_A),.B(but1_B),	.mux_sel_1_2(counter_1row_mux_sel_1_2));

Twiddle_Factor_8row_add_mux	twi_8    (.out(twid8),.C(but8_C1),.mux_sel_3(counter_8row_mux_sel_3),   .mux_sel_4(counter_8row_mux_sel_4));
Twiddle_Factor_4row_add_mux	twi_4	 (.out(twid4),.C(but4_C1),.mux_sel_7(counter_4row_mux_sel_7),   .mux_sel_8(counter_4row_mux_sel_8));
Twiddle_Factor_2row_add_mux	twi_2	 (.out(twid2),.C(but2_C1),.mux_sel_11(counter_2row_mux_sel_11), .mux_sel_12(counter_2row_mux_sel_12));

endmodule

module counter_master (counter_M, counter_8row_mux_sel_1_2,counter_8row_mux_sel_3, counter_8row_mux_sel_4, 
			counter_4row_mux_sel_1_2, counter_4row_mux_sel_7, counter_4row_mux_sel_8,
			counter_2row_mux_sel_1_2, counter_2row_mux_sel_11, 
			counter_2row_mux_sel_12, counter_1row_mux_sel_1_2
			,clk, reset);

output [4-1:0] counter_M; // 4bit counter
output  counter_8row_mux_sel_1_2, counter_8row_mux_sel_3, 
	counter_4row_mux_sel_1_2, counter_4row_mux_sel_7,
	counter_2row_mux_sel_1_2, counter_2row_mux_sel_11, 
	counter_2row_mux_sel_12, counter_1row_mux_sel_1_2;

output [3-1:0] counter_8row_mux_sel_4;
output [2-1:0] counter_4row_mux_sel_8;

input   clk, reset;

reg [4-1:0] counter_M;
wire [4-1:0] counter_4row, counter_2row, counter_1row;


always @ (posedge clk)
begin
	if(~reset)
		counter_M <= 4'b1111;
	else		
		counter_M <= counter_M + 1;
end

assign counter_4row = counter_M - 1;
assign counter_2row = counter_M - 2;
assign counter_1row = counter_M - 3;

assign counter_8row_mux_sel_1_2 = counter_M[4-1];
assign counter_8row_mux_sel_3 = ~ counter_M[4-1];
assign counter_8row_mux_sel_4 =   counter_M[2:0];

assign counter_4row_mux_sel_1_2 = counter_4row[3-1];
assign counter_4row_mux_sel_7 = ~ counter_4row[3-1];
assign counter_4row_mux_sel_8 =   counter_4row[1:0];

assign counter_2row_mux_sel_1_2 = counter_2row[2-1];
assign counter_2row_mux_sel_11 = ~ counter_2row[2-1];
assign counter_2row_mux_sel_12 =   counter_2row[0];

assign counter_1row_mux_sel_1_2 =   counter_1row[0];
endmodule

module Butterfly_add_mux2 (C1, C2, A, B, mux_sel_1_2);
output [24-1 : 0] C1, C2;
input  [24-1 : 0] A,  B;
input  mux_sel_1_2;

wire   [24-1 : 0] be_C1, be_C2;	

Butterfly  one_butterfly (  .C1(be_C1), .C2(be_C2),  .A(A), .B(B) );
mux2to1	   one_but_mux_top   ( .out(C1), .i0(A), .i1(be_C1), .mux_sel(mux_sel_1_2) );
mux2to1	   one_but_mux_bot   ( .out(C2), .i0(B), .i1(be_C2), .mux_sel(mux_sel_1_2) );

endmodule

module Twiddle_Factor_8row_add_mux (out, C, mux_sel_3, mux_sel_4); 

output signed [24-1 : 0] out;
input  signed [24-1 : 0] C;
input  mux_sel_3;
input  [3-1 :0 ] mux_sel_4; // 3bit 0-7

wire signed [24-1 : 0] W0, W1, W2, W3, W4, W5, W6, W7;
wire [24-1 : 0] out_W, T;


assign	W0=24'b0100_0000_0000_0000_0000_0000;
assign	W1=24'b0011_1011_0010_1110_0111_1000;
assign	W2=24'b0010_1101_0100_1101_0010_1100;
assign	W3=24'b0001_1000_1000_1100_0100_1110;
assign	W4=24'b0000_0000_0000_1100_0000_0000;
assign	W5=24'b1110_0111_1000_1100_0100_1110;
assign	W6=24'b1101_0010_1100_1101_0010_1100;
assign	W7=24'b1100_0100_1110_1110_0111_1000;

mux8to1		one_twi_mux_bot ( .out(out_W), .i0(W0), .i1(W1), .i2(W2), .i3(W3), .i4(W4), .i5(W5), .i6(W6), .i7(W7), .mux_sel(mux_sel_4));
mux2to1		one_twi_mux_top ( .out(T), .i0(24'b0100_0000_0000_0000_0000_0000), .i1(out_W), .mux_sel(mux_sel_3));
Twiddle_Factor	one_twiddle     ( .out(out), .C(C), .T(T));

endmodule

module Twiddle_Factor_4row_add_mux (out, C, mux_sel_7, mux_sel_8); 

output signed [24-1 : 0] out;
input  signed [24-1 : 0] C;
input  mux_sel_7;
input  [2-1 :0 ] mux_sel_8; // 2bit 0-3

wire signed [24-1 : 0] W0, W1, W2, W3;
wire [24-1 : 0] out_W, T;

assign	W0=24'b0100_0000_0000_0000_0000_0000; //W0
assign	W1=24'b0010_1101_0100_1101_0010_1100; //W2
assign	W2=24'b0000_0000_0000_1100_0000_0000; //W4
assign	W3=24'b1101_0010_1100_1101_0010_1100; //W6

mux4to1		two_twi_mux_bot ( .out(out_W), .i0(W0), .i1(W1), .i2(W2), .i3(W3), .mux_sel(mux_sel_8));
mux2to1		two_twi_mux_top ( .out(T), .i0(24'b0100_0000_0000_0000_0000_0000), .i1(out_W), .mux_sel(mux_sel_7));
Twiddle_Factor	two_twiddle     ( .out(out), .C(C), .T(T));

endmodule

module Twiddle_Factor_2row_add_mux (out, C, mux_sel_11, mux_sel_12); 

output signed [24-1 : 0] out;
input  signed [24-1 : 0] C;
input  mux_sel_11;
input  mux_sel_12; // 1bit 0-1

wire signed [24-1 : 0] W0, W1;
wire [24-1 : 0] out_W, T;

assign	W0=24'b0100_0000_0000_0000_0000_0000; // W0
assign	W1=24'b0000_0000_0000_1100_0000_0000; // W4

mux2to1		three_twi_mux_bot ( .out(out_W), .i0(W0), .i1(W1), .mux_sel(mux_sel_12));
mux2to1		three_twi_mux_top ( .out(T), .i0(24'b0100_0000_0000_0000_0000_0000), .i1(out_W), .mux_sel(mux_sel_11));
Twiddle_Factor	three_twiddle     ( .out(out), .C(C), .T(T));

endmodule

module Twiddle_Factor	(out, C, T);

input  signed [23:0] C, T; // divide -cr,ci ,tr,ti
output signed [23:0] out;  //(12,10),(12,10)

wire signed   [11:0] Cr, Ci; //(12,10)
wire signed   [11:0] Tr, Ti; //(12,10)
wire signed   [24-1:0] CrTr, CiTi, CrTi, CiTr; // 12+11+1 = 24b
wire signed   [25-1:0] bef_Or, bef_Oi; // 25b
wire signed   [11:0]   Or, Oi;

assign	Cr = C[23:12]; 	assign	Ci = C[11:0];
assign	Tr = T[23:12]; 	assign	Ti = T[11:0];

assign CrTr = Cr * Tr;
assign CiTi = Ci * Ti;
assign CrTi = Cr * Ti;
assign CiTr = Ci * Tr;
 
assign bef_Or = CrTr - CiTi;
assign bef_Oi = CrTi + CiTr;

assign	Or = bef_Or[21:10];
assign	Oi = bef_Oi[21:10];
// Or = [24:0] -> Truncation -> [21:10]  (12.10)
// Oi = [24:0] -> Truncation -> [21:10]  (12.10)

assign	out = {Or,Oi};

endmodule

module Butterfly 	(C1, C2, A, B);

input  signed [23:0] A, B;
output signed [23:0] C1, C2;

wire signed [11:0] Ar, Ai , Br, Bi; // (12.11)
wire signed [12:0] bef_Clr, bef_C1i, bef_C2r, bef_C2i; // (13,11)
wire signed [11:0] C1r, C1i, C2r, C2i; // (12,10)

assign  Ar = A[23:12];         assign  Ai = A[11:0];
assign  Br = B[23:12];         assign  Bi = B[11:0];

assign  bef_Clr = Ar + Br ;    assign  bef_C1i = Ai + Bi ; 
assign  bef_C2r = Ar - Br ;    assign  bef_C2i = Ai - Bi ; 

assign	C1r = bef_Clr[12:1];   assign  C1i = bef_C1i[12:1];
assign	C2r = bef_C2r[12:1];   assign  C2i = bef_C2i[12:1];

assign	C1={C1r,C1i}; 	       assign  C2={C2r,C2i};

endmodule

module mux8to1( out, i0, i1, i2, i3, i4, i5, i6, i7, mux_sel); // mux_sel: 3bit (0-7)

output 	[24-1 : 0] out;
input 	[24-1 : 0] i0, i1, i2, i3, i4, i5, i6, i7;
input   [3-1  : 0] mux_sel;
reg 	[24-1 : 0] out;

always@(*)
begin
	case(mux_sel)
	3'b000: out=i0;
	3'b001: out=i1;
	3'b010: out=i2;
	3'b011: out=i3;
	3'b100: out=i4;
	3'b101: out=i5;
	3'b110: out=i6;
	3'b111: out=i7;
	endcase
	end
endmodule

module mux4to1( out, i0, i1, i2, i3, mux_sel); // mux_sel: 2bit (0-3)

output 	[24-1 : 0] out;
input 	[24-1 : 0] i0, i1, i2, i3;
input   [2-1  : 0] mux_sel;
reg 	[24-1 : 0] out;

always@(*)
begin
	case(mux_sel)
	2'b00: out=i0;
	2'b01: out=i1;
	2'b10: out=i2;
	2'b11: out=i3;
	endcase
	end
endmodule

module mux2to1( out, i0, i1, mux_sel); // mux_sel: 1bit (0-1)

output 	[24-1 : 0] out;
input 	[24-1 : 0] i0, i1;
input   mux_sel;
reg 	[24-1 : 0] out;

always@(*)
begin
	case(mux_sel)
	1'b0: out=i0;
	1'b1: out=i1;
	endcase
	end
endmodule

module d_ff_24b	(q, d, clk, reset);

output reg	[24-1:0] q;
input		[24-1:0] d;
input		clk, reset;


always @ (posedge clk)
begin
	if(~reset)	q <= 24'b0;
	else		q <= d;
end
endmodule

module d_ff_8row (out, in, clk, reset);

output 		[24-1:0] out;
input		[24-1:0] in;
input		clk, reset;

reg		[24-1:0] a, b, c, d, e, f, g, h;

always @ (posedge clk )
begin
	if(~reset)
	begin
		a <= 24'b0;
		b <= 24'b0;
		c <= 24'b0;
		d <= 24'b0;
		e <= 24'b0;
		f <= 24'b0;
		g <= 24'b0;
		h <= 24'b0;
		
	end
	else begin
		a <= in;
		b <= a;
		c <= b;
		d <= c;
		e <= d;
		f <= e;
		g <= f;
		h <= g;
	end
end
assign out = h;
endmodule

module d_ff_4row (out, in, clk, reset);

output 		[24-1:0] out;
input		[24-1:0] in;
input		clk, reset;

reg		[24-1:0] a, b, c, d;

always @ (posedge clk )
begin
	if(~reset)
	begin
		a <= 24'b0;
		b <= 24'b0;
		c <= 24'b0;
		d <= 24'b0;
		
	end
	else begin
		a <= in;
		b <= a;
		c <= b;
		d <= c;
	end
end
assign out = d;
endmodule

module d_ff_2row (out, in, clk, reset);

output 		[24-1:0] out;
input		[24-1:0] in;
input		clk, reset;

reg		[24-1:0] a, b;

always @ (posedge clk )
begin
	if(~reset)
	begin
		a <= 24'b0;
		b <= 24'b0;
		
	end
	else begin
		a <= in;
		b <= a;
	end
end
assign out = b;
endmodule
