function kernelparams = lowpasskernels()
    kernelparams.lowpasskernel1 = fspecial('gaussian',[5,5],2); % LOW PASS FILTER 1
    kernelparams.lowpasskernel2 = fspecial('gaussian',[10,10],9); % LOW PASS FILTER 2
end