a1=1; % element 1 cross-sectional area, m^2
a2=1; % element 2 cross-sectional area, m^2
e1=1; % Young's modulus element 1, Pa
e2=1; % Young's modulus element 2, Pa
l1=1; % element 1 length, m
l2=1; % element 2 length, m
p2=1; % applied external force at node 2, N
p3=1; % applied external force at node 3, N
%  global stiffness matrix 
c1=e1*a1/l1; % element 1
c2=e2*a2/l2; % element 2
kg=[ c1,    0,  -c1;
     0,   c2,  -c2; 
   -c1,  -c2,   c1+c2]
%  global force matrix
fg=[ 0;
     p2;
     p3];
% apply elimination approach to find
% reduced matrices
kg_reduced=kg([2 3], [2 3]);
fg_reduced=fg([2,3]);
% solve for global displacements
q_reduced=inv(kg_reduced)*fg_reduced
% B matrix
B1=1/l1*[-1 1];
B2=1/l2*[-1 1];
% use connectivity to make local q matrices
% remember that our q now is reduced and only 
% holds values of our unknown displacements
% the q matrix now has components q=[q_node2 q_node3]
%
% global  1   2    3
q_global =   [0 q_reduced(1) q_reduced(2)]'
q_element1 = [0    q_reduced(2)]' 
q_element2 = [q_reduced(2) q_reduced(1)]'
% strain and stress in element 1
epp1=B1*q_element1
sig1=e1*epp1
% strain and stress in element 2
epp2=B2*q_element2
sig2=e2*epp2
% reaction force at node 1
%applied force at node 1
f1=0;
R1=kg(:,1)'*q_global-f1


