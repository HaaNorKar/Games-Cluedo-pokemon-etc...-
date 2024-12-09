/***************
*
* Autores: Daniel Cabrero, Havard Karlsen
*
* Grupo: 1312_02
*
****************/

/***************
* Introducción
*
* Os recomendamos echar un vistazo a la colección de 99 problemas de Prolog publicados en
* https://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/
* Ahí puedes encontrar una gran serie de problemas con código que te pueden ayudar
* como entrenamiento.
*
****************/

/***************
* Entrega
*
* Se debe entregar un único fichero comprimido cuyo nombre, todo él en minúsculas y sin acentos,
* tildes, o caracteres especiales, tendrá la siguiente estructura:
*       p3_gggg_mm_apellido1_apellido2.zip
* Donde gggg es el identificador del grupo y mm es el de la pareja.
* Este fichero debe incluir los ficheros .pl entregados por los profesores con sus correspondientes
* soluciones y descripciones de las mismas como comentarios (no hace falta entregar una memoria por separado).
*
* Recordad utilizar nombres informativos para los términos (hechos, reglas) así como comentar vuestro código
* adecuadamente para que resulte de fácil lectura.
*
****************/


/***************
* EJERCICIO 1 (1p). Ejercicio de lectura
*
* Escribe en este fichero la lectura declarativa (para el caso general)
* y procedural (para la consulta slice([1, 2, 3, 4], 2, 3, L2))
* del predicado slice/4, disponible en
* https://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/p18.pl
*
* Véase https://www.metalevel.at/prolog/reading para un ejemplo.
* EJERCICIO 1 (1p). Ejercicio de lectura
* Declarative and procedural explanation of slice/4 predicate
*
* Declarative Explanation:
* The slice/4 predicate in Prolog takes four arguments: a list (List), a starting index (I), an ending index (K), and a result list (Slice).
* The purpose of the slice/4 predicate is to extract a sublist from List that starts at the I-th position and ends at the K-th position.
* This is similar to slicing in other programming languages, where we obtain a subset of a list based on specified indices.
*
* Example for declarative use:
* slice([1, 2, 3, 4], 2, 3, L2).
* Expected Output: L2 = [2, 3]
* This query states that we want to get a sublist of [1, 2, 3, 4] from position 2 to 3, resulting in [2, 3].
*
* Procedural Explanation:
* Procedurally, Prolog evaluates slice/4 by recursively iterating over the List elements to reach the starting index (I).
* Once at index I, it starts adding elements to Slice until reaching index K, then stops.
* For the query slice([1, 2, 3, 4], 2, 3, L2), Prolog processes as follows:
*   1. Skip the first element of the list to reach index 2.
*   2. Collect elements from index 2 up to index 3.
*   3. Return the collected elements as the result list L2.
* This procedural approach ensures the correct elements are selected and stops once the end index K is reached.
*
* Reference for the slice/4 predicate can be found at:
* https://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/p18.pl
*
****************/
slice([X|_],1,1,[X]).
slice([X|Xs],1,K,[X|Ys]) :- K > 1,
   K1 is K - 1, slice(Xs,1,K1,Ys).
slice([_|Xs],I,K,Ys) :- I > 1,
   I1 is I - 1, K1 is K - 1, slice(Xs,I1,K1,Ys).
