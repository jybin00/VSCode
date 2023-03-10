module decoder3_8(Data_in,Data_out);

input [2:0] Data_in;
output [7:0] Data_out;

assign Data_out[0]=(~Data_in[0]&~Data_in[1]&~Data_in[2]);
assign Data_out[1]=( Data_in[0]&~Data_in[1]&~Data_in[2]);
assign Data_out[2]=(~Data_in[0]& Data_in[1]&~Data_in[2]);
assign Data_out[3]=( Data_in[0]& Data_in[1]&~Data_in[2]);
assign Data_out[4]=(~Data_in[0]&~Data_in[1]& Data_in[2]);
assign Data_out[5]=( Data_in[0]&~Data_in[1]& Data_in[2]);
assign Data_out[6]=(~Data_in[0]& Data_in[1]& Data_in[2]);
assign Data_out[7]=( Data_in[0]& Data_in[1]& Data_in[2]);

endmodule