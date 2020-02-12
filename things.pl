:- module(things,[take/1,leave/1,turn_on/1,turn_off/1]).
:- use_module(places).
:- use_module(data).
:- use_module(utils).

take(X):-  
    can_take(X),
    take_object(X).

can_take(Thing) :-
    here(Place),
    is_contained_in(object(Thing,small,_), Place).
can_take(Thing) :-
    here(Place),
    ( location(object(Thing,_,_), Place) -> respond([Thing," is too big"])
    ; otherwise -> respond(["There is no ",Thing," here."])
    ),fail.

take_object(X):-  
    retract(location(object(X,Size,Color),_)),
    asserta(have(object(X,Size,Color))),
    respond([X," taken"]).

leave(X):-
    have(object(X,Size,Color)),
    leave_object(object(X,Size,Color)).
leave(X):-
    respond(["You don't have ",X]),
    fail.

leave_object(X):-
    here(Place),
    retract(have(X)),
    asserta(location(X,Place)),
    respond(["You left ",X," in ",Place]).
    
turn_on(X):-
    turned_off(X),
    retract(turned_off(X)),
    asserta(turned_on(X)),
    respond([X," turned on"]).
turn_on(X):-
    respond(["You can't turn ",X," on"]),fail.
    
turn_off(X):-
    turned_on(X),
    retract(turned_on(X)),
    asserta(turned_off(X)),
    respond([X," turned off"]).
turn_off(X):-
    respond(["You can't turn ",X," off"]),fail.

is_contained_in(T1,T2) :-  
    location(T1,T2).
is_contained_in(T1,T2) :-
    location(object(X,_,_),T2),
    is_contained_in(T1,X).