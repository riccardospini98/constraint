% include "19x19.dzn";
% include "20x20.dzn";
include "alldifferent.mzn";
include "diffn.mzn";

 
par int: n; %number of posters
par int: w; %width of paper
par int: h; %height of paper

array[1..n] of par int: ws; %widths of posters
array[1..n] of par int: hs; %heights of posters

array [1..n] of var 0..w-1: xpos;
array [1..n] of var 0..h-1: ypos;

constraint forall(i in 1..n)(xpos[i] + ws[i] <= w);
constraint forall(i in 1..n)(ypos[i] + hs[i] <= h);

constraint diffn (xpos, ypos, ws, hs);

solve satisfy;

