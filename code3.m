% Code to show how using hough transform fails in finding ellipse.

% constants
sensitivity=0.75;
lower_cutoff_radius=5;
higher_cutoff_radius=25;

% take image as input
RGB = imread('/home/hgkumbhare/ivp project/images/image3.jpg');
figure;
imshow(RGB);

% convert rgb to gray scale image
I = rgb2gray(RGB);
figure;
imshow(I);

% convert grayscale to binary image
T = adaptthresh(I, 0.55);
BW = imbinarize(I,T);
I=BW;
figure;
imshow(I);

% opening operation on image
se = strel('disk',7);
afterOpening = imopen(I,se);
figure
imshow(afterOpening,[]);

% edge detection
E = edge(afterOpening,'sobel');

% override some default parameters
params.minMajorAxis = 30;
params.maxMajorAxis = 70;
params.numBest=30;
params.minAspectRatio=0.4;
params.randomise=0;
params.ratationSpan=180;
params.smoothStddev = 1;

% note that the edge (or gradient) image is used
bestFits = ellipseDetection(E, params);
fprintf('Output %d best fits.\n', size(bestFits,1));
figure;
imshow(E);

% To show ellipse with circle of radius a
centers_selected=[];
radii_selected=[];
for i=1:size(bestFits,1)
    centers_selected=[centers_selected ; bestFits(i,1) bestFits(i,2)];
    radii_selected=[radii_selected ; max(bestFits(i,3),bestFits(i,4))];
end
    
h = viscircles(centers_selected,radii_selected);
