function classification()
    FileNamesSmil=["1225","1226","1227","1259","1260","1262","1263","1264","1265","1266","1236","1235","1234","1237","1238","1239","1240"];
    FileNamesSerious=["1224","1230","1244","1242","1243","1244","1245","1247","1248","1249","1250","1251","1252","1253","1254","1255","1257","1258"];

    TrainImgMx = zeros(length(FileNames),16384);
    figure(1)   
    %% I read images and subplot my train set
        for i=1:length(FileNames)
            fid = fopen(['rawdata/' num2str(FileNames(i))]); 
            TrainIm= fread(fid); 
            TrainImgMx(i,:) = TrainIm'; % each row of TrainImgMx is a Gamma(i)
        end
    %% ----------------------------------- subtracting the mean face from the faces
        psyVect = (sum(TrainImgMx))*(1/size(TrainImgMx,1)); % mean of Train Images
        for i=1:size(TrainImgMx,1), phiMx(i,:) = TrainImgMx(i,:) -  psyVect; end
        phiMx = phiMx'; PhiMxtranspos = phiMx';
        figure(2), imagesc(reshape(psyVect, 128, 128)'); colormap(gray(256)); title('Average face','fontsize',20); 
    %% ----------------------------------- Cov(phi) 
        C = zeros(size(phiMx,1),size(phiMx,1));
        for i=1:size(phiMx,2)
            C = phiMx(:,i) * PhiMxtranspos(i,:) + C;    
        end
        C = C * (1/size(phiMx,2));
    %% -----------------------------------
     [V,landa] = eigs(C,3,'lm');
     for i=1:length(FileNamesSmil)
         projsmail3D(i,:) = (phiMx(:,i)' * V) * V' + psyVect;
     end
     
end