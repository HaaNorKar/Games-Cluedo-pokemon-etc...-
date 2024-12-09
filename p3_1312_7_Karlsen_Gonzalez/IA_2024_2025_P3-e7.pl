/***************
*
* Autores: Daniel Cabrero, Havard Karlsen
*
* Grupo: 1312_02
*
****************/

/***************
* EJERCICIO 7 (1p). Librería clpb
*
* La librería CLP(B) (ver https://www.swi-prolog.org/pldoc/man?section=clpb)
* permite resolver problemas combinatorios con restricciones.
*
* A continuación se os da la solución al siguiente problema resuelto con esta librería:
* Tenemos a 3 sospechosos de un robo, Alice (A), Bob (B) y Carl (C).
* Al menos uno de ellos es culpable. Condiciones:
* Si A es culpable, tiene exactamente 1 cómplice.
* Si B es culpable, tiene exactamente 2 cómplices.
* ¿Quién es culpable?
*
****************/

:- use_module(library(clpb)).

solve(A,B,C) :-
 % Hay al menos un culpable
 sat(A + B + C),
 % Si A es culpable, tiene exactamente 1 cómplice.
 sat(A =< B # C),
 % Si B es culpable, tiene exactamente 2 cómplices.
 sat(B =< A * C),
 % Asigna valores a las variables de manera que se satisfagan todas las restricciones.
 labeling([A,B,C]).


% 1. Plantea una solución a este problema con un predicado solution/3
%    que sea equivalente a la encontrada por la librería.
%    Confirma, en concreto, que los predicados devuelven lo mismo para las mismas entradas.

%hay al menos un culpable.
solution(A,B,C):- A=1.
solution(A,B,C):- B=1.
solution(A,B,C):- C=1.
%si A es culpable, tiene exactamente 1 cómplice.
solution(A,B,C):- A=1, B=1, C=0.
%si B es culpable, tiene exáctamente 2 complices
solution(A,B,C):- B=1, A=1, C=1.

% 2. Discute las ventajas e inconvenientes entre la solución encontrada y el uso de la librería.

%ventajas: mas compacto y eficiente respecto a memoria
%desventajas: se requiere de un buen conocimiento del funcionamiento de la biblioteca para usarla


/***************
* EJERCICIO 7 (1p). Librería clpb
* This exercise uses Prolog's CLP(B) library to solve a combinatorial problem involving suspects and logical constraints.
* The constraints specify conditions about three suspects, and our goal is to determine who is guilty based on these conditions.
***************/

:- use_module(library(clpb)).

% Define the problem using Boolean constraints.
% A = 1 means Alice is guilty, B = 1 means Bob is guilty, and C = 1 means Carl is guilty.

solve_guilt([A, B, C]) :-
    sat(A + B + C),           % At least one of Alice, Bob, or Carl is guilty
    sat(~A + B),                % If Alice is guilty, then Bob must be guilty
    sat(~B + C),                % If Bob is guilty, then Carl must be guilty
    labeling([A, B, C]).          % Find a solution that satisfies all constraints

/***************
* Example Queries:
* 1. Who is guilty? -> solve_guilt([A, B, C]).
*    Explanation: This returns all combinations of suspects satisfying the constraints.
*    If A=1, Alice is guilty; B=1 indicates Bob's guilt; and C=1, Carl's guilt.
***************/
