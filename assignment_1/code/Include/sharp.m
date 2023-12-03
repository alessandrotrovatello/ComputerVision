%Get the Sharpened image by summing Original Image
%and its Details moltiplied by an constant 'a'

function new_in = sharp(IN,detail,a)
    new_in = double(IN) + a*(detail);
    b = a*3; 
    major_a = double(IN) + b*(detail);

    figure()
    subplot(2,2,1)
    imagesc(IN)
    title('Original image')
    colormap gray

    subplot(2,2,2)
    imagesc(detail)
    title('Image details')
    colormap gray
    
    subplot(2,2,3)
    imagesc(new_in)
    title(['Image sharpened with a: ',num2str(a)])
    colormap gray
    %imagefilename="Report_Images/a"; % To save images
    %print(imagefilename,'-dpng');

    subplot(2,2,4)
    imagesc(major_a)
    title(['Image sharpened with a: ',num2str(b)])
    colormap gray
    %imagefilename="Report_Images/major_a"; % To save images
    %print(imagefilename,'-dpng');

    sgtitle('Original + a*Details = Sharpened')
end