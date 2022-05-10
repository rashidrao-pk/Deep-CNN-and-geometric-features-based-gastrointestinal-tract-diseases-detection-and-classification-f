close all
clear all
clc
cd D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\input
[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Leaf Image File');

img=imread([pathname,filename]); 
img=imresize(img,[256 256]);

R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);
lab= rgb2lab(img);
Lab_L=lab(:,:,1);
Lab_a=lab(:,:,2);
Lab_b=lab(:,:,3);


imshow(img);
salMat=saliencyMeasure({Lab_L,Lab_a,Lab_b});

binary1=im2bw(salMat,0.3);
% figure, imshow(binary1);

I = rgb2ycbcr(img);

channel1Min = 157.000;
channel1Max = 214.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 84.000;
channel2Max = 123.000;
% Define thresholds for channel 3 based on histogram settings
channel3Min = 137.000;
channel3Max = 195.000;
% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;
% Initialize output masked image based on input image.
maskedRGBImage = img;
% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
se = strel('disk',6);
BW2 = imclose(BW,se);
BW3=bwareaopen(BW,20);
% figure,imshow(BW3);
fused1=BW3+binary1;
% figure,imshow(fused1);
fused2=fused1.*BW3;
% figure,imshow(fused2);
fused3=bwareaopen(fused2,100);

imshow(fused3);
% 
% 
 cd F:\Study\MS(CS)\Attique_Data\Matlab\G_Tooth_Images\GT\GTBW
 [filename2, pathname2] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Leaf Image File');
 gtimg=imread([pathname2,filename2]);
%
% a
gtruth=im2bw(gtimg);
% figure, imshow(gtruth);
[x, y]=size(fused3);
 gtruth=imresize(gtruth, [x  y]);
  
segmented=fused3;
segVec = segmented(:);        % Algorithm segmented image
gtruthVec = gtruth(:);  % Ground truth
[rows, cols] = size(gtruthVec);
count = 0;
for i= 1:rows
    if (segVec(i) == 1 && gtruthVec(i) == 1)
        count = count +1;
    else
        continue; 
    end
end
segCount = sum(sum(segmented));
gtruthCount = sum(sum(gtruth));
finalval = count/(segCount + gtruthCount - count);
  finalval=finalval*100;
  out=string(finalval);
  [zpath,zname,zext]=fileparts(filename);
  [zpath1,zname2,zext2]=fileparts(filename2);
subplot(221),imshow(img),title(['Input ' zname]);
subplot(222),imshow(gtimg),title(['Ground Tooth ' zname2]);
subplot(223),imshow(gtruth),title('Ground Tooth Binary Image');
subplot(224),imshow(fused3),title([out "%"]);

clear zpath zname zext zpath1 zname2 zext2 out 
