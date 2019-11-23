% Test function 5  (Sekaj's objective function 1)
% It is a function of 3 variables with 2 local and 1 global optimum.
% The global optimum is:  xopt=[sx sy sz]
% for sx=7.777; sy=5.555; sz=0.111 -> Fit([7.777 5.555 0.111])=-8.7423
% -10 < x < 10

function[Fit]=testfn5(Pop)

[lpop,lstring]=size(Pop);
sx=7.777; sy=5.555; sz=0.111;	% coordinates of the global optimum
h=0.2;  % width of the peak around the global optimum
        % h<=0.1 -> hard problem, h>=0.5 -> no problem

for i=1:lpop
  x=Pop(i,1); y=Pop(i,2); z=Pop(i,3);
  Fit(i)=-(10*exp(-(x-sx)*(x-sx)/h-(y-sy)*(y-sy)/h-(z-sz)*(z-sz)/h)+0.02*(x-4)*(x-4)-0.05*y*y-0.01*z*z);
end;
