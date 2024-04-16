include "global_cardinality.mzn";
int: n;
array[1..n] of var 0..n-1: x;


% meta constraint
% constraint forall(i in 0..n-1)(x[i] == sum([x[j] == i | j in 0..n-1]));
% constraint forall(i in 0..n-1)(x[i] == count(x, i));

constraint global_cardinality(x, [i | i in 0..n-1], x);

solve satisfy;

output [ "x = \(x);\n" ] ;