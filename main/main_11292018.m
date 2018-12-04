clear all; close all; clc
%% load modules
addpath('../modules/configs');
addpath('../modules/utils');
addpath('../modules/params');
addpath('../modules/fillupregion');
addpath('../modules/ucmsp');
%% INITIAL CONFIGS
datapaths = configPaths();
ID = 'img_5001'; % filename
instanceData =  loadInstance(datapaths,ID); 
cmap = randomcolormap();
kernelparams = lowpasskernels();

LowPassDepth = imfilter(instanceData.depth ,kernelparams.lowpasskernel1,'same'); 
%% CANNY ON SPWEIGHT
canny1 = edge(instanceData.spweight,'canny');
canny2 = bwperim(canny1,8);
canny3 = imdilate(canny2, strel('disk',2));

cannylabel = bwlabeln(~canny3);
%figure; imshow(label2rgb(lll,cmap));
%  SMOOTING THE CANNY LABEL
[ z ] = normalized1d( LowPassDepth,255 );
zzz = cat(3,z,z,z);
[edges, tmp, neighbors, tmpLabImg, avg_seg_colors, ...
     polyfragments, poly_params] = seg2fragments(double(cannylabel), zzz, 100,5,cmap);
cannylabelfinal = tmpLabImg;
bdry = seg2bdry(tmpLabImg);
%figure; imshow(bdry);
%result = tmpLabImg; 
%result(find(bdry)) = 0;
%figure; imshow(label2rgb(tmpLabImg,cmap));

%% SOBEL ON SPWEIGHT
sobel1 = edge(instanceData.spweight,'sobel');
sobel2 = bwperim(sobel1,8);
sobel3 = imdilate(sobel2, strel('disk',1));
CC = bwconncomp(sobel3);
n =  length(CC.PixelIdxList);

newlabel =  zeros(CC.ImageSize);
for i=1:n
    pxlidlist = CC.PixelIdxList{i};
    if length(pxlidlist) > 200
        newlabel(pxlidlist) = 1;
    end
end
%figure; imshow(sobel3);
figure; imshow(newlabel);

%% NORMAL MAP
addpath('../modules/mynormalmap');
opt = params();
[rows,cols] = size(z);
%% convert depth to meter
real_depth = double(z) .* opt.depth_to_z;
%% PCd
pcd = DepthtoPoints(real_depth);
ptCloud = pointCloud(pcd);
%[g density normals] = compute_gradient(z,real_depth,pcd,opt);
addpath(genpath('../modules/hha'));
[ normals ] = normalfromhhacode( instanceData.depth,instanceData.depth );
%normals = pcnormals(ptCloud,6);

