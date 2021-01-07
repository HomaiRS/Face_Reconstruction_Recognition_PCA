function CelebImageReader()
%% I read images and subplot them as train set
    for i=1:36
%         subplot_tight(6,6,i,[0.04,0.04])
        TrainIm =  imresize(double(rgb2gray(imread(['Celebritie_pics/' num2str(i) '.jpg']))),[80 60]);
        imgTensor(:,:,i) = TrainIm;
        TrainImgMx(i,:) = reshape(TrainIm,1,80*60); % each row of TrainImgMx is a Gamma(i)
%         figure(1),pcolor(flipud(TrainIm)),shading interp,colormap(gray)
%         title(['pic' num2str(i)],'fontsize',14); 
    end
%     AveragefaceCeleb(imgTensor)
    D = TrainImgMx; 
    psyVect = (sum(TrainImgMx))*(1/size(TrainImgMx,1));
    figure(3), imagesc(reshape(psyVect, 80, 60)); colormap(gray(256)); title('Average face','fontsize',20); 
    
%     phi = D-psyVect; L = (phi')*(phi); size(L)
    A=D'*D;
    [V,landa] = eigs(A,200,'lm'); figure(4);
    %%----------------------------------- Eigenspace
    for i=1: 8
        subplot_tight(3,3,i,[0.04,0.04]), 
        face1 = reshape(V(:,i),80,60); pcolor(flipud(face1)), shading interp, colormap(gray),set(gca,'Xtick',[],'Ytick',[]); 
        title(['Eigenvector ' num2str(i)],'fontsize',14)
    end
    subplot_tight(3,3,9,[0.04,0.04]),  semilogy(diag(landa),'ko','linewidth',2), title('Eigenvalues of Cov(\phi)','fontsize',14)
    %%----------------------------------- Classification using average face
%     close all
    [aveMer,aveMes,aveOba,aveEma,aveNol,aveWhit] = AveragefaceCeleb(imgTensor);
    vecMer = reshape(aveMer,1,80*60); vecMes = reshape(aveMes,1,80*60);
    vecOba = reshape(aveOba,1,80*60); vecEma = reshape(aveEma,1,80*60);
    vecNol = reshape(aveNol,1,80*60); vecWhit = reshape(aveWhit,1,80*60);

    ProjMer = vecMer*V; ProjMes = vecMes*V; ProjOba = vecOba*V; 
    ProjEma = vecEma*V; ProjNol = vecNol*V; ProjWhit = vecWhit*V; 
    
    figure(5); subplot_tight(2,3,1,[0.04,0.04]), bar(ProjMer(2:20)), set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]); 
    text(12,-1700,'Angela Merkel','fontsize',15)
    subplot_tight(2,3,2,[0.04,0.04]), bar(ProjMes(2:20)), set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]); 
    text(12,-1700,'Lionel Messi','fontsize',15)
    subplot_tight(2,3,3,[0.04,0.04]), bar(ProjOba(2:20)), set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]); 
    text(12,-1700,'Barack Obama','fontsize',15)
    subplot_tight(2,3,4,[0.04,0.04]), bar(ProjEma(2:20)), set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]); 
    text(12,-1700,'Emma Watson','fontsize',15)
    subplot_tight(2,3,5,[0.04,0.04]), bar(ProjNol(2:20)), set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]); 
    text(12,-1700,'Christopher Nolan','fontsize',15)
    subplot_tight(2,3,6,[0.04,0.04]), bar(ProjWhit(2:20)), set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]); 
    text(12,-1700,'Whitney Houston','fontsize',15)
    %%-----------------------------------
    close all
    T0 = imresize(double(rgb2gray(imread('Celebritie_pics/33.jpg'))),[80 60]); 
    T1 = imresize(double(rgb2gray(imread('Celebritie_pics/whitneyTest.jpg'))),[80 60]); 
    T2 = imresize(double(rgb2gray(imread('Celebritie_pics/BeyonceTest.jpg'))),[80 60]);
    T3 = imresize(double(rgb2gray(imread('Celebritie_pics/MariahCareyTest.jpg'))),[80 60]);
    
    vecT0 = reshape(T0,1,80*60); vecT1 = reshape(T1,1,80*60); vecT2 = reshape(T2,1,80*60); vecT3 = reshape(T3,1,80*60); 
    ProjT0 = vecT0*V; ProjT1 = vecT1*V; ProjT2 = vecT2*V; ProjT3 = vecT3*V;
    
    function [errTj] = error(Tj,recT,Tensor,n)
        for i=1:6 
            errReconTj(i) = norm(recT- Tensor(:,:,n+i),'fro')/norm(Tensor(:,:,n+i),'fro'); 
            errTj(i) = norm(Tj- Tensor(:,:,n+i),'fro')/norm(Tensor(:,:,n+i),'fro'); 
        end
