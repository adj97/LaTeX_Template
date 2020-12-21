function drawCircle(r)
    theta=0:0.01:2*pi;
    
    x=r*cos(theta);
    y=r*sin(theta);
    
    hold on
    plot(x,y,'k')
    hold off
end
