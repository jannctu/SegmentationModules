# SegmentationModules
Collection of Matlab snippets for Image Segmentation.


# Depth to HHA Representation 
Please refer to the original paper by [Sgupta](https://arxiv.org/abs/1407.5736) for more detail.  
Usage :
```matlab
HHA = saveHHA([], [], depth,depth);
```
![HHA Representation](https://raw.githubusercontent.com/jannctu/SegmentationModules/master/results/hha.png)

# Depth to Point Cloud & Normal 
Depth to Point Cloud by Liefeng Bo.   
Depth to Normal By [Sgupta](https://arxiv.org/abs/1407.5736).  
Visualization by me.   
Usage :
```matlab
%% PCd
pcd = DepthtoPoints(depth);
ptCloud = pointCloud(pcd);
ptCloud.Color = im;
sampledistance = 5;
[ HHANormal ] = normalfromhhacode( depth,depth );
[ hhafx,returnnormal ] = visualizeNormalMap(ptCloud,HHANormal,sampledistance );
```
![Normal Map](https://raw.githubusercontent.com/jannctu/SegmentationModules/master/results/normalmap.png)
![Color & Point Cloud & Normal](https://raw.githubusercontent.com/jannctu/SegmentationModules/master/results/normal3d.png)

# Countour Edge to UCM 
Please refer to the original UCM [paper](https://www2.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/resources.html)  
Usage :
```matlab
E = upsampleEdges(edge.EW);
S=bwlabel(E<mean(mean(edge.EW)),8); S=S(2:2:end,2:2:end)-1;
S(end,:)=S(end-1,:); S(:,end)=S(:,end-1);
E(end+1,:)=E(end,:); E(:,end+1)=E(:,end);
U=ucm_mean_pb(E,S); U=U(1:2:end-2,1:2:end-2);
figure; imshow(1-U,[]);
```
![UCM](https://raw.githubusercontent.com/jannctu/SegmentationModules/master/results/UCM.png)

# Statistical Region Merging 
Original paper by [R.Nock](https://ieeexplore.ieee.org/document/1335450)  
Original code [here](https://www.mathworks.com/matlabcentral/fileexchange/25619-image-segmentation-using-statistical-region-merging)  
Usage :
```matlab 
Qlevels=2.^(8:-1:0);
% This creates the following list of Qs [256 128 64 32 16 8 4 2 1]
% Creates 9 segmentations
[maps,images]=srm(double(im) ,Qlevels);
srm_plot_segmentation(images,maps);
```
![SRM Segmentation](https://raw.githubusercontent.com/jannctu/SegmentationModules/master/results/srm_label.png)