%         errTj=[errTj',errReconTj'];
          errTj = errReconTj;
    end
    reconT0 = (V*ProjT0')'; recT0 = reshape(reconT0,80,60); [errT0] = error(T0,recT0,imgTensor,30); 
    reconT1 = (V*ProjT1')'; recT1 = reshape(reconT1,80,60); [errT1] = error(T1,recT1,imgTensor,30); 
    reconT2 = (V*ProjT2')'; recT2 = reshape(reconT2,80,60); [errT2] = error(T2,recT2,imgTensor,30); 
    reconT3 = (V*ProjT3')'; recT3 = reshape(reconT3,80,60); [errT3] = error(T3,recT3,imgTensor,30); 
    
    subplot(4,4,1), pcolor(flipud(T0)),shading interp,colormap(gray); title('subject 6: T_0','fontsize',14)
    subplot(4,4,2), bar(ProjT0(2:20)), set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]); title('Projection','fontsize',14)
    subplot(4,4,3), pcolor(flipud(recT0)),shading interp,colormap(gray); title('Reconstruction','fontsize',14)
    subplot(4,4,4), bar(errT0); title('projection','fontsize',14); %legend('Original','Reconstruction');  %set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]);
    
    subplot(4,4,5), pcolor(flipud(T1)),shading interp,colormap(gray); title('New picure of subject 6: T_1','fontsize',14)
    subplot(4,4,6), bar(ProjT1(2:20)), set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]); title('Projection','fontsize',14)
    subplot(4,4,7), pcolor(flipud(recT1)),shading interp,colormap(gray); title('Reconstruction','fontsize',14)
    subplot(4,4,8), bar(errT1); title('projection','fontsize',14);  %legend('Original','Reconstruction');  %set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]);
    
    subplot(4,4,9), pcolor(flipud(T2)),shading interp,colormap(gray); title('New picure: T_2','fontsize',14)
    subplot(4,4,10), bar(ProjT2(2:20)), set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]); title('Projection','fontsize',14)
    subplot(4,4,11), pcolor(flipud(recT2)),shading interp,colormap(gray); title('Reconstruction','fontsize',14)
    subplot(4,4,12), bar(errT2); legend('Original','Reconstruction'); title('projection','fontsize',14)
   
    subplot(4,4,13), pcolor(flipud(T3)),shading interp,colormap(gray); title('New picure: T_3','fontsize',14)
    subplot(4,4,14), bar(ProjT3(2:20)), set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]); title('Projection','fontsize',14)
    subplot(4,4,15), pcolor(flipud(recT3)),shading interp,colormap(gray); title('Reconstruction','fontsize',14)
    subplot(4,4,16), bar(errT3); title('Projection','fontsize',14)
    %%--------- My image: :)
    THoma = imresize(double(rgb2gray(imread('Celebritie_pics/0.jpg'))),[80 60]); 
    vecTHoma = reshape(THoma,1,80*60);  ProjTHoma = vecTHoma*V;
    reconTHoma = (V*ProjTHoma')'; recTHoma = reshape(reconTHoma,80,60); 
    [errTHomaMer] = error(THoma,recTHoma,imgTensor,0); [errTHomaMes] = error(THoma,recTHoma,imgTensor,6);
    [errTHomaOba] = error(THoma,recTHoma,imgTensor,12); [errTHomaEma] = error(THoma,recTHoma,imgTensor,18);
    [errTHomaNol] = error(THoma,recTHoma,imgTensor,24); [errTHomaWhit] = error(THoma,recTHoma,imgTensor,30);
    labels={'Angela Merkel','Lionel Messi','Barack Obama','Emma Watson','Christopher Nolan','Whitney Houston'};
   
    figure(20),
    subplot(2,6,1:2), pcolor(flipud(THoma)),shading interp,colormap(gray); title('Me','fontsize',14)
    subplot(2,6,3:4), bar(ProjTHoma(2:20)), set(gca,'Xlim',[0 20], 'Ylim',[-2000 2000],'Xtick',[],'Ytick',[]); title('Projection','fontsize',14)
    subplot(2,6,5:6), pcolor(flipud(recTHoma)),shading interp,colormap(gray); title('Reconstruction','fontsize',14)
    subplot(2,6,7), bar(errTHomaMer); title(labels{1},'fontsize',14)
    subplot(2,6,8), bar(errTHomaMes); title(labels{2},'fontsize',14)
    subplot(2,6,9), bar(errTHomaOba); title(labels{3},'fontsize',14)
    subplot(2,6,10), bar(errTHomaEma); title(labels{4},'fontsize',14)
    subplot(2,6,11), bar(errTHomaNol); title(labels{5},'fontsize',14)
    subplot(2,6,12), bar(errTHomaWhit); title(labels{6},'fontsize',14)

    figure(300),scatter(1:length(errTHomaMer),errTHomaMer,'c'), hold on; plot(1:length(errTHomaMer),errTHomaMer,':c','linewidth',1.5)
    scatter(1:length(errTHomaMes),errTHomaMes,'r'), plot(1:length(errTHomaMes),errTHomaMes,':r','linewidth',1.5)
    scatter(1:length(errTHomaOba),errTHomaOba,'b'), plot(1:length(errTHomaOba),errTHomaOba,':b','linewidth',1.5)
    scatter(1:length(errTHomaEma),errTHomaEma,'g'), plot(1:length(errTHomaEma),errTHomaEma,':g','linewidth',1.5)
    scatter(1:length(errTHomaNol),errTHomaNol,'k'), plot(1:length(errTHomaNol),errTHomaNol,':k','linewidth',1.5)
    scatter(1:length(errTHomaWhit),errTHomaWhit,'m'); plot(1:length(errTHomaWhit),errTHomaWhit,':m','linewidth',1.5)
    legend('1','Angela Merkel','2','Lionel Messi','3','Barack Obama','4','Emma Watson','5','Christopher Nolan','6','Whitney Houston')
    set(gca,'fontsize',14);box on
end