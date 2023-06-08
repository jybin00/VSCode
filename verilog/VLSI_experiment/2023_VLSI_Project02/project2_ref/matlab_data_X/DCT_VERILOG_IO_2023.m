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
     
     M = textread(sprintf('DCT_image_%d.txt',image_number),'%12c');
     M_2 = char(zeros(262144,16));

     for i=1:262144
         M_2(i,1)= M(i,1);
         M_2(i,2)= M(i,1);
         M_2(i,3)= M(i,1);
         M_2(i,4)= M(i,1);
         M_2(i,5:16) = M(i,1:12);
     end
     
     DCT_img_temp = typecast(uint16(bin2dec(char(M_2))),'int16');
     
     x=1;
     for k= 1:32
         for i= 1:32
             for j = 1 : 16
                 if j == 1
                     DCT_image( 16*(k-1)+j , 16*(i-1)+1 ) = double(DCT_img_temp(x,1));
                 else
                     DCT_image( 16*(k-1)+j , 16*(i-1)+1 ) = double(DCT_img_temp(x,1))/4;
                 end
                 DCT_image( 16*(k-1)+j , 16*(i-1)+2 ) = double(DCT_img_temp(x+1,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+3 ) = double(DCT_img_temp(x+2,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+4 ) = double(DCT_img_temp(x+3,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+5 ) = double(DCT_img_temp(x+4,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+6 ) = double(DCT_img_temp(x+5,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+7 ) = double(DCT_img_temp(x+6,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+8 ) = double(DCT_img_temp(x+7,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+9 ) = double(DCT_img_temp(x+8,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+10 ) = double(DCT_img_temp(x+9,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+11 ) = double(DCT_img_temp(x+10,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+12 ) = double(DCT_img_temp(x+11,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+13 ) = double(DCT_img_temp(x+12,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+14 ) = double(DCT_img_temp(x+13,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+15 ) = double(DCT_img_temp(x+14,1))/4;
                 DCT_image( 16*(k-1)+j , 16*(i-1)+16 ) = double(DCT_img_temp(x+15,1))/4;
                 x = x+16;
             end
         end
     end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%    Cut the image for process Convenience   %%%%%
    %%%%%            and get the image data          %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [m,n] = size(DCT_image);

    m = floor(m/8)*8;
    n = floor(n/8)*8;




%      verilog_image = textread(sprintf('DCT_image_%d.txt',image_number),'%12c');

%      verilog_image = textread(sprintf('DCT_image_%d.txt',image_number),'%12c');

     


     %---------------------Quatization bit setup-----------------------------
     
     % The number of bits for DCT Coefficient Quantization
     % You can "adjust this number" to improve the qualities of images
     C_quantization_bit =  10;
     T = func_DCT_Coefficient_quant(C_quantization_bit);



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






    %  Allocate the array for Image restore
    Image_restore = zeros(256,256);

    for i=1:m/16
        for j=1:n/16
            Block_temp = DCT_image((16*i-15):16*i,(16*j-15):16*j);
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
 