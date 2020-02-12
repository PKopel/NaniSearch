:- module(utils,[respond/1,inventory/0,list_things/2,list_connections/1]).
:- use_module(data).

respond([]):-
    nl.
respond([H|T]):-
    write(H),
    respond(T).

list_connections(Room) :-
    connect(Room, X, S),
    tab(2),
    respond([X,", ",S]),
    fail.
list_connections(_).

list_things(Place,In) :-  
    location(object(X,Size,Color), Place),
    tab(In),respond([Size,", ",Color," ",X]),
    NIn is In + 2,
    ( location(_,X) -> list_things(X,NIn)
    ; otherwise -> fail
    ).
list_things(_,_).


inventory:- 
    have(object(X,Size,Color)),
    ( turned_on(X) -> respond(["You have ",Size,", ",Color," ",X,"(","turned on",")"])
    ; otherwise -> respond(["You have ",Size,", ",Color," ",X])
    ).
inventory:-
    respond(["You don't have anything"]).