module TextLCD(resetn,clk,LCD_E,LCD_RS,LCD_RW,LCD_DATA);

input resetn,clk; // 리셋과 클럭은 입력
output LCD_E,LCD_RS,LCD_RW; // enable read mode, read write
output [7:0]LCD_DATA; // 데이터 

wire LCD_E; // enable
reg LCD_RS,LCD_RW; // read mode, read write
reg[7:0] LCD_DATA; // data 
reg[2:0] state; // 상태

parameter delay=3'b000, function_set=3'b001,
entry_mode=3'b010,disp_onoff=3'b011,
line1=3'b100,line2=3'b101,
delay_t=3'b110,clear_disp=3'b111;

integer CNT; //카운터

always @(posedge resetn or posedge clk) // 리셋이 라이징이거나 클럭이 라이징일 때
begin
	if(resetn) state = delay; // 리셋이 1이면 딜레이
	else
		begin	
			case(state) // 스테이트에 따라서
				delay: 			if(CNT==70)state=function_set;
				function_set: 	if(CNT==30)state=disp_onoff;
				disp_onoff:   	if(CNT==30)state=entry_mode;
				entry_mode:		if(CNT==30)state=line1;
				line1:			if(CNT==20)state=line2;
				line2:			if(CNT==20)state=delay_t;
				delay_t:		if(CNT==400)state=clear_disp;
				clear_disp: 	if(CNT==200)state=line1;
				default:			state=delay;
			endcase
		end
end


always @(posedge resetn or posedge clk) // 리셋이 라이징이거나 클럭이 라이징일 때
begin
	if(resetn) CNT=0; // 리셋이 1이면 카운터 0으로
	else
		begin	
			case(state)
				delay: 			if(CNT>=70)CNT=0; // 70보다 크거나 같으면 0으로
									else CNT=CNT+1; // 아니면 증가
				function_set: 	if(CNT>=30)CNT=0;
									else CNT=CNT+1;
				disp_onoff:   	if(CNT>=30)CNT=0;
									else CNT=CNT+1;
				entry_mode:		if(CNT>=30)CNT=0;
									else CNT=CNT+1;
				line1:			if(CNT>=20)CNT=0;
									else CNT=CNT+1;
				line2:			if(CNT>=20)CNT=0;
									else CNT=CNT+1;
				delay_t:			if(CNT>=400)CNT=0;
									else CNT=CNT+1;
				clear_disp: 	if(CNT>=200)CNT=0;
									else CNT=CNT+1;
				default:			CNT=0;
			endcase
		end
end




always @(posedge resetn or posedge clk)
begin
	if(resetn) begin
		LCD_RS=1'b1; // data mode
		LCD_RW=1'b1; // write mode
		LCD_DATA=8'b00000000; // data에 00000000삽입
	end
	else
		begin	
			case(state)
				function_set: 	begin
										LCD_RS=1'b0;
										LCD_RW=1'b0;
										LCD_DATA=8'b00110x00;
									end
				disp_onoff:   	begin
										LCD_RS=1'b0;
										LCD_RW=1'b0;
										LCD_DATA=8'b00001111;
									end
				entry_mode:		begin
										LCD_RS=1'b0;
										LCD_RW=1'b0;
										LCD_DATA=8'b00000111;
									end
				line1:			begin
										LCD_RW=1'b0;
										case(CNT)
											0:begin
												LCD_RS=1'b1;
                                                LCD_DATA=8'b00000001;//address
											end
											1:begin
												LCD_RS=1'b1;LCD_DATA=8'b01000100;//d
											end
											2:begin
												LCD_RS=1'b1;LCD_DATA=8'b01101001;//i
											end
											3:begin
												LCD_RS=1'b1;LCD_DATA=8'b01100111;//g
											end
											4:begin
												LCD_RS=1'b1;LCD_DATA=8'b01101001;//i
											end
											5:begin
												LCD_RS=1'b1;LCD_DATA=8'b01110100;//t
											end
											6:begin
												LCD_RS=1'b1;LCD_DATA=8'b01100001;//a
											end
											7:begin
												LCD_RS=1'b1;LCD_DATA=8'b01101100;//l
											end
											8:begin
												LCD_RS=1'b1;LCD_DATA=8'b00000000;//
											end
											9:begin
												LCD_RS=1'b1;LCD_DATA=8'b01010011;//s
											end
											10:begin
												LCD_RS=1'b1;LCD_DATA=8'b01111001;//y
											end
											11:begin
												LCD_RS=1'b1;LCD_DATA=8'b01110011;//s
											end
											12:begin
												LCD_RS=1'b1;LCD_DATA=8'b01110100;//t
											end
											13:begin
												LCD_RS=1'b1;LCD_DATA=8'b01100101;//e
											end
											14:begin
												LCD_RS=1'b1;LCD_DATA=8'b01101101;//m
											end
											15:begin
												LCD_RS=1'b1;LCD_DATA=8'b00000000;//
											end
											16:begin
												LCD_RS=1'b1;LCD_DATA=8'b00000000;//
											end
											default:begin
												LCD_RS=1'b1;LCD_DATA=8'b00000000;//
											end
										endcase
									end
				line2:			begin
										LCD_RW=1'b0;
										case(CNT)
											0:begin
												LCD_RS=1'b0;LCD_DATA=8'b00100010;//address
											end
											1:begin
												LCD_RS=1'b1;LCD_DATA=8'b01001000;//h
											end
											2:begin
												LCD_RS=1'b1;LCD_DATA=8'b01100101;//e
											end
											3:begin
												LCD_RS=1'b1;LCD_DATA=8'b01101100;//l
											end
											4:begin
												LCD_RS=1'b1;LCD_DATA=8'b01101100;//l
											end
											5:begin
												LCD_RS=1'b1;LCD_DATA=8'b01101100;//o
											end
											6:begin
												LCD_RS=1'b1;LCD_DATA=8'b00000000;//
											end
											7:begin
												LCD_RS=1'b1;LCD_DATA=8'b01010111;//w
											end
											8:begin
												LCD_RS=1'b1;LCD_DATA=8'b01101111;//o
											end
											9:begin
												LCD_RS=1'b1;LCD_DATA=8'b01110010;//r
											end
											10:begin
												LCD_RS=1'b1;LCD_DATA=8'b01101100;//l
											end
											11:begin
												LCD_RS=1'b1;LCD_DATA=8'b01100100;//d
											end
											12:begin
												LCD_RS=1'b1;LCD_DATA=8'b00100001 ;//!
											end
											13:begin
												LCD_RS=1'b1;LCD_DATA=8'b00000000;// 
											end
											14:begin
												LCD_RS=1'b1;LCD_DATA=8'b00000000;// 
											end
											15:begin
												LCD_RS=1'b1;LCD_DATA=8'b00000000;// 
											end
											16:begin
												LCD_RS=1'b1;LCD_DATA=8'b00000000;// 
											end
											default:begin
												LCD_RS=1'b1;LCD_DATA=8'b00000000;//
											end
										endcase
									end
				delay_t:			begin
										LCD_RS=1'b0;
										LCD_RW=1'b0;
										LCD_DATA=8'b00000010;
									end
				clear_disp: 	begin
										LCD_RS=1'b0;
										LCD_RW=1'b0;
										LCD_DATA=8'b00000001;
									end
				default:			begin
										LCD_RS=1'b1;
										LCD_RW=1'b1;
										LCD_DATA=8'b00000000;
									end
			endcase
		end
end

assign LCD_E=clk;

endmodule



