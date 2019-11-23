% Test function 7 (Travelling salesman problem, I Sekaj 8/2001 )
% search for the shortest way between points in the 2-D grid defined in coordinates matrix c
% the solution is the optimal combination of integers
% containing the values between 1 and 25 -> optimal order of cities defined in c
% opt: [1 2 3 4 5 10 9 8 7 6 11 12 13 14 15 20 19 18 17 16 21 22 23 24 25], etc.
% Fit(opt)=24
%============================================

function[Fit]=testfn7(Pop)

[lpop,lstring]=size(Pop);

c=[1 1 1 1 1 2 2 2 2  2  3  3  3  3  3  4  4  4  4  4  5  5  5  5  5;
   1 2 3 4 5 1 2 3 4  5  1  2  3  4  5  1  2  3  4  5  1  2  3  4  5];	% coordinates of cities
%  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25    order number of the cities

% fitness - prejdena draha
for j=1:lpop
  r=Pop(j,:);
  d=0;
  for i=1:(lstring-1)
    d=d+sqrt((c(1,r(i))-c(1,r(i+1)))^2+(c(2,r(i))-c(2,r(i+1)))^2);
  end;
  Fit(j)=d;
end;

