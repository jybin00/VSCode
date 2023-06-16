module tpmem_st2_opt
#( parameter BW = 12 )
// 입력 데이터, enable 신호, 입력 클럭, 입력 리셋, 출력 데이ㅓㅌ, 출력 enable 신호
(  input        [16*BW-1:0]	i_data,
   input	   	            i_enable,
   input 	   	            i_clk,
   input	   	            i_Reset,
   output reg   [16*BW-1:0] o_data,
   output reg	            o_en
);

// counter <= 입출력할 때 사용하려고 선언함.
reg [5-1:0]         counter;
reg [154-1:0] a0;
reg [148-1:0] a1;
reg [142-1:0] a2;
reg [140-1:0] a3;
reg [137-1:0] a4;
reg [136-1:0] a5;
reg [129-1:0] a6;
reg [130-1:0] a7;
reg [125-1:0] a8;
reg [123-1:0] a9;
reg [121-1:0] a10;
reg [122-1:0] a11;
reg [119-1:0] a12;
reg [120-1:0] a13;
reg [116-1:0] a14;
reg [116-1:0] a15;
// Data 출력을 위한 reg
reg [16*BW-1:0]     data_out;

// col은 말 그대로 column. 
wire [16*BW-1:0]    col     [16-1:0];
wire [4-1:0]        index = counter[4-1:0] ;

// Data 츌력 위한 wire
wire [16*BW-1:0]    w_data;
wire	            w_en;

wire [12-1:0] Xk_0 = $signed(i_data[15*12 +: 12]);
wire [12-1:0] Xk_1 = $signed(i_data[14*12 +: 12]);
wire [12-1:0] Xk_2 = $signed(i_data[13*12 +: 12]);
wire [12-1:0] Xk_3 = $signed(i_data[12*12 +: 12]);
wire [12-1:0] Xk_4 = $signed(i_data[11*12 +: 12]);
wire [12-1:0] Xk_5 = $signed(i_data[10*12 +: 12]);
wire [12-1:0] Xk_6 = $signed(i_data[ 9*12 +: 12]);
wire [12-1:0] Xk_7 = $signed(i_data[ 8*12 +: 12]);
wire [12-1:0] Xk_8 = $signed(i_data[ 7*12 +: 12]);
wire [12-1:0] Xk_9 = $signed(i_data[ 6*12 +: 12]);
wire [12-1:0] Xk_10 = $signed(i_data[ 5*12 +: 12]);
wire [12-1:0] Xk_11 = $signed(i_data[ 4*12 +: 12]);
wire [12-1:0] Xk_12 = $signed(i_data[ 3*12 +: 12]);
wire [12-1:0] Xk_13 = $signed(i_data[ 2*12 +: 12]);
wire [12-1:0] Xk_14 = $signed(i_data[ 1*12 +: 12]);
wire [12-1:0] Xk_15 = $signed(i_data[ 0*12 +: 12]);


