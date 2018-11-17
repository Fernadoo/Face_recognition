function [ COEFF, SCORE, LATENT ] = PCA( X )
%PCA Summary of this function goes here
%   Detailed explanation goes here
    [r,c]=size(X);
    av_f=mean(X,1);
    Center=X-repmat(av_f,r,1);
    [u,s,v]=svd(Center,'econ');
    COEFF=v;
    SCORE=u*s;
    LATENT=diag(s'*s)/(size(s,2)-1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%-----95%-------
%      total_L=sum(LATENT);
%      l=0;
%      for i=1:length(LATENT)
%          if  l<0.95*total_L
%               l=l+LATENT(i); 
%          else
%              minrow=i;
%              break
%          end
%      end
%      COEFF=COEFF(:,1:minrow);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     V_selected=V(:,mincol:size(L,2));
%     L_selected=L(mincol:size(L,2),mincol:size(L,2));
    return
end