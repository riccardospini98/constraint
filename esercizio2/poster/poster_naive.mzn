% include "19x19.dzn";
% include "20x20.dzn";
include "alldifferent.mzn";

 
par int: n; %number of posters
par int: w; %width of paper
par int: h; %height of paper

array[1..n] of par int: ws; %widths of posters
array[1..n] of par int: hs; %heights of posters

array [1..n] of var 0..w-1: xpos;
array [1..n] of var 0..h-1: ypos;

constraint forall(i in 1..n)(xpos[i] + ws[i] <= w);
constraint forall(i in 1..n)(ypos[i] + hs[i] <= h);


% constraint forall(i,j in 1..n)(forall(x1, y1 in 1..n))
constraint forall(i,j in 1..n where i < j)(xpos[i] + ws[i] <= xpos[j] \/ xpos[j] + ws[j]<= xpos[i] \/ ypos[j] >= ypos[i] + hs[i] \/ ypos[j] + hs[j] <= ypos[i]);


solve satisfy;

