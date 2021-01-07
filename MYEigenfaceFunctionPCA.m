function MYEigenfaceFunctionPCA()
%   csvread('filenamesw.csv')
%     FileNames = xlsread("train_list.xlsx"); 
    FileNames = xlsread("ChilephotoIDLabel.xlsx"); 
    FileNames = FileNames(:,2);
    Recognize=2661;
    FileNames = datasample(FileNames,16,'Replace',false); find(FileNames==Recognize)
    TrainImgMx = zeros(length(FileNames),16384);

    %% ReadING images and plotting some images in the train set
    for i=1:length(FileNames) %4100:5900
        fid = fopen(['rawdata/' num2str(FileNames(i))]); 
%             fid = fopen(['rawdata/' num2str(i)]); 
        TrainIm= fread(fid); 
        TrainImgMx(i,:) = TrainIm'; % each row of TrainImgMx is a Gamma(i)
        TrainImgMx(i,:)= TrainImgMx(i,:)/max(TrainImgMx(i,:));
    end
        
    %% ----------------------------------- subtracting the mean face from the faces (Centering)
    psyVect = (sum(TrainImgMx))*(1/size(TrainImgMx,1)); % mean of Train Images
    phiMx = TrainImgMx -  psyVect;  phiMx = phiMx';
    figure(2), imagesc(reshape(psyVect, 128, 128)'); 
    colormap(gray(256)); 
    title('Average face','fontsize',20); 
    
    %% ----------------------------------- Cov(phi) 
    C = (1/size(phiMx,2)) * (phiMx * phiMx'); close all
    
    %% ----------------------------------- 
    Eigenspace(C,phiMx,4,4,16); % subplotRow,subplotCol,EigNumber
    
    %% ----------------------------------- Recognition
    MyKNN1Recognition(C,TrainImgMx,phiMx,psyVect,Recognize,FileNames,25)
    
    %% ----------------------------------- Reconstruction
    myReconstruction(C,phiMx,psyVect,TrainImgMx)
end


