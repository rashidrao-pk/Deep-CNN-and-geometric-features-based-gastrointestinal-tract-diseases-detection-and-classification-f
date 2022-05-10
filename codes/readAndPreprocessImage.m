function Iout = readAndPreprocessImage(img1,imr,imc) 
        I = imread(img1);
%          if(size(I, 3) == 3)
%                     I=rgb2gray(I);
%             end
        % Some images may be grayscale. Replicate the image 3 times to
%         % create an RGB image.
        if ismatrix(I)
            I = cat(3,I,I,I);
        end
           
        % Resize the image as required for the CNN.
        Iout = imresize(I, [imr imc]);
        % Note that the aspect ratio is not preserved. In Caltech 101, the
        % object of interest is centered in the image and occupies a
        % majority of the image scene. Therefore, preserving the aspect
        % ratio is not critical. However, for other data sets, it may prove
        % beneficial to preserve the aspect ratio of the original image
        % when resizing.
end