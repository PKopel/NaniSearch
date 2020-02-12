:- module(puzzles,[puzzle/1]).
:- use_module(things).
:- use_module(data).
:- use_module(utils).

puzzle(cellar):-
    have(object(flashlight,_,_)),
    turned_on(flashlight),
    !.
puzzle(cellar):-
    respond(["It's dark and you are afraid of the dark."]),
    !, fail.
puzzle(Room):-
    here(Place),
    connect(Place,Room,closed),
    have(object(key,_,_)),
    !.
puzzle(Room):-
    here(Place),
    connect(Place,Room,closed),
    not(have(object(key,_,_))),
    respond(["You don't have key"]),
    !,fail.
puzzle(_).