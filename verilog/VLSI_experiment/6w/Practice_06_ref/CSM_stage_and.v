// 각 스테이지에서 b를 한 비트 받아서 a랑 모두 and gate에 넣어서 뚝닥.

module CSM_stage_and(bit_multi, a, b);

    output [25:0]bit_multi;
    input [25:0]a;
    input  b;
    

    and(bit_multi[0], a[0], b);
    and(bit_multi[1], a[1], b);
    and(bit_multi[2], a[2], b);
    and(bit_multi[3], a[3], b);
    and(bit_multi[4], a[4], b);
    and(bit_multi[5], a[5], b);
    and(bit_multi[6], a[6], b);
    and(bit_multi[7], a[7], b);
    and(bit_multi[8], a[8], b);
    and(bit_multi[9], a[9], b);
    and(bit_multi[10], a[10], b);
    and(bit_multi[11], a[11], b);
    and(bit_multi[12], a[12], b);
    and(bit_multi[13], a[13], b);
    and(bit_multi[14], a[14], b);
    and(bit_multi[15], a[15], b);
    and(bit_multi[16], a[16], b);
    and(bit_multi[17], a[17], b);
    and(bit_multi[18], a[18], b);
    and(bit_multi[19], a[19], b);
    and(bit_multi[20], a[20], b);
    and(bit_multi[21], a[21], b);
    and(bit_multi[22], a[22], b);
    and(bit_multi[23], a[23], b);
    and(bit_multi[24], a[24], b);
    and(bit_multi[25], a[25], b);

    
endmodule