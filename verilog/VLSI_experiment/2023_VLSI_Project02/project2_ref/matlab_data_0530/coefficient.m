clear all
close all
%clc
tic

Max_Block_DCT = zeros(16,16);

for image_number = 1 %-------------"Change this number" to test many different images------
    fprintf("image %d\n", image_number);
    %---------------------------- Get the Image data Input ----------------------------------
    input_image_512x512 = double( imread( sprintf( 'image_in_%d.tif',image_number ),'tiff' ) );
    [m,n] = size(input_image_512x512);
    m = floor(m/8)*8;
    n = floor(n/8)*8;
     
     %------------------------------------ show input image -----------------------------------
     subplot(4,4,image_number*2-1);
     imshow(input_image_512x512./255);
     title ( sprintf('Original image #%d \n size : %dx%d', image_number, m, n) );
     %-----------------------------------------------------------------------------------------    
     
     %------------------------------------generate input text file -----------------------------------
     x=1;
     for l = 1:32
         for k = 1:32
             for i = 1:16
                 for j = 1:16
                     vector_temp(1, x) = input_image_512x512((i+16*(l-1)),(j+16*(k-1)));
                     x= x+1;
                 end
             end
         end
     end


     input_vector = fopen(sprintf( 'image_in_%d.txt',image_number), 'w');

     for i = 1 : (512*512)
         fprintf(input_vector, '%s', dec2hex(vector_temp(1,i),2));
         if(mod(i,16)==0)
             fprintf(input_vector, '\n');
         end
     end
     
     
     
     %-------------------------Generation of DCT Bases Vector Matrix ----------------------
     
     % Quantization coefficient after DCT operation (Not used for DCT)
     % (1,1) value (16) should be changed according to the truncation point
     
     Q=[ 16	 14	 11	 11	 10	 13	 16	 20	 24	 32	 40	 46	 51	 56	 61 61
        14	 13	 12	 12	 12	 15	 18	 21	 25	 37	 49	 52	 56	 57	 58 58
        12	 12	 12	 13	 14	 17	 19	 23	 26	 42	 58	 59	 60	 58	 55 55
        13	 13	 13	 14	 15	 18	 22	 27	 33	 45	 58	 61	 65	 60	 56 56
        14	 14	 13	 15	 16	 20	 24	 32	 40	 49	 57	 63	 69	 63	 56 56
        14	 15	 15	 17	 19	 23	 27	 36	 46	 59	 72	 73	 75	 67	 59 59
        14	 16	 17	 20	 22	 26	 29	 40	 51	 69	 87	 84	 80	 71	 62 62
        16	 18	 20	 25	 30	 36	 43	 51	 60	 79	 98	 95	 92	 81	 70 70
        18	 20	 22	 30	 37	 47	 56	 62	 68	 89	109	106	103	 90	 77 77
        21	 25	 29	 37	 46	 53	 60	 67	 75	 91	107	107	108	 96	 85 85
        24	 30	 35	 45	 55	 60	 64	 73	 81	 93	104	109	113	103	 92 92
        37	 43	 50	 58	 67	 71	 76	 84	 92	102	113	115	117	107	 97 97
        49	 57	 64	 71	 78	 83	 87	 95	103	112	121	121	120	111	101 101
        61	 69	 78	 82	 87	 90	 93	100	108	109	111	111	112	106	100 100
        72	 82	 92	 94	 95	 97	 98	105	112	106	100	102	103	101	99 99
        72	 82	 92	 94	 95	 97	 98	105	112	106	100	102	103	101	99 99];
     
     Q_pre=[ 16	 14	 11	 11	 10	 13	 16	 20	 24	 32	 40	 46	 51	 56	 61 61
            14	 13	 12	 12	 12	 15	 18	 21	 25	 37	 49	 52	 56	 57	 58 58
            12	 12	 12	 13	 14	 17	 19	 23	 26	 42	 58	 59	 60	 58	 55 55
            13	 13	 13	 14	 15	 18	 22	 27	 33	 45	 58	 61	 65	 60	 56 56
            14	 14	 13	 15	 16	 20	 24	 32	 40	 49	 57	 63	 69	 63	 56 56
            14	 15	 15	 17	 19	 23	 27	 36	 46	 59	 72	 73	 75	 67	 59 59
            14	 16	 17	 20	 22	 26	 29	 40	 51	 69	 87	 84	 80	 71	 62 62
            16	 18	 20	 25	 30	 36	 43	 51	 60	 79	 98	 95	 92	 81	 70 70
            18	 20	 22	 30	 37	 47	 56	 62	 68	 89	109	106	103	 90	 77 77
            21	 25	 29	 37	 46	 53	 60	 67	 75	 91	107	107	108	 96	 85 85
            24	 30	 35	 45	 55	 60	 64	 73	 81	 93	104	109	113	103	 92 92
            37	 43	 50	 58	 67	 71	 76	 84	 92	102	113	115	117	107	 97 97
            49	 57	 64	 71	 78	 83	 87	 95	103	112	121	121	120	111	101 101
            61	 69	 78	 82	 87	 90	 93	100	108	109	111	111	112	106	100 100
            72	 82	 92	 94	 95	 97	 98	105	112	106	100	102	103	101	99 99
            72	 82	 92	 94	 95	 97	 98	105	112	106	100	102	103	101	99 99];
     
     %---------------------Quatization bit setup-----------------------------
     
     % The number of bits for DCT Coefficient Quantization
     % You can "adjust this number" to improve the qualities of images
     % Original = 10;
     C_quantization_bit =  7; % (1 . C_quantization_bit -1) 6~7비트 사이 괜찮은 듯.
     T = func_DCT_Coefficient_quant(C_quantization_bit); % 몇 개로 자를까?
     
     % If you want to check the coefficient value in hex format, please use this and open the txt file.
     image1_X_k = fopen('./filt_coeff_T.txt','w');
     for k = 1:16
         fprintf(image1_X_k,'%x \n',T(k,1)*2^(C_quantization_bit-1));
     end



     %--------------------------- DCT OPERATION ---------------------------
     
     %---------------------Quatization bit setup-----------------------------
     % The number of bits for Result of 1D-DCT Quantization
     % You can "adjust this number" to improve the qualities of images.
     % Original = 14;
     Result_1D_DCT_quantization_bit = 11; % DCT 결과  = BW
     
     % The number of integer bits for Result of 1D-DCT
     % Original = 12;
     % quantization bit - num_int 한 만큼 소수점 quntization
     % 생각해보니까 X[k]는 한번 곱해진게 아니라 16번 계수와 곱해진게 더해진거네,, 
     % 당연히 4정도 곱해지면 정수 부분이 커져야 맞다.
     num_int = 11; % BW 중에서 int의 범위
     
     %--------------------------- DCT OPERATION -----------------------------
     Image_tran = zeros(m,n);
