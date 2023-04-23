for i in range(0,1):
    print('// stage {0}\n\
    wire   [26-1:0] stage{0}_in;\n\
    wire   [25-1:0] stage{0}_out, stage{0}_cout;\n\
    CSM_stage_and and_out{0} (stage{0}_in, a, b[{0}]);\n\
    CSM_stageX_adder full{1} (stage{0}_out, mul_out[{0}], stage{1}_cout, stage{1}_out, stage{0}_in, stage{1}_cout);\n'.format(i, i-1))

for i in range(0,6):
    print('wire [12-1:0] x{0}; \n\
    d_ff_12bit stage{0}(x{0}, direct_in, clk, rstn); \n\
    wire [24-1:0] mul{0}; \n\
    mul1 = x{0} * c{0}'.format(i))