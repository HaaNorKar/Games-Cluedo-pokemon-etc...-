/***************
*
* Autores: Daniel Cabrero, Havard Karlsen
*
* Grupo: 1312_07
*
****************/

/***************
* EJERCICIO 5 (2p). Sistema de recomendación
*
* Los sistemas de recomendación permiten ofrecer productos a usuarios en base a sus preferencias.
* En este ejercicio, utilizaremos varios criterios para producir recomendaciones
* de acuerdo a la información almacenada en una base de conocimiento.
*
****************/

% Partimos de la siguiente base de conocimiento, que define distintos atributos de los productos
precio(museo_prado, 20).
precio(puerta_sol, 0).
precio(los_pilares_de_la_tierra, 15).

categoria(puerta_sol, madrid).
categoria(museo_prado, madrid).
categoria(los_pilares_de_la_tierra, novela).

autor(puerta_sol, jose_rodriguez).
autor(museo_prado, jose_monino).
autor(los_pilares_de_la_tierra, ken_follet).

anyo(puerta_sol, 1478).
anyo(museo_prado, 1819).
anyo(los_pilares_de_la_tierra, 1989).


% y preferencias de los usuarios
pref_prod(juan, museo_prado).
pref_prod(miguel, museo_prado).
pref_prod(manuel, museo_prado).
pref_prod(miguel, puerta_sol).
pref_prod(manuel, puerta_sol).

pref_precio(juan, Precio) :- Precio < 10.
pref_precio(paco, Precio) :- Precio < 40.
pref_precio(miguel, Precio) :- Precio < 50.
pref_precio(manuel, Precio) :- Precio < 20.

pref_categoria(juan, novela).
pref_categoria(juan, madrid).
pref_categoria(paco, madrid).

pref_autor(juan, jose_rodriguez).

pref_anyo(juan, Year) :- Year > 2010.
pref_anyo(juan, Year) :- Year < 1970.


% junto con relaciones entre los usuarios
confianza(juan, paco, 1).
confianza(paco, juan, 5).
confianza(juan, miguel, 3).
confianza(miguel, juan, 0).
confianza(juan, manuel, 2).
confianza(manuel, juan, 2).



% 1. Define un predicado rec_contenido/2 que determine si
%    un producto le vaya a gustar a un usuario en base a su contenido.
%    Para ello, considerad que un producto es recomendable a un usuario
%    en base a su contenido si sus atributos (precio, autor, categoria, anyo)
%    son relevantes para el usuario, es decir, si tiene una preferencia por el menos uno de ellos.
%    Puede ser aconsejable crear predicados del tipo autor_rel/2 para simplificar este predicado.
% :- rec_contenido(juan, Producto).

%si el usuario tiene preferencias por cualquiera de los atributos del producto se lo recomendamos
rec_contenido(U, P):- precio(P, Pr), pref_precio(U, Pr).
rec_contenido(U, P):- categoria(P, C), pref_categoria(U, C).
rec_contenido(U, P):- autor(P, A), pref_autor(U,A).
rec_contenido(U, P):- anyo(P, An), pref_anyo(U,An).

% 2. Ahora vamos a obtener recomendaciones pero en base a otros usuarios.
%    Para ello, primero debes crear dos predicados que permitan encontrar,
%    primero, todos los potenciales usuarios que nos ayudarán a obtener predicciones,
%    en base a la confianza con el usuario de entrada (predicado vecinos/3);
%    después, en base a esos potenciales vecinos, se filtrarán los usuarios que tengan
%    alguna preferencia hacia el producto de entrada (predicado similares/4).
%    Para este predicado puede ser útil utilizar findall/3.
%
% :- vecinos(juan, Y, 0). % ¿qué usuarios podrían ser vecinos de juan si exigimos una confianza mayor que 0?
% :- vecinos(juan, Y, 3). % ¿qué usuarios podrían ser vecinos de juan si exigimos una confianza mayor que 3?
%
% :- similares(juan, puerta_sol, [paco, miguel, manuel], X). % ¿qué usuarios son similares a juan para el producto puerta_sol si partimos del conjunto paco, miguel y manuel?
%
%    Una vez estos dos predicados están hechos, la recomendación para un usuario (predicado rec_usuarios/4)
%    tiene en cuenta que no exista una preferencia para ese producto por ese usuario,
%    que los vecinos cumplan la restricción de confianza, y que los similares tengan preferencia hacia el producto.
% :- rec_usuarios(juan, Producto, 0, Y).
% Y permite "explicar" con qué usuarios se han hecho las recomendaciones o restringir la búsqueda a determinados vecinos
% :- rec_usuarios(juan, X, 3, [miguel]).
% :- rec_usuarios(juan, puerta_sol, 0, Y).

%los vecinos de la persona tienen un nivel mayor o igual de confianza que K
vecinos(J, Y, C):- confianza(J, Y, K), K>= C.

%si juan tiene preferencia por un producto Y es la lista que tienen gustos similares a juan
similares(juan, Z, Y, X):- pref_prod(juan, Z),findall(V, (member(V,Y),pref_prod(V,Z)), X).

%si juan tiene vecinos de gustos similares entonces les recomendamos el Producto
rec_usuarios(juan, Producto, X, Y):- vecinos(juan, Y, X), similares(juan, Producto, [Y], Z).

/***************
* EJERCICIO 5 (2p). Sistema de recomendación
* This exercise involves recommending products to users based on their preferences.
* Using criteria stored in the knowledge base, the system suggests items that match user interests.
***************/

% Base knowledge
% Defining user preferences and product attributes.
% preference(User, Category) indicates that the user prefers products in a particular category.
% product(Product, Category) associates a product with a specific category.

preference(alice, electronics).
preference(bob, books).
preference(alice, fitness).

product(laptop, electronics).
product(novel, books).
product(yoga_mat, fitness).

% Recommendation predicate
% recommend(User, Product) succeeds if there is a match between User's preferences and Product's category.

recommend(User, Product) :-
    preference(User, Category),    % Identify user preference category
    product(Product, Category).    %