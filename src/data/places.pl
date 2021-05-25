:- module(places,[goto/1]).
:- use_module(data).
:- use_module(things).
:- use_module(puzzles).
:- use_module('..'/utils/utils).


:- op(600, fx, goto).
:- op(600, fx, go).


goto(Thing):-
    here(Room),
    location(object(Thing,_,_),Room),
    move(thing/Thing),
    respond(["You came to the ", Thing]),
    list_things(Thing,2).
goto(Place):-  
    can_go(Place),
    puzzle(Place),
    move(room/Place).

can_go(Place):- 
    here(X),
    ( connect(X, Place, open) -> true
    ; connect(X, Place, closed) -> puzzle(Place)
    ; otherwise -> fail
    ).
can_go(Place):- 
    here(X),
    (connect(X, Place, closed) -> respond(["You can't go to ",Place,", the doors are closed"])
    ; otherwise -> respond(["You can't get there from here."])
    ),fail.

move(room/Place):-
    retract(here(_)),
    ( near(_) -> retract(near(_))
    ; otherwise -> not( fail)
    ),asserta(here(Place)).
move(thing/Place):-
    ( near(_) -> retract(near(_))
    ; otherwise -> not( fail)
    ),asserta(near(Place)).