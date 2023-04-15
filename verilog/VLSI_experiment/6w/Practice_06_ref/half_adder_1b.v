// 1bit half adder
// 첫번째 stage에 쓰일 adder

module half_adder_1b(sum, cout, a, b);
    output sum, cout;
    input a,b;

    and(cout, a, b);
    xor(sum, a, b);

endmodule