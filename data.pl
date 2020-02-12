:- module(data,[room/1,location/2,connect/3,turned_off/1,turned_on/1,here/1,near/1,have/1]).
:- dynamic have/1.
:- dynamic here/1.
:- dynamic near/1.
:- dynamic location/2.
:- dynamic turned_off/1.
:- dynamic turned_on/1.

room(kitchen).
room(office).
room(hall).
room('dining room').
room(cellar).

location(object(desk,big,brown), office).
location(object(apple,small,green), kitchen).
location(object(flashlight,small,black), desk).
location(object('washing machine',huge,white), cellar).
location(object(nani,small,purple), 'washing machine').
location(object(broccoli,small,green), kitchen).
location(object(crackers,small,yellow), kitchen).
location(object(computer,big,white), office).
location(object(envelope,small,white), desk).
location(object(stamp,small,colourful), envelope).
location(object(key,small,metalic), envelope).

door(office, hall,open).
door(kitchen, office,closed).
door(hall, 'dining room',open).
door(kitchen, cellar,open).
door('dining room', kitchen,open).

connect(X,Y,S) :- door(X,Y,S).
connect(X,Y,S) :- door(Y,X,S).

have(Thing):-
    location(Thing,Container),
    have(Container).

edible(apple).
edible(crackers).

tastes_yucky(broccoli).

turned_off(flashlight).
here(kitchen).