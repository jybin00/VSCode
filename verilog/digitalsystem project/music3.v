module music3 (clk, notes, sel, em);

input clk,sel;
output [3:0] notes;
reg [3:0] note; 
output reg em = 0; // end music
integer freq = 0;
integer a,b;
assign notes = note;

always@(posedge clk) begin
    if(sel == 1'b1) begin
      freq = 1'b0;
      em = 1'b0;
      end
    else if(freq >= 8'd90) begin
        freq = 0;
        em = 1'b1;
        end
    else begin
        case(freq)
            8'd001   : note =   4'd08;
            8'd002   : note =   4'd08;
            8'd003   : note =   4'd14;
            8'd004   : note =   4'd08;
            8'd005   : note =   4'd10;
            8'd006   : note =   4'd10;
            8'd007   : note =   4'd09;
            8'd008   : note =   4'd08;
            8'd009   : note =   4'd10;
            8'd010   : note =   4'd10;
            8'd011   : note =   4'd09;
            8'd012   : note =   4'd08;
            8'd013   : note =   4'd08;
            8'd014   : note =   4'd08;
            8'd015   : note =   4'd10;
            8'd016   : note =   4'd10;
            8'd017   : note =   4'd14;
            8'd018   : note =   4'd14;
            8'd019   : note =   4'd14;
            8'd020   : note =   4'd10;
            8'd021   : note =   4'd09;
            8'd022   : note =   4'd09;
            8'd023   : note =   4'd07;
            8'd024   : note =   4'd07;
            8'd025   : note =   4'd14;
            8'd026   : note =   4'd14;
            8'd027   : note =   4'd14;
            8'd028   : note =   4'd14;
            8'd029   : note =   4'd01;
            8'd030   : note =   4'd01;
            8'd031   : note =   4'd05;
            8'd032   : note =   4'd05;
            8'd033   : note =   4'd04;
            8'd034   : note =   4'd04;
            8'd035   : note =   4'd04;
            8'd036   : note =   4'd03;
            8'd037   : note =   4'd04;
            8'd038   : note =   4'd04;
            8'd039   : note =   4'd04;
            8'd040   : note =   4'd05;
            8'd041   : note =   4'd04;
            8'd042   : note =   4'd03;
            8'd043   : note =   4'd01;
            8'd044   : note =   4'd00;
            8'd045   : note =   4'd01;
            8'd046   : note =   4'd01;
            8'd047   : note =   4'd05;
            8'd048   : note =   4'd05;
            8'd049   : note =   4'd04;
            8'd050   : note =   4'd04;
            8'd051   : note =   4'd04;
            8'd052   : note =   4'd03;
            8'd053   : note =   4'd04;
            8'd054   : note =   4'd04;
            8'd055   : note =   4'd04;
            8'd056   : note =   4'd05;
            8'd057   : note =   4'd04;
            8'd058   : note =   4'd03;
            8'd059   : note =   4'd01;
            8'd060   : note =   4'd00;
            8'd061   : note =   4'd01;
            8'd062   : note =   4'd01;
            8'd063   : note =   4'd03;
            8'd064   : note =   4'd03;
            8'd065   : note =   4'd08;
            8'd066   : note =   4'd08;
            8'd067   : note =   4'd08;
            8'd068   : note =   4'd08;
            8'd069   : note =   4'd05;
            8'd070   : note =   4'd05;
            8'd071   : note =   4'd14;
            8'd072   : note =   4'd05;
            8'd073   : note =   4'd04;
            8'd074   : note =   4'd03;
            8'd075   : note =   4'd01;
            8'd076   : note =   4'd00;
            8'd077   : note =   4'd01;
            8'd078   : note =   4'd01;
            8'd079   : note =   4'd03;
            8'd080   : note =   4'd03;
            8'd081   : note =   4'd08;
            8'd082   : note =   4'd08;
            8'd083   : note =   4'd08;
            8'd084   : note =   4'd08;
            8'd085   : note =   4'd07;
            8'd086   : note =   4'd07;
            8'd087   : note =   4'd07;
            8'd088   : note =   4'd07;
            8'd089   : note =   4'd14;
            8'd090   : note =   4'd14;
        endcase
        freq <= freq + 1'b1;
    end
end
endmodule