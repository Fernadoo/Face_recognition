function [ Accuracy ] = SRBFR( numTrainee, path )%path=.../CroppedYale
%SRBFR Summary of this function goes here
%   Detailed explanation goes here
    [train_m,F]=readin(numTrainee, path);
    %average_face=mean(train_m,2);
    [COEFF,SCORE,LATENT]=PCA(train_m');
    score=COEFF'*train_m;
    %score=SCORE;
    for i=1:size(score,2)
        score(:,i)=score(:,i)/norm(score(:,i));
    end
    parent_path=strcat(path,'/yale*');%.../CoppedYale/yale*
    parent_file=dir(parent_path);%a list of yaleBxx
    %a1=randi([1,length(parent_file)]);
    correct=0;
    total=0;
    for i=1:length(parent_file)
        kid_path=strcat(path,'/',parent_file(i).name);%.../CoppedYale/yaleBxx
    	search_path=strcat(kid_path,'/','*.pgm');%.../CoppedYale/yaleBxx/*.pgm
        kid_file=dir(search_path);%a list of xxx.pgm
        %a2=randi([1,length(kid_file)]);
        for j=1:length(kid_file)
            testpath=strcat(kid_path,'/',kid_file(j).name);%.../CoppedYale/yaleBxx/xxx.pgm
            %testpath
            testim=double(histeq(imread(testpath),64));
            if ismember(testpath,F)==1%exclude
                continue
            else
                if size(testim,1)*size(testim,2)==32256
                    total=total+1;
                    %[i,j]
                    y_=reshape(testim,32256,1);
                    %y_=y_-average_face;
                    y=COEFF'*y_;
                    y=y./norm(y);
                    %y
                    %size(COEFF)
                    %size(y_)
                    %size(SCORE)
                    init_x=zeros(numTrainee*length(parent_file),1);
                    x=feature_sign(score,y,0.01,init_x);
                    %x
                    %erro=y-SCORE*x;
                    %[Min,ind]=min(abs(erro));
                    [Max,ind]=max(x);
                    position=ceil(ind/numTrainee);
                    resultpath=strcat(path,'/',parent_file(position).name);%.../CroppedYale/yaleBxx
                    if resultpath==kid_path
                        correct=correct+1;
                        %imshow(resultpath)

                    end
                else
                    continue
                end
            end 
        end
    end
    %Accuracy=correct/(length(parent_file)*length(kid_file));
    Accuracy=correct/total;
    %correct
    %total
    return
end