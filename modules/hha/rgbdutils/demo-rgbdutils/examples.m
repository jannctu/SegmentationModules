% dt = load('depth000056.png');
I=imread('depth000056.png');
z = fillHoles(I, 'bwdist');
z = z./10;
param = getNYUCamera(1);
[a, b] = wrapperComputeNormals(double(z), isnan(dt.dmap),  3, 1, param.K);
imagesc((a+1)/2);
