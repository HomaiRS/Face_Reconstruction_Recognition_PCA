function MyKNN1Recognition(C,TrnMx,Phi, Psy,NewImageID,FileNames, EigNumber)
    fid = fopen(['rawdata/' num2str(NewImageID)]); 
    newImg= fread(fid); newImage =newImg;
%     [Ull,landa] = eigs(C,EigNumber,'lm'); Ull=normalize(Ull);
%     figure(10), imagesc(Phi), colorbar, title('Phi - 16384*16','fontsize',16)
%     figure(20), imagesc(landa), colorbar, title('\Lambda: Eigenvalues of \Phi - 16*16','fontsize',16)
%     figure(30), imagesc(Ull), colorbar, title('U - Eigenvector of \Phi - 16384*16','fontsize',16)
    
    L = (Phi'*Phi); %(1/size(Phi,2))*
    [U,S,Vl] = svd(L);
%     figure(50), imagesc(L), colorbar, title('L - 16*16','fontsize',16)
%     figure(100), imagesc(U), colorbar, title('U - 16*16','fontsize',16)
%     figure(200), imagesc(S), colorbar, title('S - 16*16','fontsize',16)
%     figure(300), imagesc(Vl), colorbar, title('V^T - 16*16','fontsize',16)
% %     [Vl,land] = eigs(L,15,'lm'); % For comparison
   
    % normalize vectors first
    Ul = Phi*Vl';  %Ul=normalize(Ul);%% Phi(A)*V are eigenvectors of the AA'
%     figure(31), imagesc(Ul), colorbar, title('U - Reconstructed Eigenvector of \Phi - 16384*16','fontsize',16)
    
    newImg = newImg' - Psy;
    newImg = (Ul'*newImg'); %* Ul' ; 
    figure(100), distance = zeros(size(TrnMx,1),2);
    for i=1:size(TrnMx,1)
        %%------ Homai curiousity: What Kutz suggests:
%         ProjImgToV = (Vl * Ul(i,:)');% * Ul';
        %%------ Homai curiousity: What Eigenface paper suggests:
        ProjImgToV = (Ul' * Phi(:,i));% * Ul';
        distance(i,1) = (norm(newImg-ProjImgToV,'fro')/norm(newImg,'fro'));
        plot(i,distance(i,1),':'), hold on
        scatter(i,distance(i,1),'filled','r'), hold on
        distance(i,2) =i;
    end
    
    xlabel('Image index','fontsize',13); ylabel('Error percentage','fontsize',13); box on
    title('Distance of projection of face images from a new image'),set(gca,'fontsize',14), hold off

    figure(104)
    [newImRecog,Idx] = sort(distance(:,1));
    
    subplot(2,2,1)
    imagesc(reshape(newImage, 128, 128)'); colormap(gray(256)); 
    title(['Original - new image: ' num2str(NewImageID)],'fontsize',15); 
    
    subplot(2,2,2)
    newImg = Ul * newImg;
    imagesc(reshape(newImg, 128, 128)'); colormap(gray(256)); 
    title(['Projection - new image: ' num2str(NewImageID)],'fontsize',15); 
    
    subplot(2,2,3)
    fid = fopen(['rawdata/' num2str(FileNames(Idx(1)))]); recogedimg = fread(fid);
    imagesc(reshape(recogedimg, 128, 128)'); colormap(gray(256)); 
    title(['Original - closest image is: ' num2str(FileNames(Idx(1)))],'fontsize',15); 
    
    subplot(2,2,4)
    recogedimg = recogedimg' - Psy;
    recogedimg =  Ul * (Ul'*recogedimg');%(recogedimg' * Ul) * Ul' ; 
    imagesc(reshape(recogedimg, 128, 128)'); colormap(gray(256)); 
    title(['Projection - closest image is: ' num2str(FileNames(Idx(1)))],'fontsize',15); 
end