%p3150127 Anna Noukou
%p3150062 Vasileios Karampelas

I=imread('C:\Users\Anna\Desktop\coins005.tif');
%I=imresize(I, 0.5);

%Make it gray
I=rgb2gray(I);

%Apply gauss to reduce noise 
gaussianFilter = fspecial('gaussian', [10 10], 2);
img = imfilter(I, gaussianFilter,'replicate');

%Edge enhancement
img = edge(img, 'Sobel');

imshow(img);

disp('Please wait while we are processing the image');
disp('...');

%Find Circles (Use Hough Transform)
[centers, radii] = find_circles(img, [37.25, 52]);

%Remove overlapped circles
[centersNew,radiiNew] = RemoveOverLap(centers,radii,3);

%Draw
hough_circles_draw(I, centersNew, radiiNew);


%Total coins calculation
sumOf2s=0;
sumOf1s=0;
sumOf50s=0;
sumOf10s=0;

for i = 1 : size(radiiNew)     
        if(radiiNew(i) > 50.6)
          sumOf2s++;
        elseif(radiiNew(i) > 46.30)
          sumOf50s++;
        elseif(radiiNew(i) > 42.35)
          sumOf1s++;
        else
          sumOf10s++;
        endif          
end

fprintf('The number of 2 euro is %d\n', sumOf2s );
fprintf('The number of 1 euro is %d\n', sumOf1s );
fprintf('The number of 50 cent is %d\n', sumOf50s );
fprintf('The number of 10 cent is %d\n', sumOf10s );