always@(posedge i_clk) begin
    if(~i_Reset) begin
        // counter, o_data, o_en 초기화
        counter <= 5'b0;
        o_data  <= {BW{16'b0}};
        o_en    <= 1'b0; 
    end
    else begin
        // o_data에는 w_data를, o_en에는 w_en을 대입
        o_data  <= w_data ;
        o_en    <= w_en ;
        if(i_enable) 
            // input이 enable일 때. counter를 1씩 증가시킴.
            counter     <= counter + 5'b1;
        else begin  
            // input이 enable이 아니면서, counter[4]가 1일 때.  
            // 카운터가 증가하면 index도 1씩 증가함.
            if(counter[4]==1'b1) counter <= counter + 5'b1;
    	    else counter <= counter ;
    	end
    end
end

always@(posedge i_clk) begin
    if(~i_Reset) begin
        // array 초기화
        a0  <= {154'b0};
        a1  <= {148'b0};
        a2  <= {142'b0};
        a3  <= {140'b0};
        a4  <= {137'b0};
        a5  <= {136'b0};
        a6  <= {129'b0};
        a7  <= {130'b0};
        a8  <= {125'b0};
        a9  <= {123'b0};
        a10 <= {121'b0};
        a11 <= {122'b0};
        a12 <= {119'b0};
        a13 <= {120'b0};
        a14 <= {116'b0};
        a15 <= {116'b0};
    end
    else begin
        if(i_enable) begin
            // reset 아니고 enable일 때, array에 i_data를 대입함.
            case(index)
                4'b0000: a0  <= {Xk_0,        Xk_1,         Xk_2,        Xk_3,         Xk_4[10-1:0], Xk_5[10-1:0],Xk_6[10-1:0],Xk_7[9-1:0], Xk_8[9-1:0], Xk_9[9-1:0], Xk_10[8-1:0], Xk_11[8-1:0], Xk_12[8-1:0], Xk_13[9-1:0], Xk_14[8-1:0], Xk_15[8-1:0]};
                4'b0001: a1  <= {Xk_0,        Xk_1,         Xk_2,        Xk_3[10-1:0], Xk_4[10-1:0], Xk_5[9-1:0], Xk_6[9-1:0], Xk_7[9-1:0], Xk_8[9-1:0], Xk_9[8-1:0], Xk_10[8-1:0], Xk_11[8-1:0], Xk_12[8-1:0], Xk_13[8-1:0], Xk_14[8-1:0], Xk_15[8-1:0]};
                4'b0010: a2  <= {Xk_0,        Xk_1[10-1:0], Xk_2[10-1:0],Xk_3[10-1:0], Xk_4[10-1:0], Xk_5[9-1:0], Xk_6[9-1:0], Xk_7[8-1:0], Xk_8[8-1:0], Xk_9[8-1:0], Xk_10[8-1:0], Xk_11[8-1:0], Xk_12[8-1:0], Xk_13[8-1:0], Xk_14[8-1:0], Xk_15[8-1:0]};
                4'b0011: a3  <= {Xk_0[10-1:0],Xk_1[10-1:0], Xk_2[10-1:0],Xk_3[10-1:0], Xk_4[10-1:0], Xk_5[9-1:0], Xk_6[9-1:0], Xk_7[8-1:0], Xk_8[8-1:0], Xk_9[8-1:0], Xk_10[8-1:0], Xk_11[8-1:0], Xk_12[8-1:0], Xk_13[8-1:0], Xk_14[8-1:0], Xk_15[8-1:0]};
                4'b0100: a4  <= {Xk_0[10-1:0],Xk_1[10-1:0], Xk_2[10-1:0],Xk_3[9-1:0],  Xk_4[9-1:0],  Xk_5[9-1:0], Xk_6[8-1:0], Xk_7[8-1:0], Xk_8[8-1:0], Xk_9[8-1:0], Xk_10[8-1:0], Xk_11[8-1:0], Xk_12[8-1:0], Xk_13[8-1:0], Xk_14[8-1:0], Xk_15[8-1:0]};
                4'b0101: a5  <= {Xk_0[10-1:0],Xk_1[10-1:0], Xk_2[9-1:0], Xk_3[9-1:0],  Xk_4[9-1:0],  Xk_5[9-1:0], Xk_6[8-1:0], Xk_7[8-1:0], Xk_8[8-1:0], Xk_9[8-1:0], Xk_10[8-1:0], Xk_11[8-1:0], Xk_12[8-1:0], Xk_13[8-1:0], Xk_14[8-1:0], Xk_15[8-1:0]};
                4'b0110: a6  <= {Xk_0[10-1:0],Xk_1[10-1:0], Xk_2[9-1:0], Xk_3[9-1:0],  Xk_4[9-1:0],  Xk_5[8-1:0], Xk_6[8-1:0], Xk_7[8-1:0], Xk_8[8-1:0], Xk_9[8-1:0], Xk_10[7-1:0], Xk_11[7-1:0], Xk_12[7-1:0], Xk_13[7-1:0], Xk_14[7-1:0], Xk_15[7-1:0]};
                4'b0111: a7  <= {Xk_0        ,Xk_1[10-1:0], Xk_2[9-1:0], Xk_3[9-1:0],  Xk_4[8-1:0],  Xk_5[8-1:0], Xk_6[8-1:0], Xk_7[8-1:0], Xk_8[8-1:0], Xk_9[8-1:0], Xk_10[7-1:0], Xk_11[7-1:0], Xk_12[7-1:0], Xk_13[7-1:0], Xk_14[7-1:0], Xk_15[7-1:0]};
                4'b1000: a8  <= {Xk_0[10-1:0], Xk_1[9-1:0], Xk_2[8-1:0], Xk_3[8-1:0],  Xk_4[8-1:0],  Xk_5[8-1:0], Xk_6[8-1:0], Xk_7[8-1:0], Xk_8[8-1:0], Xk_9[8-1:0], Xk_10[7-1:0], Xk_11[7-1:0], Xk_12[7-1:0], Xk_13[7-1:0], Xk_14[7-1:0], Xk_15[7-1:0]};
                4'b1001: a9  <= {Xk_0[9 -1:0], Xk_1[8-1:0], Xk_2[8-1:0], Xk_3[8-1:0],  Xk_4[8-1:0],  Xk_5[8-1:0], Xk_6[8-1:0], Xk_7[8-1:0], Xk_8[8-1:0], Xk_9[8-1:0], Xk_10[7-1:0], Xk_11[7-1:0], Xk_12[7-1:0], Xk_13[7-1:0], Xk_14[7-1:0], Xk_15[7-1:0]};
                4'b1010: a10 <= {Xk_0[9 -1:0], Xk_1[8-1:0], Xk_2[8-1:0], Xk_3[9-1:0],  Xk_4[8-1:0],  Xk_5[8-1:0], Xk_6[8-1:0], Xk_7[7-1:0], Xk_8[7-1:0], Xk_9[7-1:0], Xk_10[7-1:0], Xk_11[7-1:0], Xk_12[7-1:0], Xk_13[7-1:0], Xk_14[7-1:0], Xk_15[7-1:0]};
                4'b1011: a11 <= {Xk_0[9 -1:0], Xk_1[8-1:0], Xk_2[9-1:0], Xk_3[8-1:0],  Xk_4[9-1:0],  Xk_5[8-1:0], Xk_6[8-1:0], Xk_7[7-1:0], Xk_8[7-1:0], Xk_9[7-1:0], Xk_10[7-1:0], Xk_11[7-1:0], Xk_12[7-1:0], Xk_13[7-1:0], Xk_14[7-1:0], Xk_15[7-1:0]};
                4'b1100: a12 <= {Xk_0[8 -1:0], Xk_1[8-1:0], Xk_2[8-1:0], Xk_3[8-1:0],  Xk_4[8-1:0],  Xk_5[8-1:0], Xk_6[8-1:0], Xk_7[7-1:0], Xk_8[7-1:0], Xk_9[7-1:0], Xk_10[7-1:0], Xk_11[7-1:0], Xk_12[7-1:0], Xk_13[7-1:0], Xk_14[7-1:0], Xk_15[7-1:0]};
                4'b1101: a13 <= {Xk_0[8 -1:0], Xk_1[8-1:0], Xk_2[8-1:0], Xk_3[8-1:0],  Xk_4[8-1:0],  Xk_5[8-1:0], Xk_6[8-1:0], Xk_7[7-1:0], Xk_8[7-1:0], Xk_9[8-1:0], Xk_10[7-1:0], Xk_11[7-1:0], Xk_12[7-1:0], Xk_13[7-1:0], Xk_14[7-1:0], Xk_15[7-1:0]};
                4'b1110: a14 <= {Xk_0[8 -1:0], Xk_1[8-1:0], Xk_2[8-1:0], Xk_3[8-1:0],  Xk_4[7-1:0],  Xk_5[7-1:0], Xk_6[7-1:0], Xk_7[7-1:0], Xk_8[7-1:0], Xk_9[7-1:0], Xk_10[7-1:0], Xk_11[7-1:0], Xk_12[7-1:0], Xk_13[7-1:0], Xk_14[7-1:0], Xk_15[7-1:0]};
                4'b1111: a15 <= {Xk_0[8 -1:0], Xk_1[8-1:0], Xk_2[8-1:0], Xk_3[8-1:0],  Xk_4[7-1:0],  Xk_5[7-1:0], Xk_6[7-1:0], Xk_7[7-1:0], Xk_8[7-1:0], Xk_9[7-1:0], Xk_10[7-1:0], Xk_11[7-1:0], Xk_12[7-1:0], Xk_13[7-1:0], Xk_14[7-1:0], Xk_15[7-1:0]};
            endcase
            //array[index] <= i_data ;
        end
    end
end


assign col[ 0] = {{a0[154-1:142]},               {a1[148-1:136]},               {a2[142-1:130]}               , {{2{a3[140-1]}},a3[140-1:130]}, {{2{a4[137-1]}},a4[137-1:127]}, {{2{a5[136-1]}},a5[136-1:126]}, {{2{a6[129-1]}},a6[129-1:119]}, {a7[130-1:118]}               , {{2{a8[125-1]}},a8[125-1:115]}, {{3{a9[123-1]}},a9[123-1:114]},{{3{a10[121-1]}},a10[121-1:112]},{{3{a11[122-1]}},a11[122-1:113]}, {{4{a12[119-1]}},a12[119-1:111]}, {{4{a13[120-1]}},a13[120-1:112]}, {{4{a14[116-1]}},a14[116-1:108]}, {{4{a15[116-1]}},a15[116-1:108]}} ; 
assign col[ 1] = {{a0[142-1:130]},               {a1[136-1:124]},               {{2{a2[130-1]}},a2[130-1:120]}, {{2{a3[130-1]}},a3[130-1:120]}, {{2{a4[127-1]}},a4[127-1:117]}, {{2{a5[126-1]}},a5[126-1:116]}, {{2{a6[119-1]}},a6[119-1:109]}, {{2{a7[118-1]}},a7[118-1:108]}, {{3{a8[115-1]}},a8[115-1:106]}, {{4{a9[114-1]}},a9[114-1:106]},{{4{a10[112-1]}},a10[112-1:104]},{{4{a11[113-1]}},a11[113-1:105]}, {{4{a12[111-1]}},a12[111-1:103]}, {{4{a13[112-1]}},a13[112-1:104]}, {{4{a14[108-1]}},a14[108-1:100]}, {{4{a15[108-1]}},a15[108-1:100]}} ; 
assign col[ 2] = {{a0[130-1:118]},               {a1[124-1:112]},               {{2{a2[120-1]}},a2[120-1:110]}, {{2{a3[120-1]}},a3[120-1:110]}, {{2{a4[117-1]}},a4[117-1:107]}, {{3{a5[116-1]}},a5[116-1:107]}, {{3{a6[109-1]}},a6[109-1:100]}, {{3{a7[108-1]}},a7[108-1:099]}, {{4{a8[106-1]}},a8[106-1:098]}, {{4{a9[106-1]}},a9[106-1:098]},{{4{a10[104-1]}},a10[104-1:096]},{{3{a11[105-1]}},a11[105-1:096]}, {{4{a12[103-1]}},a12[103-1:095]}, {{4{a13[104-1]}},a13[104-1:096]}, {{4{a14[100-1]}},a14[100-1:092]}, {{4{a15[100-1]}},a15[100-1:092]}} ; 
assign col[ 3] = {{a0[118-1:106]},               {{2{a1[112-1]}},a1[112-1:102]},{{2{a2[110-1]}},a2[110-1:100]}, {{2{a3[110-1]}},a3[110-1:100]}, {{3{a4[107-1]}},a4[107-1:098]}, {{3{a5[107-1]}},a5[107-1:098]}, {{3{a6[100-1]}},a6[100-1:091]}, {{3{a7[099-1]}},a7[099-1:090]}, {{4{a8[098-1]}},a8[098-1:090]}, {{4{a9[098-1]}},a9[098-1:090]},{{3{a10[096-1]}},a10[096-1:087]},{{4{a11[096-1]}},a11[096-1:088]}, {{4{a12[095-1]}},a12[095-1:087]}, {{4{a13[096-1]}},a13[096-1:088]}, {{4{a14[092-1]}},a14[092-1:084]}, {{4{a15[092-1]}},a15[092-1:084]}} ; 
assign col[ 4] = {{{2{a0[106-1]}},a0[106-1: 96]},{{2{a1[102-1]}},a1[102-1:092]},{{2{a2[100-1]}},a2[100-1:090]}, {{2{a3[100-1]}},a3[100-1:090]}, {{3{a4[098-1]}},a4[098-1:089]}, {{3{a5[098-1]}},a5[098-1:089]}, {{3{a6[091-1]}},a6[091-1:082]}, {{4{a7[090-1]}},a7[090-1:082]}, {{4{a8[090-1]}},a8[090-1:082]}, {{4{a9[090-1]}},a9[090-1:082]},{{4{a10[087-1]}},a10[087-1:079]},{{3{a11[088-1]}},a11[088-1:079]}, {{4{a12[087-1]}},a12[087-1:079]}, {{4{a13[088-1]}},a13[088-1:080]}, {{5{a14[084-1]}},a14[084-1:077]}, {{5{a15[084-1]}},a15[084-1:077]}} ; 
assign col[ 5] = {{{2{a0[096-1]}},a0[096-1:086]},{{3{a1[092-1]}},a1[092-1:083]},{{3{a2[090-1]}},a2[090-1:081]}, {{3{a3[090-1]}},a3[090-1:081]}, {{3{a4[089-1]}},a4[089-1:080]}, {{3{a5[089-1]}},a5[089-1:080]}, {{4{a6[082-1]}},a6[082-1:074]}, {{4{a7[082-1]}},a7[082-1:074]}, {{4{a8[082-1]}},a8[082-1:074]}, {{4{a9[082-1]}},a9[082-1:074]},{{4{a10[079-1]}},a10[079-1:071]},{{4{a11[079-1]}},a11[079-1:071]}, {{4{a12[079-1]}},a12[079-1:071]}, {{4{a13[080-1]}},a13[080-1:072]}, {{5{a14[077-1]}},a14[077-1:070]}, {{5{a15[077-1]}},a15[077-1:070]}} ; 
assign col[ 6] = {{{2{a0[086-1]}},a0[086-1:076]},{{3{a1[083-1]}},a1[083-1:074]},{{3{a2[081-1]}},a2[081-1:072]}, {{3{a3[081-1]}},a3[081-1:072]}, {{4{a4[080-1]}},a4[080-1:072]}, {{4{a5[080-1]}},a5[080-1:072]}, {{4{a6[074-1]}},a6[074-1:066]}, {{4{a7[074-1]}},a7[074-1:066]}, {{4{a8[074-1]}},a8[074-1:066]}, {{4{a9[074-1]}},a9[074-1:066]},{{4{a10[071-1]}},a10[071-1:063]},{{4{a11[071-1]}},a11[071-1:063]}, {{4{a12[071-1]}},a12[071-1:063]}, {{4{a13[072-1]}},a13[072-1:064]}, {{5{a14[070-1]}},a14[070-1:063]}, {{5{a15[070-1]}},a15[070-1:063]}} ;
assign col[ 7] = {{{3{a0[076-1]}},a0[076-1:067]},{{3{a1[074-1]}},a1[074-1:065]},{{4{a2[072-1]}},a2[072-1:064]}, {{4{a3[072-1]}},a3[072-1:064]}, {{4{a4[072-1]}},a4[072-1:064]}, {{4{a5[072-1]}},a5[072-1:064]}, {{4{a6[066-1]}},a6[066-1:058]}, {{4{a7[066-1]}},a7[066-1:058]}, {{4{a8[066-1]}},a8[066-1:058]}, {{4{a9[066-1]}},a9[066-1:058]},{{5{a10[063-1]}},a10[063-1:056]},{{5{a11[063-1]}},a11[063-1:056]}, {{5{a12[063-1]}},a12[063-1:056]}, {{5{a13[064-1]}},a13[064-1:057]}, {{5{a14[063-1]}},a14[063-1:056]}, {{5{a15[063-1]}},a15[063-1:056]}} ;
assign col[ 8] = {{{3{a0[067-1]}},a0[067-1:058]},{{3{a1[065-1]}},a1[065-1:056]},{{4{a2[064-1]}},a2[064-1:056]}, {{4{a3[064-1]}},a3[064-1:056]}, {{4{a4[064-1]}},a4[064-1:056]}, {{4{a5[064-1]}},a5[064-1:056]}, {{4{a6[058-1]}},a6[058-1:050]}, {{4{a7[058-1]}},a7[058-1:050]}, {{4{a8[058-1]}},a8[058-1:050]}, {{4{a9[058-1]}},a9[058-1:050]},{{5{a10[056-1]}},a10[056-1:049]},{{5{a11[056-1]}},a11[056-1:049]}, {{5{a12[056-1]}},a12[056-1:049]}, {{5{a13[057-1]}},a13[057-1:050]}, {{5{a14[056-1]}},a14[056-1:049]}, {{5{a15[056-1]}},a15[056-1:049]}} ; 
assign col[ 9] = {{{3{a0[058-1]}},a0[058-1:049]},{{4{a1[056-1]}},a1[056-1:048]},{{4{a2[056-1]}},a2[056-1:048]}, {{4{a3[056-1]}},a3[056-1:048]}, {{4{a4[056-1]}},a4[056-1:048]}, {{4{a5[056-1]}},a5[056-1:048]}, {{4{a6[050-1]}},a6[050-1:042]}, {{4{a7[050-1]}},a7[050-1:042]}, {{4{a8[050-1]}},a8[050-1:042]}, {{4{a9[050-1]}},a9[050-1:042]},{{5{a10[049-1]}},a10[049-1:042]},{{5{a11[049-1]}},a11[049-1:042]}, {{5{a12[049-1]}},a12[049-1:042]}, {{4{a13[050-1]}},a13[050-1:042]}, {{5{a14[049-1]}},a14[049-1:042]}, {{5{a15[049-1]}},a15[049-1:042]}} ; 
assign col[10] = {{{4{a0[049-1]}},a0[049-1:041]},{{4{a1[048-1]}},a1[048-1:040]},{{4{a2[048-1]}},a2[048-1:040]}, {{4{a3[048-1]}},a3[048-1:040]}, {{4{a4[048-1]}},a4[048-1:040]}, {{4{a5[048-1]}},a5[048-1:040]}, {{5{a6[042-1]}},a6[042-1:035]}, {{5{a7[042-1]}},a7[042-1:035]}, {{5{a8[042-1]}},a8[042-1:035]}, {{5{a9[042-1]}},a9[042-1:035]},{{5{a10[042-1]}},a10[042-1:035]},{{5{a11[042-1]}},a11[042-1:035]}, {{5{a12[042-1]}},a12[042-1:035]}, {{5{a13[042-1]}},a13[042-1:035]}, {{5{a14[042-1]}},a14[042-1:035]}, {{5{a15[042-1]}},a15[042-1:035]}} ; 
assign col[11] = {{{4{a0[041-1]}},a0[041-1:033]},{{4{a1[040-1]}},a1[040-1:032]},{{4{a2[040-1]}},a2[040-1:032]}, {{4{a3[040-1]}},a3[040-1:032]}, {{4{a4[040-1]}},a4[040-1:032]}, {{4{a5[040-1]}},a5[040-1:032]}, {{5{a6[035-1]}},a6[035-1:028]}, {{5{a7[035-1]}},a7[035-1:028]}, {{5{a8[035-1]}},a8[035-1:028]}, {{5{a9[035-1]}},a9[035-1:028]},{{5{a10[035-1]}},a10[035-1:028]},{{5{a11[035-1]}},a11[035-1:028]}, {{5{a12[035-1]}},a12[035-1:028]}, {{5{a13[035-1]}},a13[035-1:028]}, {{5{a14[035-1]}},a14[035-1:028]}, {{5{a15[035-1]}},a15[035-1:028]}} ; 
assign col[12] = {{{4{a0[033-1]}},a0[033-1:025]},{{4{a1[032-1]}},a1[032-1:024]},{{4{a2[032-1]}},a2[032-1:024]}, {{4{a3[032-1]}},a3[032-1:024]}, {{4{a4[032-1]}},a4[032-1:024]}, {{4{a5[032-1]}},a5[032-1:024]}, {{5{a6[028-1]}},a6[028-1:021]}, {{5{a7[028-1]}},a7[028-1:021]}, {{5{a8[028-1]}},a8[028-1:021]}, {{5{a9[028-1]}},a9[028-1:021]},{{5{a10[028-1]}},a10[028-1:021]},{{5{a11[028-1]}},a11[028-1:021]}, {{5{a12[028-1]}},a12[028-1:021]}, {{5{a13[028-1]}},a13[028-1:021]}, {{5{a14[028-1]}},a14[028-1:021]}, {{5{a15[028-1]}},a15[028-1:021]}} ; 
assign col[13] = {{{3{a0[025-1]}},a0[025-1:016]},{{4{a1[024-1]}},a1[024-1:016]},{{4{a2[024-1]}},a2[024-1:016]}, {{4{a3[024-1]}},a3[024-1:016]}, {{4{a4[024-1]}},a4[024-1:016]}, {{4{a5[024-1]}},a5[024-1:016]}, {{5{a6[021-1]}},a6[021-1:014]}, {{5{a7[021-1]}},a7[021-1:014]}, {{5{a8[021-1]}},a8[021-1:014]}, {{5{a9[021-1]}},a9[021-1:014]},{{5{a10[021-1]}},a10[021-1:014]},{{5{a11[021-1]}},a11[021-1:014]}, {{5{a12[021-1]}},a12[021-1:014]}, {{5{a13[021-1]}},a13[021-1:014]}, {{5{a14[021-1]}},a14[021-1:014]}, {{5{a15[021-1]}},a15[021-1:014]}} ; 
assign col[14] = {{{4{a0[016-1]}},a0[016-1:008]},{{4{a1[016-1]}},a1[016-1:008]},{{4{a2[016-1]}},a2[016-1:008]}, {{4{a3[016-1]}},a3[016-1:008]}, {{4{a4[016-1]}},a4[016-1:008]}, {{4{a5[016-1]}},a5[016-1:008]}, {{5{a6[014-1]}},a6[014-1:007]}, {{5{a7[014-1]}},a7[014-1:007]}, {{5{a8[014-1]}},a8[014-1:007]}, {{5{a9[014-1]}},a9[014-1:007]},{{5{a10[014-1]}},a10[014-1:007]},{{5{a11[014-1]}},a11[014-1:007]}, {{5{a12[014-1]}},a12[014-1:007]}, {{5{a13[014-1]}},a13[014-1:007]}, {{5{a14[014-1]}},a14[014-1:007]}, {{5{a15[014-1]}},a15[014-1:007]}} ;
assign col[15] = {{{4{a0[008-1]}},a0[008-1:000]},{{4{a1[008-1]}},a1[008-1:000]},{{4{a2[008-1]}},a2[008-1:000]}, {{4{a3[008-1]}},a3[008-1:000]}, {{4{a4[008-1]}},a4[008-1:000]}, {{4{a5[008-1]}},a5[008-1:000]}, {{5{a6[007-1]}},a6[007-1:000]}, {{5{a7[007-1]}},a7[007-1:000]}, {{5{a8[007-1]}},a8[007-1:000]}, {{5{a9[007-1]}},a9[007-1:000]},{{5{a10[007-1]}},a10[007-1:000]},{{5{a11[007-1]}},a11[007-1:000]}, {{5{a12[007-1]}},a12[007-1:000]}, {{5{a13[007-1]}},a13[007-1:000]}, {{5{a14[007-1]}},a14[007-1:000]}, {{5{a15[007-1]}},a15[007-1:000]}} ;
always@(*) begin
    if(counter[4]==1'b1) data_out = col[index] ;
    else data_out = {BW{16'b0}}; 
end

assign w_en = counter[4] ;
assign w_data = data_out ; 

endmodule
