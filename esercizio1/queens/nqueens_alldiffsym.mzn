% Combined alldifferent & symmetry breaking model

% alldiff model
include "alldifferent.mzn";
include "lex_lesseq.mzn";

int: n;
array [1..n] of var 1..n: X;

constraint alldifferent(X)::domain;
constraint alldifferent([ X[i]+i | i in 1..n])::domain;
constraint alldifferent([ X[i]-i | i in 1..n])::domain;

% Integration of the boolean model 
constraint symmetry_breaking_constraint(
let{
    array[1..n,1..n] of var bool: z;
} in 
    forall (i,j in 1..n)(z[i,j] <-> (X[i]=j))
/\ lex_lesseq(array1d(z), [ z[j,i] | i,j in 1..n ])
/\  lex_lesseq(array1d(z), [ z[i,j] | i in reverse(1..n), j in 1..n ])
/\  lex_lesseq(array1d(z), [ z[j,i] | i in 1..n, j in reverse(1..n) ])
/\  lex_lesseq(array1d(z), [ z[i,j] | i in 1..n, j in reverse(1..n) ])
/\  lex_lesseq(array1d(z), [ z[j,i] | i in reverse(1..n), j in 1..n ])
/\  lex_lesseq(array1d(z), [ z[i,j] | i,j in reverse(1..n) ])
/\  lex_lesseq(array1d(z), [ z[j,i] | i,j in reverse(1..n) ])
);

% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;

