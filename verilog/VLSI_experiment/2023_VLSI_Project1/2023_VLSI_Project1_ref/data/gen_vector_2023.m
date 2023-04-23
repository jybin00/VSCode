row     = 64;
column  = 64;
bits    =  8;

a = randi([0, 2^bits-1], [row,column]);
b = randi([0, 2^bits-1], [row,column]);
c = a*b;

f00 = fopen('./vec_a.txt','w');
    for i=1:column
        for j=1:row
            fprintf(f00, '%X \n', a(i,j));
        end
    end
fclose(f00);

f01 = fopen('./vec_b.txt','w');
    for i=1:column
        for j=1:row
            fprintf(f00, '%X \n', b(i,j));
        end
    end
fclose(f01);

f02 = fopen('./vec_c.txt','w');
    for i=1:column
        for j=1:row
            fprintf(f00, '%X \n', c(i,j));
        end
    end
fclose(f02);