%      image5_X_k = fopen('./image5_2D_Xk.txt','w');


     for i=1:m/16
         
         for j=1:n/16
             Block_temp = input_image_512x512((16*i-15):16*i,(16*j-15):16*j);

             Block_DCT_1D_temp = T*Block_temp'; % T가 DCT 블록임.

             Block_DCT_1D_quant((16*i-15):16*i,(16*j-15):16*j) = func_DCTquant(Block_DCT_1D_temp, Result_1D_DCT_quantization_bit, num_int);   % result of 1D DCT for debugging
             
             Block_DCT_2D_temp = T*Block_DCT_1D_quant((16*i-15):16*i,(16*j-15):16*j)';

             Block_DCT_2D_quant((16*i-15):16*i,(16*j-15):16*j) = (Block_DCT_2D_temp); % result of 2D DCT for debugging

             Block_DCT_final((16*i-15):16*i,(16*j-15):16*j) = func_DCTquant_trunc(Block_DCT_2D_quant((16*i-15):16*i,(16*j-15):16*j));

             Max_Block_DCT = max(Max_Block_DCT, Block_DCT_final((16*i-15):16*i,(16*j-15):16*j));

             Block_DCT = Block_DCT_1D_quant((16*i-15):16*i,(16*j-15):16*j);

             

%              for k = 1:16
%                  for l = 1:16
%                      DCT_quant = (Block_DCT_final(16*(i-1)+l,k+(j-1)*16));
%                      if(DCT_quant <0)
%                          DCT_quant = (DCT_quant + power(2, Result_1D_DCT_quantization_bit));
%                      end
%                      DCT_quant = DCT_quant * 2;
%                     fprintf(image5_X_k,'%X ', DCT_quant);
%                  end
%                 fprintf(image5_X_k,'\n');
%              end

             Block_r = round(Q_pre.\Block_DCT);

             Image_tran((16*i-15):16*i,(16*j-15):16*j) = Block_r;
         end
     end
end