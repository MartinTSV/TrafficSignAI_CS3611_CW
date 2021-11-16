%%Storing Training Images
imgStoreTraining = imageDatastore('TrafficSignData\Train', 'IncludeSubfolders', 1, 'LabelSource', 'foldernames');
%%Storing Testing Images
imgStoreTesting = imageDatastore('TrafficSignData\Test', 'IncludeSubfolders', 1, 'LabelSource', 'foldernames');

imgTotalTrain = length(imgStoreTraining.Files);
imgTotalTest = length(imgStoreTesting.Files);

%%Empty vector for storing matlab formatted images. 
imgVectorTrain = [];
imgVectorTest = [];

%%Fill imgVectorTrain array. 
for j = 1:imgTotalTrain
       img = readimage(imgStoreTraining, j);
       imgGray = rgb2gray(img);
       imgdouble = im2double(imgGray);
       imgVectorTrain = [imgVectorTrain, imgdouble(:)];
end

%%Fill imgVectorTest array.
for j = 1:imgTotalTest
       img = readimage(imgStoreTesting, j);
       imgGray = rgb2gray(img);
       imgdouble = im2double(imgGray);
       imgVectorTest = [imgVectorTest, imgdouble(:)];
end