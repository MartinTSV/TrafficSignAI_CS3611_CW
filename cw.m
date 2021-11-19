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
%%Transposing to row. 
imgMatrixTrain = imgMatrixTrain';


%%Fill imgVectorTest array.
for j = 1:imgTotalTest
       img = readimage(imgStoreTesting, j);
       imgGray = rgb2gray(img);
       imgdouble = im2double(imgGray);
       imgMatrixTest = [imgMatrixTest, imgdouble(:)];
end
%%Transposing to row. 
imgMatrixTest = imgMatrixTest';

%%Model Training Section 
model = fitcknn(imgMatrixTrain, labelsTrain);
predictions = predict(model, imgMatrixTest);


%%Find accuracy of model
counter = 0; 
for j = 1:height(predictions)
    if(predictions(j) == labelsTest(j)) counter = counter + 1; end
end

accuracy = (counter/height(labelsTest));

%%Bar Chart for accuracy. 
figure('name', 'Accuracy Bar Chart');
barchart = bar(accuracy);
%%Change name if testing a different model. 
model = 'K-Nearest Neighbour';
set(gca, 'xticklabel', model); 
text(1:length(accuracy), accuracy, num2str(accuracy'), 'vert', 'bottom', 'horiz', 'center'); 
%%Confusion Chart
figure('name', 'Confusion Chart');
dconfusionch =  confusionchart(labelsTest,predictions, 'RowSummary', 'row-normalized');