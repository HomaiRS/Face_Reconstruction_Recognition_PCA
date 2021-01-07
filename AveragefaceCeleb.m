function [aveMer,aveMes,aveOba,aveEma,aveNol,aveWhit] = AveragefaceCeleb(imgTensor)
    aveMer = sum(imgTensor(:,:,1:6),3)*(1/6);   aveMes = sum(imgTensor(:,:,7:12),3)*(1/6);
    aveOba = sum(imgTensor(:,:,13:18),3)*(1/6); aveEma = sum(imgTensor(:,:,19:24),3)*(1/6);
    aveNol = sum(imgTensor(:,:,25:30),3)*(1/6); aveWhit = sum(imgTensor(:,:,31:36),3)*(1/6);
    
    figure(2)
    subplot(2,3,1), pcolor(flipud(aveMer)),shading interp,colormap(gray); title('Angela Merkel','fontsize',15)
    subplot(2,3,2), pcolor(flipud(aveMes)),shading interp,colormap(gray); title('Lionel Messi','fontsize',15)
    subplot(2,3,3), pcolor(flipud(aveOba)),shading interp,colormap(gray); title('Barack Obama','fontsize',15)
    subplot(2,3,4), pcolor(flipud(aveEma)),shading interp,colormap(gray); title('Emma Watson','fontsize',15)
    subplot(2,3,5), pcolor(flipud(aveNol)),shading interp,colormap(gray); title('Christopher Nolan','fontsize',15)
    subplot(2,3,6), pcolor(flipud(aveWhit)),shading interp,colormap(gray); title('Whitney Houston','fontsize',15)
end
