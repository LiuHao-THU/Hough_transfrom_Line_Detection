%% Load  image

A = imread('test1.jpg');
A = A(:,660:1330);
img = A;  % already grayscale
%% Find edges
img = img(:,:,1);
figure();
subplot(121);
imshow(img);
title('Original Image');
gaussianFilter = fspecial('gaussian',20, 10);
img_filted = imfilter(img, gaussianFilter,'symmetric');
subplot(122);
imshow(img_filted);
title('Filted Image');
filted_edges = edge(img_filted, 'sobel');
figure();
subplot(121);
imshow(filted_edges);
title('Edges found in filted image');
img_edges = edge(double(img), 'sobel');
subplot(122);
imshow(img_edges);
title('Edges found in original image')
% Since the original image here does not have any noise,
% so it is not necessary to use Gaussian filter to decrease the noise
% first. And actually, using Gaussian filter first in this case will
% result in a worse edge image
% imwrite(img_filted, fullfile('output', 'ps1-3-a-1.png'));  % save as output/ps1-1-a-1.png
% imwrite(filted_edges, fullfile('output', 'ps1-3-b-1.png')); 
% imwrite(img_edges, fullfile('output', 'ps1-3-b-2.png')); 
%% Perform Hough Transform for lines


[H,H1, theta, rho] = hough_lines_acc(img_edges); 

%% Plot/show accumulator array H
figure();
imshow(imadjust(mat2gray(H1)),'XData',theta,'YData',rho,...
      'InitialMagnification','fit');
title('Hough transform');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot);
%% Find Peaks
peaks = hough_peaks(H, H1,50); 
%% Highlight peak locations on accumulator array
imshow(imadjust(mat2gray(H)),'XData',theta,'YData',rho,'InitialMagnification','fit');
title('Hough transform with peaks found');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(theta(peaks(:,2)),rho(peaks(:,1)),'o','LineWidth',3,'color','red');
%% Draw Lines
hough_lines_draw(img, peaks,rho,theta);

% % %% Find Circles (Use hough transform for circles)
% % [centers, radii] = find_circles(filted_edges, [1,20]);
% % hough_circles_draw(img, centers, radii);