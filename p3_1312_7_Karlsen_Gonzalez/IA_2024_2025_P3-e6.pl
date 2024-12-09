/***************
*
* Autores: Daniel Cabrero, Havard Karlsen
*
* Grupo: 1312_02
*
****************/

/***************
* EJERCICIO 6 (2p). Procesamiento de sentencias
* In this exercise, we use Prolog to determine if a sentence is well-formed based on simple grammatical rules.
* The knowledge base includes articles, nouns, verbs, and now adjectives, which are combined to create sentences.
* We define predicates 'frase/1', 'frase2/1', and 'frase3/1' to verify different levels of sentence complexity.
***************/

% Base Knowledge
% Definitions for articles, nouns, verbs, and adjectives.

% Articles
articulo(el).
articulo(la).
articulo(un).
articulo(una).

% Nouns
nombre(perro).
nombre(hueso).
nombre(gato).
nombre(niño).

% Verbs
verbo(come).
verbo(encuentra).
verbo(persigue).

% Adjectives
adjetivo(grande).
adjetivo(pequeño).
adjetivo(rapido).
adjetivo(fuerte).

/***************
* Rule 1: frase/1
* This predicate checks for a basic sentence structure: Article + Noun + Verb.
* Example of valid sentence: "el perro come".
* Example of invalid sentence: "come" (fails because it lacks a noun phrase).
***************/
frase([Articulo, Nombre, Verbo]) :-
    articulo(Articulo),
    nombre(Nombre),
    verbo(Verbo).

/***************
* Rule 2: frase2/1
* This predicate extends frase/1 to include an optional complement:
*    [Article, Noun, Verb, (optional) Article, Noun]
* This allows for sentences like "el perro come un hueso".
***************/
frase2([Articulo1, Nombre1, Verbo]) :-
    articulo(Articulo1),
    nombre(Nombre1),
    verbo(Verbo).

frase2([Articulo1, Nombre1, Verbo, Articulo2, Nombre2]) :-
    articulo(Articulo1),
    nombre(Nombre1),
    verbo(Verbo),
    articulo(Articulo2),
    nombre(Nombre2).

/***************
* Rule 3: frase3/1
* This predicate adds adjectives to the sentence structure, allowing for flexibility in adjective placement.
* Sentences can now be structured as follows:
*    [Article, Noun, Adjective, Verb] OR [Article, Adjective, Noun, Verb]
* Example: "el perro grande come" OR "el grande perro come"
***************/

% Case 1: Adjective after the noun.
frase3([Articulo, Nombre, Adjetivo, Verbo]) :-
    articulo(Articulo),
    nombre(Nombre),
    adjetivo(Adjetivo),
    verbo(Verbo).

% Case 2: Adjective before the noun.
frase3([Articulo, Adjetivo, Nombre, Verbo]) :-
    articulo(Articulo),
    adjetivo(Adjetivo),
    nombre(Nombre),
    verbo(Verbo).

% Case 3: Sentence with complement and adjective after the noun.
frase3([Articulo1, Nombre1, Adjetivo1, Verbo, Articulo2, Nombre2]) :-
    articulo(Articulo1),
    nombre(Nombre1),
    adjetivo(Adjetivo1),
    verbo(Verbo),
    articulo(Articulo2),
    nombre(Nombre2).

% Case 4: Sentence with complement and adjective before the noun.
frase3([Articulo1, Adjetivo1, Nombre1, Verbo, Articulo2, Nombre2]) :-
    articulo(Articulo1),
    adjetivo(Adjetivo1),
    nombre(Nombre1),
    verbo(Verbo),
    articulo(Articulo2),
    nombre(Nombre2).

/***************
* Example Queries:
* 1. Basic sentence structure (frase/1):
*    frase([el, perro, come]).
*    Explanation: Checks for basic noun and verb phrase structure.

* 2. Sentence with atrical not at the start (frase2/1):
*    frase2([el, perro, come, un, hueso]).
*    Explanation: Allows for a complement after the verb.

* 3. Sentence with adjective (frase3/1):
*    frase3([el, perro, grande, come]).
*    frase3([el, grande, perro, come]).
*    Explanation: Allows adjectives before or after nouns and includes optional complements.
***************/
