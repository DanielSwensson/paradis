-module(week4_solutions).
-export([factorial/1,rotate/2,expand_markup/1]).

factorial(1) ->
	1;
factorial(N) ->
	N * factorial(N - 1). 

rotate(N,L) ->
	rotate(N rem length(L),L,0).

rotate(N,L, Iterator) when (N =< -1), (Iterator > N)->
	LReverse = lists:reverse(L),
	[H|T] = LReverse,
	L1 = lists:append([[H],(lists:reverse(T))]),
	rotate(N,L1,Iterator-1);

rotate(N,L, Iterator) when (N >= 1), (Iterator < N)->
	[H|T] = L,
	L1 = lists:append([T,[H]]),
	rotate(N,L1,Iterator+1);

rotate(_,L,_) ->
	L.


expand_markup(String) ->
	[H|T] = String,
	expand_markup(T, [H], H).

expand_markup([], Previous,_) ->
	Previous;


expand_markup(String, Previous, _) ->
	[H|T] = String,
	expand_markup(T,lists:append([Previous, [H]]), H).

