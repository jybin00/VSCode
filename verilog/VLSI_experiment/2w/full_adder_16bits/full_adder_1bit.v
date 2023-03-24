// full adder 1bit 만들기
// 수업 자료 보고 만들기.

module full_adder_1bit(sum, c_out, a, b, c_in);

    output sum, c_out;
    input a, b, c_in;

    wire s1, s2, c1;

    xor(s1, a, b);
    and(c1, a, b);
    xor(sum, s1, c_in);
    and(s2, s1, c_in);
    xor(c_out, s2, c1);
    
endmodule