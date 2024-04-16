int: n;
array[0..n-1] of var 0..n-1: x;
 
 
% meta constraint
constraint forall(i in 0..n-1)(x[i]== sum([x[j] == i | j in 0..n-1]));

solve satisfy;

output [ "x = \(x);\n" ] ;