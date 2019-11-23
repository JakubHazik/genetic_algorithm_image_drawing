% load('resultWorkspace500.mat');
gen = pop(1,:);

% compare images
figure(20);
subplot(1,3,1);
original = imread('fotoCustom.jpg');
% imageSizeY= 200;
% imageSizeX = 200;
original = imresize(original, [imageSizeY imageSizeX]);
imshow(original)
subplot(1,3,2);
img = drawGAImage(gen, imageSizeX, imageSizeY, circlesNum);
imshow(img)
subplot(1,3,3);
diff = imabsdiff(original, img);
imshow(diff)

% vykreslenie fitness
figure(11);
hold off;
plot(1:generationsNum, course);
legend
hold on;
xlabel('Pocet vyhodnoteni');
ylabel('Funkcna hodnota');
title('Graf zobrazujuci pokles fitness funkcie');