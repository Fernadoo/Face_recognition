function [X,Cell]=readin( numTrainee, path)%path=.../CroppedYale
    totalpath=strcat(path,'/yale*');%.../CroppedYale/yale*
    totalfile=dir(totalpath);%a list of 'yaleBxx'
    X=[];
    Cell={};
    %F=zeros(length(totalfile),numTrainee);
    for j=1:length(totalfile)
        impath=strcat(path,'/',totalfile(j).name,'/*.pgm');%.../CroppedYale/YaleBxx/*.pgm
        filename=dir(impath);%a list of 'xxxx.pgm'
        a=[];
        [r,c]=size(a);
        while c<numTrainee
            index=randi([1,length(filename)]);
            abspath=strcat(path,'/',totalfile(j).name,'/',filename(index).name);%.../CroppedYale/yaleBxx/xxx.pgm
            %abspath
            im_init=imread(abspath);
            im=double(histeq(im_init,64));
            %im=imread(abspath);
            %imshow(im)
            [m,n]=size(im);
            row=m*n;
            if row==32256
                readin=reshape(im,row,1);
                a=[a,readin];
                Cell=[Cell,abspath];
            else
                continue
            end
            [r,c]=size(a);
        end
        X=[X,a];
    end
return
