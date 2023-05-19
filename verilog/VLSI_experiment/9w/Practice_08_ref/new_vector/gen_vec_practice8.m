clear all
clc

coef = [   0.295410156246438
          -0.423339843746311
           0.514404295875442
          -0.422019101267101
           0.789794921875206];

%coef(a.b)
%input(c.d)
%output(e.f)
%tap number:g    
a=12;
b=11;
c=12;
d=10;
e=22;
f=18;
g=5;

quant_coef = floor(coef*power(2,b)+0.5)/power(2,b); 
sum(abs(quant_coef))
int_q_coeff = quant_coef*power(2,b);
[n, m] = size(quant_coef);

filter_coef = fopen('./filt_coeff.txt','w');  
% Output print out
for k = 1:n
    %%%%
    pr_q_coef = int_q_coeff(k);
    if(int_q_coeff(k) < 0)
        pr_q_coef = pr_q_coef + power(2,a);
    end
    fprintf(filter_coef,'%4x \n',pr_q_coef);
    %%%%
end

N = 256;
input_int = floor(power(2,c-d)*(rand(1, N)-0.5)*power(2,d));                 %% real 14.12 inputs
input_real = input_int/power(2,d);    %% real 14.12 inputs
input_vector = fopen('input_vector_hex.txt','w');
input_vector_dec = fopen('input_vector_dec.txt','w');
for k = 1:N
    %%%%
    pr_input = input_int(k);
    if(pr_input < 0)
        pr_input = pr_input + power(2,c);
    end
    fprintf(input_vector,'%4X \n', pr_input);
    %%%%
    fprintf(input_vector_dec, '%d \n', input_int(k));
end


load input_vector_dec.txt;
output_vector = fopen('output_vector_hex.txt','w');
size(input_vector_dec)
input_vector = input_vector_dec/power(2,d);
flag = 0;
for k = 1:N-g+1
    error = 0;
   filter_input = input_vector(k:k+g-1);
   filter_out = zeros(N, 1);
   for n = 1:g 
        mult_out = filter_input(g-n+1)*quant_coef(n);
        filter_out(k) = filter_out(k) + mult_out;
   end
   %% 반올림.
   pr_filter_out = floor(filter_out(k)*power(2,f) + 0.5);
   %% considering negative numbers for print out
   if(pr_filter_out < 0)
        pr_filter_out = pr_filter_out + power(2,e);
   end
   fprintf(output_vector,'%6x \n', pr_filter_out);
end


