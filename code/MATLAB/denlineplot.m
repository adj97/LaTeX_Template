function denlineplot(x,y,col)

    mapping = jet(100);

    colvec=zeros(length(col),3);
    LWidth = zeros(length(col),1);
    
    % length(x)=length(col)+1
    
    hold on
    for index=1:length(col)
        
        colvec(index,:) = mapping(ceil(col(index)*100),:);
        LWidth(index) = col(index)*4;
        
        if (length(col) == 99)
            LWidth(index) = 3;
        end
        
        plot(x(index:index+1),y(index:index+1),...
            'color',colvec(index,:),...
            'LineWidth',LWidth(index))
    end
    hold off


end
