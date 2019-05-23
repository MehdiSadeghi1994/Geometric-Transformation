
%% This Script read Your image and transform to one image and return
%The First Image is a Base Image and another Image are Transform Image
clc
clear all
close all
%%Read Base Images
[Name_1 path_1] = uigetfile({'*.*'},'Select Your Base Image');
Image_1 = imread([path_1 Name_1]);
Image=zeros(size(Image_1 , 1) , size(Image_1 , 2) , 3);
req=1;
while(req)
    
    [Name_2 path_2] = uigetfile({'*.*'}, 'Select Your Image to Transform');
    Image_2 = imread([path_2 Name_2]);
    [Orginal,Final] = cpselect(Image_2,Image_1,'Wait', true);
    choice = questdlg('Wiche Kind of Interpolation?', ...
        'choice Interpolation', ...
        'Bilinear','Nearest neighbor','Nearest neighbor');
    switch choice
        case 'Bilinear'
            disp([choice ' Interpolation Selected'])
            Int = 1;
        case 'Nearest neighbor'
            disp([choice ' Interpolation Selected'])
            Int = 0;
    end
    
    
    x=Final(:,2);
    y=Final(:,1);
    % AZ_X=X;
    Z_X=zeros(1,4);
    F=[x y x.*y ones(4,1)];
    Z_X= F\Orginal(:,2);
    %AZ_Y=Y
    Z_Y=zeros(1,4);
    F=[x y x.*y ones(4,1)];
    Z_Y= F\Orginal(:,1);
    
    if Int==1
        for i = 1 : size(Image_1,1)
            for j = 1 : size(Image_1,2)
                xs = (Z_X(1)*i + Z_X(2)*j + Z_X(3)*i*j + Z_X(4)) ;
                ys = (Z_Y(1)*i + Z_Y(2)*j + Z_Y(3)*i*j + Z_Y(4)) ;
                
                if xs<1 || xs>size(Image_2,2) || ys<1 || ys>size(Image_2,1)
                    continue;
                end
                Image(i,j,1)  = Bilinearinter( [floor(xs) ceil(xs)] , [floor(ys) ceil(ys)] ...
                    , [Image_2(floor(xs),floor(ys),1) Image_2(floor(xs),ceil(ys),1)...
                    Image_2(ceil(xs),floor(ys),1) Image_2(ceil(xs),ceil(ys),1)] , [xs ys]);
                
                Image(i,j,2)  = Bilinearinter( [floor(xs) ceil(xs)],[floor(ys) ceil(ys)]...
                    ,[Image_2(floor(xs),floor(ys),2) Image_2(floor(xs),ceil(ys),2)...
                    Image_2(ceil(xs),floor(ys),2) Image_2(ceil(xs),ceil(ys),2)],[xs ys]);
                
                Image(i,j,3)  = Bilinearinter( [floor(xs) ceil(xs)],[floor(ys) ceil(ys)]...
                    ,[Image_2(floor(xs),floor(ys),3) Image_2(floor(xs),ceil(ys),3)...
                    Image_2(ceil(xs),floor(ys),3) Image_2(ceil(xs),ceil(ys),3)],[xs ys]);
            end
        end
    else
        
        for i = 1 : size(Image_1,1)
            for j = 1 : size(Image_1,2)
                xs = round(Z_X(1)*i + Z_X(2)*j + Z_X(3)*i*j + Z_X(4)) ;
                ys = round(Z_Y(1)*i + Z_Y(2)*j + Z_Y(3)*i*j + Z_Y(4)) ;
                
                if xs<1 || xs>size(Image_2,2) || ys<1 || ys>size(Image_2,1)
                    continue;
                end
                Image(i,j,:)=Image_2(xs,ys,:);
            end
        end
        
    end
    Image = uint8(Image);
    imshow(Image)
    
    
    choice = questdlg('Do You Want to Continue?', ...
        'Check', ...
        'Yes','No thank you','Yes');
    % Handle response
    switch choice
        case 'Yes'
            disp([choice ' coming right up.'])
            req = 1;
        case 'No thank you'
            disp('Thank you for your trust :)')
            req = 0;
    end
end





