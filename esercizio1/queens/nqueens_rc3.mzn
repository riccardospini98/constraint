% First combined row and column model

include "alldifferent.mzn";
include "inverse.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: X; % Variables for queens on the rows
array [1..n] of var 1..n: Y; % Variables for queens on the columns


% Diagonal attack constraints from both models
constraint forall(i,j in 1..n where i<j) (abs(X[i] - X[j]) != abs(i-j));

% Channeling constraint
constraint inverse(X,Y);                  

% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;