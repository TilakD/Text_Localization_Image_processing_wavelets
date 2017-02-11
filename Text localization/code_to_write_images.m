clc;
clear all;

img = imread('C:\Users\Tilak\Desktop\Text localization\d7.jpg');

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
cH_binary = im2bw (cH, 0.5);
cV_binary = im2bw (cV, 0.5);
cD_binary = im2bw (cD, 0.63);

text_region_binary = cH_binary .* cV_binary .* cD_binary;

se = strel('square',20);
text_region_binary_dialated = imdilate(text_region_binary,se);

img_half_resized = imresize(img, 0.5);
text_region_masked = immultiply(uint8(text_region_binary_dialated), img_half_resized);


figure(); imshow(img,[]);title('Y component of the YCbCr convertion');
imwrite(img,'C:\Users\Tilak\Desktop\Text localization\images\y.jpg','jpg')

 figure(); imshow(cA,[]);title('DWT Averaged component');
 imwrite(cA,'C:\Users\Tilak\Desktop\Text localization\images\cA.jpg','jpg')
 
 figure(); imshow(cH,[]);title('DWT Horizontal component');
 imwrite(cH,'C:\Users\Tilak\Desktop\Text localization\images\cH.jpg','jpg')
 
 figure(); imshow(cV,[]);title('DWT Vertical component');
 imwrite(cV,'C:\Users\Tilak\Desktop\Text localization\images\cV.jpg','jpg')
 
 figure(); imshow(cD,[]);title('DWT Diagonal component');
 imwrite(cD,'C:\Users\Tilak\Desktop\Text localization\images\cD.jpg','jpg')
 
 figure(); imshow(cA_binary,[]);title('Binarized DWT Averaged component');
 imwrite(cA_binary,'C:\Users\Tilak\Desktop\Text localization\images\cAb.jpg','jpg')
 
 figure(); imshow(cH_binary,[]);title('Binarized DWT Horizontal component');
 imwrite(cH_binary,'C:\Users\Tilak\Desktop\Text localization\images\cHb.jpg','jpg')
 
 figure(); imshow(cV_binary,[]);title('Binarized DWT Vertical component');
 imwrite(cV_binary,'C:\Users\Tilak\Desktop\Text localization\images\cDb.jpg','jpg')
 
 figure(); imshow(cD_binary,[]);title('Binarized DWT Diagonal component');
 imwrite(cD_binary,'C:\Users\Tilak\Desktop\Text localization\images\cDb.jpg','jpg')
 
 figure(); imshow(text_region_binary,[]);title('Binarized Extracted text region.');
 imwrite(text_region_binary,'C:\Users\Tilak\Desktop\Text localization\images\txt_bin.jpg','jpg')
 
 figure(); imshow(text_region_masked,[]);title('Extracted text region');
 imwrite(text_region_masked,'C:\Users\Tilak\Desktop\Text localization\images\txt.jpg','jpg')

 
