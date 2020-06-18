:- module(language_parser,[get_commands/1,get_commands/3]).
:- use_module(data).

get_commands(CL) :-
  read_list(WL),
  get_commands(CL,WL,[]),
  !.
get_commands(_) :-
  write('I don''t understand'), nl, fail.

get_commands([C|_], [], CWL):-
  reverse(CWL,L),
  command(CP, L, []),
  C =..  CP, !.
get_commands([C|CL], [and|WL], CWL):-
  reverse(CWL,L),
  command(CP, L, []),
  C =..  CP, !,
  get_commands(CL, WL, []).
get_commands(CL, [W|WL], CWL):-
  get_commands(CL, WL, [W|CWL]).

command([end],[end|_],_).
command([look],[look|_],_).
command([goto, Place]) --> noun(place, Place).
command([goto, Thing]) --> noun(thing, Thing).
command([V,O]) --> 
    verb(Object_Type, V), 
    object(Object_Type, O).
  
verb(place, goto) --> [go, to].
verb(thing, goto) --> [go, to].
verb(thing, take) --> [take].
verb(thing, leave) --> [leave].
verb(thing, turn_on) --> [turn, on].
verb(thing, turn_off) --> [turn, off].
verb(thing, eat) --> [eat].
  
object(Type, N) --> det, noun(Type, N).
object(Type, N) --> noun(Type, N).
  
det --> [the].
det --> [a].
  
noun(place,X) --> [X], {room(X)}.
noun(place,'dining room') --> [dining, room].
noun(thing,X) --> [X], {thing(X)}.

read_list(L) :-
    write('> '),
    read_line(CL),
    word_list(L,CL,[]), !.
  
read_line(L) :-
    get0(C),
    build_list(C,L).
  
build_list(13,[]) :- !.
build_list(10,[]) :- !.
build_list(C,[C|X]) :-
    get0(C2),
    build_list(C2,X).
   
word_list([X|Y]) --> word(X), whitespace, word_list(Y).
word_list([X]) --> whitespace, word_list(X).
word_list([X]) --> word(X).
word_list([X]) --> word(X), whitespace.
  
word(W) --> char_list(X), {name(W,X)}.
  
char_list([X|Y]) --> chr(X), char_list(Y).
char_list([X]) --> chr(X).
  
chr(X) --> [X],{X>=48}.
  
whitespace --> whsp, whitespace.
whitespace --> whsp.
  
whsp --> [X], {X<48}.