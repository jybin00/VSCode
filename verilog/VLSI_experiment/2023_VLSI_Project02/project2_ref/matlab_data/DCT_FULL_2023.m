clear all
close all
clc

for image_number = 1:8 %-------------"Change this number" to test many different images------
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
         fprintf(input_vector, '%s', dec2hex(vector_temp(1,i)));
         if(mod(i,16)==0)
             fprintf(input_vector, '\n');
         else

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
     C_quantization_bit =  10;
     T = func_DCT_Coefficient_quant(C_quantization_bit);
     
     % If you want to check the coefficient value in hex format, please use this and open the txt file.
     filter_coef = fopen('./filt_coeff_T.txt','w');
     for k = 1:16
         fprintf(filter_coef,'%x \n',T(k,1)*2^(C_quantization_bit-1));
     end



     %--------------------------- DCT OPERATION ---------------------------
     
     %---------------------Quatization bit setup-----------------------------
     % The number of bits for Result of 1D-DCT Quantization
     % You can "adjust this number" to improve the qualities of images.
     Result_1D_DCT_quantization_bit = 14;
     
     % The number of integer bits for Result of 1D-DCT
     num_int = 12;
     
     %--------------------------- DCT OPERATION -----------------------------
     Image_tran = zeros(m,n);
     
     for i=1:m/16
         for j=1:n/16
             Block_temp = input_image_512x512((16*i-15):16*i,(16*j-15):16*j);
             Block_DCT_1D_temp = T*Block_temp';
             Block_DCT_1D_quant((16*i-15):16*i,(16*j-15):16*j) = func_DCTquant(Block_DCT_1D_temp, Result_1D_DCT_quantization_bit, num_int);   % result of 1D DCT for debugging
             Block_DCT_2D_temp = T*Block_DCT_1D_quant((16*i-15):16*i,(16*j-15):16*j)';
             Block_DCT_2D_quant((16*i-15):16*i,(16*j-15):16*j) = (Block_DCT_2D_temp); % result of 2D DCT for debugging
             Block_DCT_final((16*i-15):16*i,(16*j-15):16*j) = func_DCTquant_trunc(Block_DCT_2D_quant((16*i-15):16*i,(16*j-15):16*j));
             Block_DCT = Block_DCT_final((16*i-15):16*i,(16*j-15):16*j);
             Block_r = round(Q_pre.\Block_DCT);
             Image_tran((16*i-15):16*i,(16*j-15):16*j) = Block_r;
         end
     end




    %--------%--------%--------%--------%--------%--------%--------%--------%--%
    %---------%---- End of 2D DCT, Quantization  %--------%--------%--------%--%
    %--------%--------%--------%--------%--------%--------%--------%--------%--%
     
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%  After the Transformation  %%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%   Assume lossless entropy coding   %%%%%%%%%%%%%%
    %%%%%%%%   Assume lossless communication channel   %%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%     For the image restoration    %%%%%%%%%%%%%%%%
    %%%%      Multiplication with Quantization Matrix         %%%%
    %%%%%%%%%%%%    2-D IDCT Matrix Multiplication   %%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
    %--------%--------%--------%--------%--------%--------%--------%--------%--%
    %--------- START of Dequantization, 2D IDCT  %--------%--------%--------%--%
    %--------%--------%--------%--------%--------%--------%--------%--------%--%





    %  Allocate the array for Image restore
    Image_restore = zeros(256,256);

    for i=1:m/16
        for j=1:n/16
            Block_temp = Image_tran((16*i-15):16*i,(16*j-15):16*j);
            Block_rq = Q.*Block_temp;
            Block_IDCT = T'*Block_rq*T;
            Image_restore((16*i-15):16*i,(16*j-15):16*j) = Block_IDCT;
        end
    end


    for i=1:m
        for j=1:n
            if Image_restore(i,j) > 255
               Image_restore(i,j) = 255;
            end

            if Image_restore(i,j) < 0
               Image_restore(i,j) = 0;
            end

        end
    end   

    %------------------------Generate the output Image--------------------------    

    output_file_name = sprintf( 'image_out_%d.tif',image_number);
    imwrite(uint8(Image_restore),output_file_name,'tif');




    %-------------------------Calculate the PSNR--------------------------------
    MSE = 0;

    for row = 1:m
      for col = 1:n
        MSE = MSE + (input_image_512x512(row, col) - Image_restore(row, col)) ^ 2;
      end
    end

    MSE = MSE / (m * n);
    PSNR(1,image_number) = 10 * log10 ((255^2) / MSE);



    %-------------------------Show the output image -----------------------------------
     subplot(4,4,image_number*2);
     imshow(Image_restore./255);
     title ( sprintf('Restored image #%d \n PSNR : %d',image_number,PSNR(image_number)) );

 
 end
 