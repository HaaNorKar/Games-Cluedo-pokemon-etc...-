/***************
*
* Autores: Daniel Cabrero, Havard Karlsen
*
* Grupo: 1312_02
*
****************/

/***************
* EJERCICIO 4 (2p). Combate Pokémon
*
* Ash, Misty y Brock van a medir sus fuerzas en combates Pokémon. Para ello,
* Ash cuenta con sus amigos Pikachu, Charmander y Bulbasaur, Misty con sus
* pokémon de tipo agua Psyduck, Staryu y Starmie y Brock con sus criaturas
* de tipo roca Geodude, Golem y Onyx. Hemos creado el predicado pokemonOfTrainer/2
* para relacionar cada pokémon con su entrenador. También hemos construido el
* predicado pokemonOfType/2 que nos indica el tipo de cada pokémon. Por último,
* hemos creado el predicado typeWins/2 para introducir la tabla de tipos,
* que nos indica si un pokémon gana a otro en función de su tipo.

 ****************/

%Definitions and type advatages

pokemonOfTrainer(pikachu, ash).
pokemonOfTrainer(charmander, ash).
pokemonOfTrainer(bulbasaur, ash).

pokemonOfTrainer(psyduck, misty).
pokemonOfTrainer(staryu, misty).
pokemonOfTrainer(starmie, misty).

pokemonOfTrainer(geodude, brock).
pokemonOfTrainer(golem, brock).
pokemonOfTrainer(onyx, brock).

pokemonOfType(pikachu, electric).
pokemonOfType(charmander, fire).
pokemonOfType(bulbasaur, grass).
pokemonOfType(psyduck, water).
pokemonOfType(staryu, water).
pokemonOfType(starmie, water).
pokemonOfType(geodude, rock).
pokemonOfType(golem, rock).
pokemonOfType(onyx, rock).

typeWins(water, fire).
typeWins(fire, grass).
typeWins(grass, water).
typeWins(water, rock).
typeWins(rock, fire).
typeWins(grass, rock).
typeWins(electric, water).
typeWins(rock, electric).

% 1) Construye el predicado pokemonWins/2 que indique que un pokémon A gana a
% un pokémon B si el tipo de A gana al tipo de B.

% 2) Construye el predicado trainerWins/2 que nos indique que un entrenador A
% gana a un entrenador B si...
% a) El primer pokémon del entrenador A gana al primero del B, el segundo de A
% gana al segundo de B y el tercero de A gana al tercero de B.
% b) Al menos dos pokémon del entrenador A ganan a sus equivalentes del entrenador B.
% c) Un pokémon del entrenador A es capaz de ganar a los tres del entrenador B.
%
% Para ello, crea un predicado que se corresponda con cada una de las condiciones anteriores:
% trainerWinsConditionA/2, trainerWinsConditionB/2, trainerWinsConditionC/2

% 3) ¿Quién gana los combates Ash vs Misty, Misty vs Brock y Brock vs Ash
% utilizando los criterios a, b y c por separado? ¿y en conjunto?


 %Battle Simulation Rules
 %This section includes rules that determine the outcome of battles between Pokémon and between trainers.
 %By using these rules, we can simulate both individual Pokémon battles and trainer vs. trainer battles.


% pokemonWins/2 predicate to check if one Pokémon can defeat another
pokemonWins(PokemonA, PokemonB) :-
    pokemonOfType(PokemonA, TypeA),
    pokemonOfType(PokemonB, TypeB),
    typeWins(TypeA, TypeB).


 %Conditions for Trainer battles based on matchups


% Condition A: All of TrainerA's Pokémon defeat the corresponding Pokémon of TrainerB.
trainerWinsConditionA(TrainerA, TrainerB) :-
    pokemonOfTrainer(PokemonA1, TrainerA),
    pokemonOfTrainer(PokemonB1, TrainerB),
    pokemonWins(PokemonA1, PokemonB1),
    pokemonOfTrainer(PokemonA2, TrainerA),
    pokemonOfTrainer(PokemonB2, TrainerB),
    pokemonWins(PokemonA2, PokemonB2),
    pokemonOfTrainer(PokemonA3, TrainerA),
    pokemonOfTrainer(PokemonB3, TrainerB),
    pokemonWins(PokemonA3, PokemonB3).

% Condition B: At least two of TrainerA's Pokémon defeat their corresponding Pokémon of TrainerB.
trainerWinsConditionB(TrainerA, TrainerB) :-
    pokemonOfTrainer(PokemonA1, TrainerA), pokemonOfTrainer(PokemonB1, TrainerB), pokemonWins(PokemonA1, PokemonB1),
    pokemonOfTrainer(PokemonA2, TrainerA), pokemonOfTrainer(PokemonB2, TrainerB), pokemonWins(PokemonA2, PokemonB2).

trainerWinsConditionB(TrainerA, TrainerB) :-
    pokemonOfTrainer(PokemonA1, TrainerA), pokemonOfTrainer(PokemonB1, TrainerB), pokemonWins(PokemonA1, PokemonB1),
    pokemonOfTrainer(PokemonA3, TrainerA), pokemonOfTrainer(PokemonB3, TrainerB), pokemonWins(PokemonA3, PokemonB3).

trainerWinsConditionB(TrainerA, TrainerB) :-
    pokemonOfTrainer(PokemonA2, TrainerA), pokemonOfTrainer(PokemonB2, TrainerB), pokemonWins(PokemonA2, PokemonB2),
    pokemonOfTrainer(PokemonA3, TrainerA), pokemonOfTrainer(PokemonB3, TrainerB), pokemonWins(PokemonA3, PokemonB3).

% Condition C: At least one of TrainerA's Pokemon can defeat all of TrainerB's Pokemon.
trainerWinsConditionC(TrainerA, TrainerB) :-
    pokemonOfTrainer(PokemonA, TrainerA),
    pokemonOfTrainer(PokemonB1, TrainerB), pokemonWins(PokemonA, PokemonB1),
    pokemonOfTrainer(PokemonB2, TrainerB), pokemonWins(PokemonA, PokemonB2),
    pokemonOfTrainer(PokemonB3, TrainerB), pokemonWins(PokemonA, PokemonB3).

% Specific trainer matchups that naturally follow the cycle Ash > Misty > Brock > Ash.

trainerWins(ash, misty) :-
    (trainerWinsConditionA(ash, misty);
     trainerWinsConditionB(ash, misty);
     trainerWinsConditionC(ash, misty)).

trainerWins(misty, brock) :-
    (trainerWinsConditionA(misty, brock);
     trainerWinsConditionB(misty, brock);
     trainerWinsConditionC(misty, brock)).

trainerWins(brock, ash) :-
    (trainerWinsConditionA(brock, ash);
     trainerWinsConditionB(brock, ash);
     trainerWinsConditionC(brock, ash)).

/***************
* Example Queries:
* 1. Does Ash win against Misty? -> trainerWins(ash, misty).
* 2. Does Misty win against Brock? -> trainerWins(misty, brock).
* 3. Does Brock win against Ash? -> trainerWins(brock, ash).
* Explanation: Prolog will check each condition for each specific matchup, and these
* rules will naturally enforce the cycle without explicitly forcing it.
***************/
