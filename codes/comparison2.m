%function [BW,maskedRGBImage] = rgb(~)

%  [BW,MASKEDRGBIMAGE] = createMask(RGB) thresholds image RGB using

%  minimum/maximum values for each channel of the colorspace were set 
%   and result in a binary mask BW and a composite image maskedRGBImage,
%  which shows the original RGB image values under the mask BW.

%------------------------------------------------------

RGB=imread('D:\Thesis Material\stomach Dataset\cop\142.jpg');
gtruth=imread('D:\Thesis Material\Binary images\142.jpg');
% Convert RGB image to chosen color space

I = rgb2ycbcr(RGB);

% Define thresholds for channel 1 based on histogram settings
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
maskedRGBImage = RGB;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
se = strel('disk',6);
BW2 = imclose(BW,se);
BW3=bwareaopen(BW,20);

%end

gtruth=im2bw(gtruth);
% figure, imshow(gtruth);
[x, y]=size(gtruth);
 gtruth=imresize(gtruth, [x  y]);
 %figure, imshow(gtruth);
% gtruth=imread('E:\DataSetPH2\PH2 Dataset images\IMD002\IMD002_lesion\IMD004_lesion.bmp');
% final5=imresize(final5, [574, 765]);
% figure, imshow(final5);
% gtruth=imresize(gtruth, [256 256]);
% finalImg2 = repmat(gtruth,[1 1 3]) .* im2double(Ienhancee);
%     figure; imshow(finalImg2); title('gtruth mapped');
segmented=BW;
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
  

subplot(2,2,1), imshow(RGB), title("Normal original image");
subplot(2,2,2), imshow(BW), title("segmented image");
subplot(2,2,3), imshow(gtruth), title("Ground Truth image");
subplot(2,2,4), imshow(maskedRGBImage), title("masked image");