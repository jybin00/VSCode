for i in range(25,26):
    print('// stage {0}\n\
    wire   [26-1:0] stage{0}_in;\n\
    wire   [25-1:0] stage{0}_out, stage{0}_cout;\n\
    CSM_stage_and and_out{0} (stage{0}_in, a, b[{0}]);\n\
    CSM_stageX_adder full{1} (stage{0}_out, mul_out[{0}], stage{1}_cout, stage{1}_out, stage{0}_in, stage{1}_cout);\n'.format(i, i-1))
