include "alldifferent.mzn";
include "ide/vis.mzn";

int: N;
array[1..N,1..N] of 0..N: start;
array[1..N,1..N] of var 1..N: x;


% fill initial board
constraint forall(i,j in 1..N)(if start[i,j] > 0 then x[i,j] = start[i,j] else true endif );
    
% All different in rows 
constraint forall (i in 1..N) (alldifferent([ x[i,j] | j in 1..N ])) :: domain_propagation; 

% All different in columns.
constraint forall (j in 1..N) (alldifferent([ x[i,j] | i in 1..N ])) :: domain_propagation; 

% default search
% solve satisfy;

% domWdeg – random value 
% solve :: int_search(x, dom_w_deg, indomain_random) satisfy;

% domWdeg – random value + restarting
solve :: int_search(x, dom_w_deg, indomain_random) :: restart_luby(250) satisfy;

% output vis_geost_2d([(1, 1) | i in 1..N*N], %rect_size
%                     [(-1, -1) | i in 1..N*N], %rect_offset
%                     [{k|k in 1..N} | i,j in 1..N], %shape
%                     [(i,j) | i,j in 1..N], %x
%                     [x[i,j] | i,j in 1..N]); %kind



