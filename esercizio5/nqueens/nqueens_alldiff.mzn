% Alldifferent model

include "alldifferent.mzn";
include "gecode.mzn";
include "ide/vis.mzn";

int: n = 50; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)
var int: dist_from_diagonal = sum(i in 1..n)(abs(q[i] - i));

% Column attack and Diagonal attack constraints using the alldifferent constraint
% Append ::domain to the end. 
constraint alldifferent(q)::domain;
constraint alldifferent([q[i]+i|i in 1..n])::domain;
constraint alldifferent([q[i]-i|i in 1..n])::domain;

% Search for all solutions, using N = 50

% default search
% solve minimize dist_from_diagonal;

% domWdeg – random value
% solve :: int_search(q, dom_w_deg, indomain_random) minimize dist_from_diagonal;

% domWdeg – random value + restart
% solve :: int_search(q, dom_w_deg, indomain_random)
%       :: restart_luby(250) minimize dist_from_diagonal;
      
% domWdeg – random value + restart + lns
% solve :: int_search(q, dom_w_deg, indomain_random)
%       :: restart_luby(250)
%       :: relax_and_reconstruct(q, 85) minimize dist_from_diagonal;
        

output ["q = \(q)\n",
        "obj = \(dist_from_diagonal)"];
        
% Graphical representation of solutions
% output vis_geost_2d([(1, 1) | i, j in 1..n], %rect_size
%                     [(-1, -1) | i,j in 1..n], %rect_offset
%                     [{0,1,2} | i in 1..n], %shape
%                     [(i,j) | i,j in 1..n], %x
%                     [if q[i] = j then 2 else if i = j then 3 else 1 endif endif| i,j in 1..n]); %kind
