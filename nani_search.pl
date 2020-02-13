:- use_module(things).
:- use_module(places).
:- use_module(data).
:- use_module(utils).
:- use_module(language_parser).


:- op(600, fx, goto).
:- op(600, fx, go).
:- op(600, fx, take).
:- op(600, fx, leave).
:- op(600, fx, turn_on).
:- op(600, fx, turn_off).
    
look :-
    here(Room),
    respond(["You are in the ",Room]),
    write('You can see:'), nl,
    list_things(Room,2),
    write('You can go to:'), nl,
    list_connections(Room),
    inventory. 
    
do(goto(X)):-!,goto(X),!.
do(go(X)):-!,goto(X),!.
do(inventory):-inventory,!.
do(look):-look,!.
do(take(X)):- take(X), !.
do(put(X)):- put(X),!.
do(end).
do(_):-
  write('Invalid command').

end_condition(end).
end_condition(_) :-
  have(object(nani,_,_)),
  write('Congratulations').

start:- 
    write('Welcome to Nani Search'), nl,
    repeat,
    write('--------------'),nl,
    look,
    get_command(X),
    do(X), nl,
    end_condition(X).