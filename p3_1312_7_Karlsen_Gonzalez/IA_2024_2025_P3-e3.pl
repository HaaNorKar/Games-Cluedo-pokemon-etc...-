/***************
*
* Autores: Daniel Cabrero, Havard Karlsen
*
* Grupo: 1312_07
*
****************/

/***************
* EJERCICIO 3 (1p). Cluedo
*
* Alguien ha cometido un terrible asesinato en la mansión. Hemos podido
* reunir algunas pruebas y pistas sobre los diferentes habitantes de la casa,
* los lugares en los que han estado y las posibles armas que han portado.
* Esto es posible gracias a los predicados fact/3, que relaciona a una persona
* con un lugar y una hora, y hint/3, que relaciona a una persona con un arma
* y una hora.
*
****************/

fact(amapola, salon, 10).
fact(amapola, cocina, 12).
fact(amapola, comedor, 14).

fact(rubio, billar, 10).
fact(rubio, biblioteca, 12).

fact(blanco, cocina, 12).

fact(prado, biblioteca, 9).

fact(celeste, billar, 11).
fact(celeste, escaleras, 13).

fact(mora, biblioteca, 10).
fact(mora, terraza, 12).

hint(amapola, cuchillo, 10).
hint(amapola, tuberia, 12).

hint(rubio, cuchillo, 10).
hint(rubio, tuberia, 10).
hint(rubio, pistola, 9).

hint(blanco, cuchillo, 13).

hint(prado, cuchillo, 10).

hint(celeste, candelabro, 10).
hint(celeste, tuberia, 11).

hint(mora, pistola, 11).

%si hay pistas y relacciones de una misma persona con el arma y la habitacion la persona es sospechosa
suspect(X, H, A):- fact(X, H, HO), hint(X, A, HO).

%si la persona mas sospechosa y que estaba en la habitacion sospechosa a la hora del asesinato es la culpable
guilty(X, H, A, T):-suspect(X, H, A), Z is T-10, Z=0.
% 1) Crea un método suspect/3 que devuelva true si la persona X estuvo
% en la habitación H y empuñó el arma A. Utilízalo para averiguar
% los sospechosos de un crimen cometido en la biblioteca con el cuchillo.

% 2) Crea un método guilty/4 para obtener la persona X entre los sospechosos
% que es más probable que cometiera el crimen en la habitación H, usando
% el arma A y a la hora T. Ten en cuenta que, quizá, no se cumplen todas las
% restricciones a la vez (de ahí que se pida el más probable).
%
% Utilízalo para averiguar el/los culpable/s del crimen
% cometido en la biblioteca con el cuchillo a las 10.

/***************
* EJERCICIO 3 (1p). Cluedo
* In this exercise, we analyze clues to determine the culprit in a Cluedo-style mystery.
* Facts and hints provide information on where individuals were located and the weapons they were seen with.
* By combining this information, we deduce who committed the crime.
***************/

% Facts and hints: Provide evidence on the suspect, their location, and the weapon used.
% fact(Person, Place, Time) indicates where the Person was at a given Time.
% hint(Person, Weapon, Time) indicates the Weapon that a Person had at a given Time.

fact(mr_green, kitchen, morning).
fact(colonel_mustard, ballroom, morning).
fact(ms_scarlet, kitchen, evening).

hint(mr_green, knife, morning).
hint(colonel_mustard, candlestick, morning).
hint(ms_scarlet, revolver, evening).

% Predicate to determine if a person could be the culprit
% The culprit is identified if they were in the room where the crime occurred and had a weapon.

culprit(Person) :-
    fact(Person, kitchen, evening),   % Person was in the kitchen in the evening, where the crime happened
    hint(Person, Weapon, evening),    % Person had a weapon in the evening
    Weapon \= none.                   % Ensure the weapon was present

/***************
* Example Queries:
* 1. Who is the culprit? -> culprit(Culprit).
*    This query identifies the culprit based on being in the kitchen in the evening with a weapon.
***************/