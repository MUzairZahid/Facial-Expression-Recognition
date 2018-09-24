%%
clc
clear all
close all
%% Transfer learning Approach
% Create Image data store from Processed data (3 channel).
imds = imageDatastore('ProcessedData', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

% Dividing data into train and validation. 70-30 Split
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');

%Display some sample images.

numTrainImages = numel(imdsTrain.Labels);
idx = randperm(numTrainImages,16);
figure
for i = 1:16
    subplot(4,4,i)
    I = readimage(imdsTrain,idx(i));
    imshow(I)
end

%Load Pretrained Network
net = alexnet;

% Extracting all layers except last 3.
layersTransfer = net.Layers(1:end-3);

numClasses = numel(categories(imdsTrain.Labels));

layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];
%% Network Training
%Uncomment the section if training is required.

% options = trainingOptions('sgdm',...
%     'MiniBatchSize',5,...
%     'MaxEpochs',10,...
%     'InitialLearnRate',0.0001);
% 
% % Fine-tune the network using |trainNetwork| on the new layer array.
% netTransfer = trainNetwork(imdsTrain,layers,options);

%%
load('netTransfer.mat');
% Classify the test images using |classify|.
predictedLabels = classify(netTransfer,imdsValidation);

%%
% Display four sample test images with their predicted labels.
idx = [1 33 20 41];
figure
for i = 1:numel(idx)
    subplot(2,2,i)
    
    I = readimage(imdsValidation,idx(i));
    label = predictedLabels(idx(i));
    
    imshow(I)
    title(char(label))
    drawnow
end

%%
% Calculate the classification accuracy.
testLabels = imdsValidation.Labels;

accuracy = sum(predictedLabels==testLabels)/numel(predictedLabels)

%% Feature Extraction Approach

%Load Pretrained Network
net = alexnet;

layer = 'fc7';
featuresTrain = activations(net,imdsTrain,layer,'OutputAs','rows');
featuresTest = activations(net,imdsValidation,layer,'OutputAs','rows');

%Extract the class labels from the training and test data.
YTrain = imdsTrain.Labels;
YTest = imdsValidation.Labels;

%Fit svm 
classifier = fitcecoc(featuresTrain,YTrain);


YPred = predict(classifier,featuresTest);


idx = [1 5 10 15];
figure
for i = 1:numel(idx)
    subplot(2,2,i)
    I = readimage(imdsValidation,idx(i));
    label = YPred(idx(i));
    imshow(I)
    title(char(label))
end

accuracy = mean(YPred == YTest)