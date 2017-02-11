%%%% Text localization based on Discrete Wavelet transform %%%%
%%%% 11-03-2015 %%%%
%%%%%%%% By,
%%%%%%%% Srimuka    (1MS11EC111) %%%%%%%%
%%%%%%%% Sudarshan  (1MS11EC112) %%%%%%%%
%%%%%%%% Tilak      (1MS11EC117) %%%%%%%%


%%
% Clear all the preassigned values, clear the command window and close all
% windows.
clc;
clear all;
close all;

%% Initializations
%Read any color image
original_img = imread('C:\Users\Tilak\Desktop\Text localization\d1.jpg');

% Convert the image from RGB to YCbCr if the input image is RGB elseif the
% image is gray use it directly.
try
   img = rgb2ycbcr(original_img);
catch 
   img = original_img;
end 
    
% Extract ony Y component of the YCbCr image
img = double(img(:,:,1));
img = uint8(img);

% Sharpen the image for a better localization (Not mandatory)
img =  imsharpen(img,'Radius',90,'Amount',1);

% Haar DWT for feature extraction (edges).
[cA,cH,cV,cD] = dwt2(img,'haar'); 
cA = mat2gray(cA);
cH = mat2gray(cH);
cV = mat2gray(cV);
cD = mat2gray(cD);

% Threshold the images appropriately
cA_binary = im2bw (cA, 0.4); 
cH_binary = im2bw (cH, 0.4);
cV_binary = im2bw (cV, 0.4);
cD_binary = im2bw (cD, 0.45);

% Extract text region through logical and of horizontal, vertical and
% diagonal components
text_region_binary = cH_binary .* cV_binary .* cD_binary;

% Dialate the the binary image to extract the text region on the original
% image
se = strel('square',20);
text_region_binary_dialated = imdilate(text_region_binary,se);

% Mask the dialated image and use it to extract the text region on the
% original image.
img_half_resized = imresize(img, 0.5);
text_region_masked = immultiply(uint8(text_region_binary_dialated), img_half_resized);


%% Display the input, processed and the text localized image.
figure(1);
 subplot(4,4,1:4); imshow(img,[]);title('Y component of the YCbCr convertion');

 subplot(4,4,5); imshow(cA,[]);title('DWT Averaged component');
 subplot(4,4,6); imshow(cH,[]);title('DWT Horizontal component');
 subplot(4,4,7); imshow(cV,[]);title('DWT Vertical component');
 subplot(4,4,8); imshow(cD,[]);title('DWT Diagonal component');
 
 subplot(4,4,9);  imshow(cA_binary,[]);title('Binarized DWT Averaged component');
 subplot(4,4,10); imshow(cH_binary,[]);title('Binarized DWT Horizontal component');
 subplot(4,4,11); imshow(cV_binary,[]);title('Binarized DWT Vertical component');
 subplot(4,4,12); imshow(cD_binary,[]);title('Binarized DWT Diagonal component');
 
 subplot(4,4,13:14); imshow(text_region_binary,[]);title('Binarized Extracted text region.');
 subplot(4,4,15:16); imshow(text_region_masked,[]);title('Extracted text region');

figure(2);
subplot(1,2,2);imshow(text_region_masked,[]);title('Extracted text region');
subplot(1,2,1);imshow(img,[]);title('Original image');