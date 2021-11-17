%%Storing Training Images
imgStoreTraining = imageDatastore('TrafficSignData\Train', 'IncludeSubfolders', 1, 'LabelSource', 'foldernames');
%%Storing Testing Images
imgStoreTesting = imageDatastore('TrafficSignData\Test', 'IncludeSubfolders', 1, 'LabelSource', 'foldernames');

imgTotalTrain = length(imgStoreTraining.Files);
imgTotalTest = length(imgStoreTesting.Files);

labelsTrain = imgStoreTraining.Labels;
labelsTest = imgStoreTesting.Labels;

%%Empty vector for storing matlab formatted images. 
imgMatrixTrain = [];
imgMatrixTest = [];

%%Fill imgVectorTrain array. 
for j = 1:imgTotalTrain
       img = readimage(imgStoreTraining, j);
       imgGray = rgb2gray(img);
       imgdouble = im2double(imgGray);
       imgMatrixTrain = [imgMatrixTrain, imgdouble(:)];
end
%%Transposing to row vector. 
imgMatrixTrain = imgMatrixTrain';


%%Fill imgVectorTest array.
for j = 1:imgTotalTest
       img = readimage(imgStoreTesting, j);
       imgGray = rgb2gray(img);
       imgdouble = im2double(imgGray);
       imgMatrixTest = [imgMatrixTest, imgdouble(:)];
end
%%Transposing to row vector. 
imgMatrixTest = imgMatrixTest';

%%Model Training Section 
dicriminantmodel = fitcdiscr(imgMatrixTrain, labelsTrain);
predictions = predict(dicriminantmodel, imgMatrixTest);
confusionchart(imgStoreTesting.Labels,predictions)
