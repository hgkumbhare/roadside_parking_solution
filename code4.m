% To detect empty slots when camera is at any angle

% constants
threshold_for_binary_image=190;

% take image as input
RGB = imread('/home/hgkumbhare/ivp project/images/image4.jpg');
figure;
imshow(RGB);

% convert rgb to gray scale image
I = rgb2gray(RGB);
figure;
imshow(I)

% convert grayscale to binary image
I=I>threshold_for_binary_image;
figure;
imshow(I);

% opening operation on image
se = strel('square',7);
afterOpening = imopen(I,se);
figure
imshow(afterOpening);

% any coordinates of circles for each parking slot
a=[461 365;116 139;394 89];
bestFits=myEllipse(afterOpening,a)

% to display empty parking slots
centers_selected=[];
radii_selected=[];
for i=1:size(bestFits,1)
    centers_selected=[centers_selected ; bestFits(i,1) bestFits(i,2)];
    radii_selected=[radii_selected ; 10];
end
    
h = viscircles(centers_selected,radii_selected);
