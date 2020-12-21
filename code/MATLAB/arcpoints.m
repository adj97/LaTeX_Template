function [x,y] = arcpoints(A,B,curv,npoints) 
   d = norm(B-A);
   R = d/2+curv; % Choose R radius >= d/2
   C = (B+A)/2+sqrt(R^2-d^2/4)/d*[0,-1;1,0]*(B-A); % Center of circle
   a = atan2(A(2)-C(2),A(1)-C(1));
   b = atan2(B(2)-C(2),B(1)-C(1));
   b = mod(b-a,2*pi)+a; % Ensure that arc moves counterclockwise
   t = linspace(a,b,npoints);
   x = C(1)+R*cos(t);
   y = C(2)+R*sin(t);
end

