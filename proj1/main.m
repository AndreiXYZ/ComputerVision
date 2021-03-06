%% Set random seed to make our experiments reproductible and load vlfeat library
rng(42);
% Linux path(Andrei and Stefan)
run('./vlfeat-0.9.21/toolbox/vl_setup');

% Dragos path(windows)
%run('C:/Program Files/MATLAB/R2018b/vlfeat-0.9.21-bin/toolbox/vl_setup')

% Traian path(windows)
%run('D:/MscAI/2nd Semester 1st Period/Computer Vision 1/ComputerVision/proj1/vlfeat-0.9.21/toolbox/vl_setup');

%% Remove unwanted classes from dataset, convert to opponent and save result to disk.Only need to run once
remove_classes();
color_conversion();

%% Extract sift features and save them to disk. Only need to run once. Takes some time
extraction = {'keypoints','dense'};
colorspace = {'grayscale','rgb','opp'};
vocabulary_features = [];
train_features = [];
test_features = [];
for e=1:length(extraction)
    for c=1:length(colorspace)
        feature = feature_extraction(extraction{e},colorspace{c});
        vocabulary_features = [vocabulary_features; struct('extraction',extraction{e},'colorspace',colorspace{c},'feature',feature)]; 
                
    end    
end
save('stl10_matlab/vocabulary_features.mat', 'vocabulary_features');

%% Load vocabulary features 
load('stl10_matlab/vocabulary_features.mat')

%% Run kmeans. The cluster centroids will represent our vocabulary. Only need to run once. This run takes some time
K = [400,1000,4000];
centroids = [];
for k=1:length(K)
    for f=1:length(vocabulary_features)        
        [centroid,~] = vl_kmeans(vocabulary_features(f).feature', K(k),'Algorithm','Elkan');        
        centroids = [centroids; struct('extraction',vocabulary_features(f).extraction,...
                                       'colorspace',vocabulary_features(f).colorspace,...
                                       'k',K(k), 'centroid',centroid')];
    end  
end
save('stl10_matlab/centroids.mat', 'centroids');

%% Load centroids
load('stl10_matlab/centroids.mat');

%% Build bag of visual words train histograms. Only need to run once. Takes some time
train_histograms = [];

for c=1:length(centroids)    
    histogram = create_histograms(centroids(c),'train');
    train_histograms = [train_histograms; struct('extraction',centroids(c).extraction,...
                                         'colorspace',centroids(c).colorspace,...
                                         'k',centroids(c).k, 'histogram',histogram)];                                     
     
end
save('stl10_matlab/train_histograms.mat', 'train_histograms');

%% Compute test histograms. Only need to run once. This takes some time
test_histograms = [];
for c=1:length(centroids)    
    histogram = create_histograms(centroids(c),'test');
    test_histograms = [test_histograms; struct('extraction',centroids(c).extraction,...
                                         'colorspace',centroids(c).colorspace,...
                                         'k',centroids(c).k, 'histogram',histogram)];
    
     
end
save('stl10_matlab/test_histograms.mat', 'test_histograms');

%% Load train histograms and labels
load('stl10_matlab/train_histograms.mat');
load('stl10_matlab/train_curated.mat');

%% Train SVM. Need to run only once
Get training labels
y = y_train(length(y_train)/2+1:end);
models = [];
for h=1:length(train_histograms)
    model = training_SVM(train_histograms(h).histogram,y);
    models = [models; struct('extraction',train_histograms(h).extraction,...
                                          'colorspace',train_histograms(h).colorspace,...
                                          'k',train_histograms(h).k, 'model',model)];
    
    
end
save('stl10_matlab/models.mat', 'models');

%% Load models, test histograms and labels
load('stl10_matlab/models.mat');
load('stl10_matlab/test_histograms.mat');
load('stl10_matlab/test_curated.mat');

%% Classification, ranking, top5 and bottom5 lists. Need to run once
scores = [];
rankings = [];
top5 = [];
bottom5 = [];
for h=1:length(test_histograms)
    score = classification(test_histograms(h).histogram,y_test,models(h).model);
    [ranking, t5, b5] = ranking_lists(score,y_test);
    scores = [scores; struct('extraction',test_histograms(h).extraction,...
                                           'colorspace',test_histograms(h).colorspace,...
                                           'k',test_histograms(h).k, 'score',score)];
    
    rankings = [rankings; struct('extraction',test_histograms(h).extraction,...
                                           'colorspace',test_histograms(h).colorspace,...
                                           'k',test_histograms(h).k, 'ranking',ranking)];
                                       
    top5 = [top5; struct('extraction',test_histograms(h).extraction,...
                                           'colorspace',test_histograms(h).colorspace,...
                                           'k',test_histograms(h).k, 'images',t5)];
                                       
    bottom5 = [bottom5; struct('extraction',test_histograms(h).extraction,...
                                           'colorspace',test_histograms(h).colorspace,...
                                           'k',test_histograms(h).k, 'images',b5)];
   
end
save('stl10_matlab/rankings.mat', 'rankings');
save('stl10_matlab/top5.mat', 'top5');
save('stl10_matlab/bottom5.mat', 'bottom5');

%% Load rankings
load('stl10_matlab/rankings.mat');

%% Get MAPs. Need to be run once
maps = [];
for r=1:length(rankings)
    [map,mean_map] = getMap(rankings(r).ranking);
    maps = [maps; struct('extraction',rankings(r).extraction,...
                                           'colorspace',rankings(r).colorspace,...
                                           'k',rankings(r).k, 'map',map,'mean',mean_map)];
    
    
end
save('stl10_matlab/maps.mat', 'maps');

%% Load MAPs
load('stl10_matlab/maps.mat');
load('stl10_matlab/top5.mat');
load('stl10_matlab/bottom5.mat');










