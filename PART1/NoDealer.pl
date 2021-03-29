:- use_module(library(lists)).

nn(no_dealer_net, [X],Z,[hit, hold])::hitOrHold(X,Z).

1/2::card(4, ID);1/2::card(6, ID).



decide(PHand, hold) :- list_sum(PHand, PTotal),
                                PTotal >= 21.

decide(PHand, Result) :- list_sum(PHand, PTotal),
                                PTotal < 21,
                                hitOrHold(PTotal, Result).

newCard(Hand, card(X)):- card(X, Hand).


addCard(Hand, Hand1) :- decide(Hand, hit),
newCard(Hand, NewCard),
addCard([NewCard|Hand], Hand1).

addCard(Hand, Hand) :- decide(Hand, hold).

player(Hand, EndHand) :- addCard(Hand, EndHand).

result(Sum, win) :- Sum > 16,
					Sum < 22.
result(Sum, loss) :- Sum < 17.
result(Sum, loss) :- Sum > 21.

newGame(PCard1, PCard2, Result1) :- player([PCard1, PCard2], EndHand),
									list_sum(EndHand, Result),
									result(Result, Result1).

%auxiliary functions
list_sum([], 0).
list_sum([card(Item)], Item1) :- Item1 is Item.
list_sum([card(Item1),card(Item2) | Tail], Total) :-
    list_sum([card(Item1 + Item2)|Tail], Total).






