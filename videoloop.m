close all;clear all;clc;
vid = videoinput('winvideo', 1, 'RGB24_320x240');
start(vid);
preview(vid); 

for ctr = 1:20
   original = getsnapshot(vid);

    img = original;
    gris = rgb2gray(original);

    %se saca el canal deseado
    rojo = img(:,:,3); %canal rojo
    img_rojo = cat(1,rojo);

    resta = img_rojo - gris;
    resta = resta *3;
    bin = im2bw(resta, 0.2);

    %erosion
    ele = strel('disk', 5);
    bin = imerode(bin, ele);
    %dilatacion
    ele2 = strel('disk', 34); 
    bin = imdilate(bin, ele2);
    %erosion 2
    ele3 = strel('disk', 29);
    bin = imerode(bin, ele3);

    bin = imclearborder(bin); %se limpian los bordes
    
    [B, L] = bwboundaries(bin, 'noholes');
    prop = regionprops(L, 'all'); %propiedads
    imshow(original);
    
    hold on
    for n=1:size(prop,1)
        rectangle('Position', prop(n).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 2);
        x = prop(n).Centroid(1);
        y = prop(n).Centroid(2);
        plot(x,y,'*');
    end
   pause(1);
end


stop(vid);
close(vid);
delete(vid);