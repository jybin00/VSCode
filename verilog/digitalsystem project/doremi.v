
module doremi (reset, clk, key, piezo);
input clk,reset;
input[3:0] key;
output piezo;
reg buff;
integer cnt_sound, limit;
wire piezo;

always@(key)
begin
      case(key)
         4'd00:limit = 1911;
         4'd01:limit = 1702;
         4'd02:limit = 1516;
         4'd03:limit = 1431;
         4'd04:limit = 1275;
         4'd05:limit = 1136;
         4'd06:limit = 1012;
         4'd07:limit = 955;
         4'd08:limit = 851;
         4'd09:limit = 758;
         4'd10:limit = 715;
         4'd11:limit = 637;
         4'd12:limit = 568;
         4'd13:limit = 506;
         4'd14:limit=0;
      endcase
end

always@(posedge clk)
begin
   if(reset)
      begin
         buff=1'b0;
         cnt_sound=0;
      end
   else
      begin
         if(cnt_sound>=limit)
            begin
               cnt_sound = 0;
               buff = ~buff;
            end
         else
            cnt_sound = cnt_sound + 1;
      end
end
assign piezo=buff;

endmodule
   