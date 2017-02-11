clc;
clear all;

img = imread('C:\Users\Tilak\Desktop\Text localization\d4.jpg');

try
   imycbcr = rgb2ycbcr(img);
end

img = double(imycbcr(:,:,1));
img = uint8(img);

%img =  imsharpen(img,'Radius',90,'Amount',1);

[cA,cH,cV,cD] = dwt2(img,'haar'); 
cA = mat2gray(cA);
cH = mat2gray(cH);
cV = mat2gray(cV);
cD = mat2gray(cD);

cA_binary = im2bw (cA, 0.4);
cH_binary = im2bw (cH, 0.6);
cV_binary = im2bw (cV, 0.6);
cD_binary = im2bw (cD, 0.75);


text_region_binary = cH_binary .* cV_binary .* cD_binary;

se = strel('square',20);
text_region_binary_dialated = imdilate(text_region_binary,se);

img_half_resized = imresize(img, 0.5);
text_region_masked = immultiply(uint8(text_region_binary_dialated), img_half_resized);


 subplot(4,4,1:4); imshow(img,[]);title('Y component of the YCbCr convertion');

 subplot(4,4,5); imshow(cA,[]);title('DWT Averaged component');
 subplot(4,4,6); imshow(cH,[]);title('DWT Horizontal component');
 subplot(4,4,7); imshow(cV,[]);title('DWT Vertical component');
 subplot(4,4,8); imshow(cD,[]);title('DWT Diagonal component');
 
 subplot(4,4,9); imshow(cA_binary,[]);title('Binarized DWT Averaged component');
 subplot(4,4,10); imshow(cH_binary,[]);title('Binarized DWT Horizontal component');
 subplot(4,4,11); imshow(cV_binary,[]);title('Binarized DWT Vertical component');
 subplot(4,4,12); imshow(cD_binary,[]);title('Binarized DWT Diagonal component');
 
 subplot(4,4,13:14); imshow(text_region_binary,[]);title('Binarized Extracted text region.');
 subplot(4,4,15:16); imshow(text_region_masked,[]);title('Extracted text region');

figure(2);
subplot(1,2,2);imshow(text_region_masked,[]);title('Extracted text region');
subplot(1,2,1);imshow(img,[]);title('Original image');