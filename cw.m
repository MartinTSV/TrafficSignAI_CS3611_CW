%%Storing Training Images
imgStoreTraining = imageDatastore('TrafficSignData\Train', 'IncludeSubfolders', 1, 'LabelSource', 'foldernames');
%%Storing Testing Images
imgStoreTesting = imageDatastore('TrafficSignData\Test', 'IncludeSubfolders', 1, 'LabelSource', 'foldernames');

imgTotalTrain = length(imgStoreTraining.Files);
imgTotalTest = length(imgStoreTesting.Files);

labelsTrain = countEachLabel(imgStoreTraining);
labelsTest = countEachLabel(imgStoreTesting);

%%Empty vector for storing matlab formatted images. 
imgMatrixTrain = [];
imgMatrixTest = [];
newVector = [];

%%Fill imgVectorTrain array. 
for j = 1:imgTotalTrain
       img = readimage(imgStoreTraining, j);
       imgGray = rgb2gray(img);
       imgdouble = im2double(imgGray);
       imgMatrixTrain = [imgMatrixTrain, imgdouble(:)];
end

%%Fill imgVectorTest array.
for j = 1:imgTotalTest
       img = readimage(imgStoreTesting, j);
       imgGray = rgb2gray(img);
       imgdouble = im2double(imgGray);
       imgMatrixTest = [imgMatrixTest, imgdouble(:)];
end

labelsTrainLoop = labelsTrain.Label;
for j = 1:height(labelsTrain)
    for k = 1:labelsTrain{j,2}
        newVector(end+1) = labelsTrainLoop(1);
    end
end
    
%%dicriminantmodel = fitcdiscr(imgMatrixTrain, imgMatrixTrain)
