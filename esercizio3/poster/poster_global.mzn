% include "19x19.dzn";
% include "20x20.dzn";
include "alldifferent.mzn";
include "diffn.mzn";

 
par int: n; %number of posters
par int: w; %width of paper
par int: h; %height of paper

array[1..n] of par int: ws; %widths of posters
array[1..n] of par int: hs; %heights of posters

array [1..n] of var 0..w-1: xpos; % x coordinate
array [1..n] of var 0..h-1: ypos; % y coordinate

% constraint to not go outside the paper horizontally
constraint forall(i in 1..n)(xpos[i] + ws[i] <= w);

% constraint to not go outside the paper vertically
constraint forall(i in 1..n)(ypos[i] + hs[i] <= h);

% no overlapping global constraint
constraint diffn(xpos, ypos, ws, hs);

%to concatenate x and y arrays
array[1..2*n] of var int: all_vars;
constraint forall (i in 1..n)((all_vars[2*i-1] = xpos[i])/\(all_vars[2*i] = ypos[i]));

%input order – min value
%solve :: int_search(all_vars, input_order, indomain_min) satisfy;

%input order – random value
solve :: int_search(all_vars, input_order, indomain_random) satisfy;

% smallest domain – min value
% solve :: int_search(all_vars, first_fail, indomain_min) satisfy;

%smallest domain – random value
% solve :: int_search(all_vars, first_fail, indomain_random) satisfy;

%domWdeg – min value
% solve :: int_search(all_vars, dom_w_deg, indomain_min) satisfy;

%domWdeg – random value
%solve :: int_search(all_vars, dom_w_deg, indomain_random) satisfy;