% x = ptCloud.Location(1:10:end,1:10:end,1);
% y = ptCloud.Location(1:10:end,1:10:end,2);
% z = ptCloud.Location(1:10:end,1:10:end,3);
% u = normals(1:10:end,1:10:end,1);
% v = normals(1:10:end,1:10:end,2);
% w = normals(1:10:end,1:10:end,3);
% 
% sensorCenter = [0,-0.3,0.3]; 
% for k = 1 : numel(x)
%    p1 = sensorCenter - [x(k),y(k),z(k)];
%    p2 = [u(k),v(k),w(k)];
%    % Flip the normal vector if it is not pointing towards the sensor.
%    angle = atan2(norm(cross(p1,p2)),p1*p2');
%    if angle > pi/2 || angle < -pi/2
%        u(k) = -u(k);
%        v(k) = -v(k);
%        w(k) = -w(k);
%    end
% end
% 
% figure
% pcshow(ptCloud)
% title('Adjusted Normals of Point Cloud')
% hold on
% quiver3(x, y, z, u, v, w);
% hold off

%% compute gradient and density
%[g density norm] = compute_gradient(z,real_depth,pcd,opt);
norm2 = imfilter(normals ,kernelparams.lowpasskernel1,'same'); % FILTER THE DEPTH
%figure; imshow(norm2);

addpath('../modules/srm');

%% GENERATE PLANAR BASED ON NORMAL MAP
% Choose different scales
% Segmentation parameter Q; Q small few segments, Q large may segments
Qlevels=2.^(8:-1:0);
% This creates the following list of Qs [256 128 64 32 16 8 4 2 1]
% Creates 9 segmentations
%% SRM FOR PLANAR INFORMATION
%[maps,images]=srm(norm2 .* 100.0,Qlevels);
[maps,images]=srm(norm2 .*100 ,Qlevels);
% And plot them
%srm_plot_segmentation(images,maps);
ygdipakai = remap_index(maps{3});
ygdipakai = imresize(ygdipakai(20:405,20:540),[425 560],'nearest');
ygdipakai(1:2,:) = 0;
ygdipakai(:,1:2) = 0;
ygdipakai(:,558:560) = 0;
ygdipakai(423:425,:) = 0;
bdrynormal = seg2bdry(ygdipakai);
%figure; imshow(bdrynormal);
%figure; imshow(label2rgb(ygdipakai,cmap));


[edges, tmp, neighbors, tmpLabImg, avg_seg_colors, ...
     polyfragments, poly_params] = seg2fragments(double(ygdipakai), norm2, opt.min_size1,5,cmap);
normalsegfinal = tmpLabImg;
bdrynormalfinal = seg2bdry(tmpLabImg);
normalsegfinal2 =normalsegfinal;
normalsegfinal2(find(bdrynormalfinal)) = 0;
figure; imshow(label2rgb(normalsegfinal2,cmap));

%% UNION 
unionedge = bdrynormalfinal;
unionedge(find(bdry)) = 1;
%  SMOOTING THE CANNY LABEL
%figure; imshow(label2rgb(tmpLabImg,cmap));
%figure; imshow(unionedge,[]);
unionedgelabel = bwlabeln(~unionedge);
%figure; imshow(label2rgb(unionedgelabel,cmap));

[edges, tmp, neighbors, tmpLabImg, avg_seg_colors, ...
     polyfragments, poly_params] = seg2fragments(double(unionedgelabel), norm2, opt.min_size2,5,cmap);
bdrynya = seg2bdry(tmpLabImg);
tmpLabImg(find(bdrynya)) = 0;
%figure; imshow(label2rgb(tmpLabImg,cmap));
%figure; imshow(label2rgb(tmpLabImg,cmap));
%% UNION with sobel
tmpLabImg(find(newlabel)) = 0;
%figure; imshow(label2rgb(tmpLabImg,cmap));

[edges, tmp, neighbors, tmpLabImg, avg_seg_colors, ...
     polyfragments, poly_params] = seg2fragments(double(tmpLabImg), instanceData.hha, opt.min_size2,5,cmap);
bdryunionwithsobel = seg2bdry(tmpLabImg);
tmpLabImg(find(bdryunionwithsobel)) = 0;
%figure; imshow(label2rgb(tmpLabImg,cmap));
bdrylast = seg2bdry(tmpLabImg);
labellast = bwlabeln(~bdrylast);
[edges, tmp, neighbors, tmpLabImg, avg_seg_colors, ...
     polyfragments, poly_params] = seg2fragments(double(labellast), instanceData.hha, opt.min_size2,5,cmap);
%tmpLabImg(find(bdryunionwithsobel)) = 0;
%figure; imshow(label2rgb(tmpLabImg,cmap));

%[fx] = vizlabel( tmpLabImg, cmap );

bdrynormal2 = bwperim(bdrynormal,8);
bdrynormal3 = imdilate(bdrynormal2, strel('disk',1));


%initlabel = tmpLabImg;
initlabel = normalsegfinal;
%initlabel = cannylabelfinal;
%==============================
addpath('../modules/myregionmerging');
% 
% %[ fx ] = check2regs( tmpLabImg,3,11,cmap );
% boundstart = 0;
% bound = length(unique(initlabel));
% myfx = figure; 
% % newlabel = seg2bdry(instanceData.gt);
% % newlabel = bwperim(newlabel,8);
% % newlabel = imdilate(newlabel, strel('disk',2));
% while (bound ~= boundstart )
% %while (bound > 31 )
%     boundstart = bound;
%     nb = calc_neighbours(initlabel);
%     [ aff ] = aff1d( initlabel,instanceData.depth,nb );
%     %     if(bound==122)
%     %         bound
%     %     end
%     %initlabel = mergemindist( aff,initlabel,newlabel,opt);
%     initlabel = mergemindist( aff,initlabel,bdrynormal3,opt );
%     bound = length(unique(initlabel))
%     vizlabel = initlabel;
%     %vizlabel(find(newlabel)) = 0;
%     vizlabel(find(bdrynormal3)) = 0;
%     figure(myfx);imshow(label2rgb(vizlabel,cmap));
% end
% %initlabel(find(seg2bdry(initlabel))) = 0;
% figure;imshow(label2rgb(initlabel,cmap));
%==============================
boundstart2 = 0;
bound2 = length(unique(initlabel));
%[left bottom width height]
%myfx2 = figure; 
%set(myfx2, 'Position', [200 300 560 425]);

newlabel = bwperim(newlabel,8);
newlabel = imdilate(newlabel, strel('disk',5));

%while (bound2 > opt.numberregions )
while (bound2 ~= boundstart2 )
    boundstart2 = bound2;
    nb2 = calc_neighbours(initlabel);
    [ aff2 ] = aff1d( initlabel,instanceData.depth,nb2 );
    %     if(bound==122)
    %         bound
    %     end
    initlabel = mergemindist( aff2,initlabel,newlabel,opt);
    %initlabel = mergemindist( aff,initlabel,bdrynormal3,opt );
    bound2 = length(unique(initlabel))
    %vizlabel2 = initlabel;
    %vizlabel2(find(newlabel)) = 0;
    %vizlabel(find(bdrynormal3)) = 0;
    %figure(myfx2);imshow(label2rgb(vizlabel2,cmap));
end
%initlabel(find(seg2bdry(initlabel))) = 0;
figure;imshow(label2rgb(initlabel,cmap));


[edges, tmp, neighbors, tmpLabImg, avg_seg_colors, ...
     polyfragments, poly_params] = seg2fragments(double(initlabel), norm2, opt.min_size2,5,cmap);

tmpLabImg(find(seg2bdry(tmpLabImg))) = 0;
figure;imshow(label2rgb(tmpLabImg,cmap));
 % E = upsampleEdges(instanceData.edge);
% S=bwlabel(E==0,8); S=S(2:2:end,2:2:end)-1;
% S(end,:)=S(end-1,:); S(:,end)=S(:,end-1);
% E(end+1,:)=E(end,:); E(:,end+1)=E(:,end);
% U=ucm_mean_pb(E,S); U=U(1:2:end-2,1:2:end-2);
% figure; imshow(U,[]);
% figure; imshow(instanceData.im);
% addpath('../modules/myregionmerging');
% opt.sensitivityMerging = 0.9; %  0 ~ 1
% opt.minSize = 0.9;
% 
% [labels]=myregion_merging(instanceData.im,tmpLabImg,opt);
% figure; imshow(label2rgb(labels,cmap));