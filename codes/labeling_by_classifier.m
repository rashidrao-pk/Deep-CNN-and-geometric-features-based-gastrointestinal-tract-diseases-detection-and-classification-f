
% classifier = fitcecoc(trainingFeatures, trainingLabels, ...
%     'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');

% % Tabulate the results using a confusion matrix.
%confMat = confusionmat(testLabels, preadictedLabels);
% % Convert confusion matrix into percentage form
% confMat = bsxfun(@rdivide,confMat,sum(confMat,2))
% % Display the mean accuracy
% mean(diag(confMat))
cd F:\Study\MS(CS)\All_datasets\Stomach2
%%  Testing
[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Leaf Image File');
imgname=horzcat(pathname,filename);

imr=net.Layers(1, 1).InputSize(:,1);
imc=net.Layers(1, 1).InputSize(:,2);

%%label=testingdeepnet(imgname,xy,net,featureLayer)
foldername=regexp(pathname,'\','split');
foldername=foldername{end-1};
newImage = fullfile(pathname,filename);
% Pre-process the images as required for the CNN

img = readAndPreprocessImage(newImage,imr,imc);
% Extract image features using the CNN
imageFeatures = activations(net, img, 'fc7');

% Make a prediction using the classifier
label = predict(classifier, imageFeatures)

%% Inserting Class Label
[r c j]=size(img);

position = [(r/3),2];
value = char(label(1));
%RGB = insertText(img,position,value);
RGB=insertText(img,position,value,'FontSize',18,'boxcolor','green','TextColor','black');
cd F:\Study\MS(CS)\Papers\Ulcer_2\Labeled

imshow(img);
imwrite(img,filename,'jpg');
imshow(RGB);
imwrite(RGB,['labeled_',filename],'jpg');
