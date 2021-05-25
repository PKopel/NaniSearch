:- use_module(data/things).
:- use_module(data/places).
:- use_module(data/data).
:- use_module(utils/utils).
:- use_module(utils/language_parser).
    
look :-
    here(Room),
    respond(["You are in the ",Room]),
    write("You can see:"), nl,
    list_things(Room,2),
    write("You can go to:"), nl,
    list_connections(Room),
    inventory. 
    
do(goto(X)):-!,goto(X),!.
do(go(X)):-!,goto(X),!.
do(inventory):-inventory,!.
do(look):-look,!.
do(take(X)):- take(X), !.
do(put(X)):- put(X),!.
do(eat(X)):- eat(X),!.
do(end).
do(_):-
  write('Invalid command').

end_condition([end]).
end_condition(_) :-
  have(object(nani,_,_)),
  write("Congratulations").

execute([end]).
execute([]):- !.
execute([C|CL]):-
  do(C),nl,!,
  execute(CL).

start:- 
    write("Welcome to Nani Search"), nl,
    repeat,
    write("--------------"),nl,
    look,
    get_commands(X),
    execute(X),
    end_condition(X).