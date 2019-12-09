module music2 (clk, notes, sel, em);

input clk,sel;
output [3:0] notes;
reg [3:0] note; 
output reg em; // end music
integer freq = 0;
integer a,b;
assign notes = note;

always@(posedge clk) begin
    if(sel == 1'b1) begin
      freq = 1'b0;
      em = 1'b0;
      end
    else if(freq >= 7'd64) begin
        freq = 0;
        em = 1'b1;
        end
    else begin
        case(freq)
            7'd001   : note =   4'd11;
            7'd002   : note =   4'd11;
            7'd003   : note =   4'd11;
            7'd004   : note =   4'd11;
            7'd005   : note =   4'd10;
            7'd006   : note =   4'd09;
            7'd007   : note =   4'd10;
            7'd008   : note =   4'd11;
            7'd009   : note =   4'd10;
            7'd010   : note =   4'd10;
            7'd011   : note =   4'd10;
            7'd012   : note =   4'd10;
            7'd013   : note =   4'd06;
            7'd014   : note =   4'd06;
            7'd015   : note =   4'd06;
            7'd016   : note =   4'd06;
            7'd017   : note =   4'd09;
            7'd018   : note =   4'd09;
            7'd019   : note =   4'd09;
            7'd020   : note =   4'd09;
            7'd021   : note =   4'd08;
            7'd022   : note =   4'd07;
            7'd023   : note =   4'd08;
            7'd024   : note =   4'd09;
            7'd025   : note =   4'd08;
            7'd026   : note =   4'd08;
            7'd027   : note =   4'd08;
            7'd028   : note =   4'd08;
            7'd029   : note =   4'd04;
            7'd030   : note =   4'd04;
            7'd031   : note =   4'd04;
            7'd032   : note =   4'd04;
            7'd033   : note =   4'd07;
            7'd034   : note =   4'd07;
            7'd035   : note =   4'd07;
            7'd036   : note =   4'd07;
            7'd037   : note =   4'd06;
            7'd038   : note =   4'd05;
            7'd039   : note =   4'd06;
            7'd040   : note =   4'd07;
            7'd041   : note =   4'd06;
            7'd042   : note =   4'd06;
            7'd043   : note =   4'd06;
            7'd044   : note =   4'd06;
            7'd045   : note =   4'd09;
            7'd046   : note =   4'd09;
            7'd047   : note =   4'd09;
            7'd048   : note =   4'd09;
            7'd049   : note =   4'd11;
            7'd050   : note =   4'd11;
            7'd051   : note =   4'd11;
            7'd052   : note =   4'd11;
            7'd053   : note =   4'd10;
            7'd054   : note =   4'd09;
            7'd055   : note =   4'd11;
            7'd056   : note =   4'd10;
            7'd057   : note =   4'd09;
            7'd058   : note =   4'd09;
            7'd059   : note =   4'd09;
            7'd060   : note =   4'd09;
            7'd061   : note =   4'd09;
            7'd062   : note =   4'd09;
            7'd063   : note =   4'd09;
            7'd064   : note =   4'd09;
        endcase
        freq <= freq + 1'b1;
    end


end
endmodule