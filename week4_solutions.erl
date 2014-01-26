-module(week4_solutions).
-export([factorial/1,rotate/2,expand_markup/1,count_atoms/2]).

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
	expand_markup(String, [], false, false).

%List is empty return parsed string
expand_markup([],Parsed,_,_) ->
	Parsed;

%Check for open bold tag
expand_markup([$*,$*|String], Parsed, false, ItalicCheck) ->
	Parsed1 = lists:append([Parsed,"<b>"]),
	expand_markup(String, Parsed1, true, ItalicCheck);

%Check for closing bold tag with italic still open
expand_markup([$*,$*|String], Parsed, true, true) ->
	Parsed1 = lists:append([Parsed,"</i></b><i>"]),
	expand_markup(String, Parsed1, false, true);

%Check for closing bold tag
expand_markup([$*,$*|String], Parsed, true, ItalicCheck) ->
	Parsed1 = lists:append([Parsed,"</b>"]),
	expand_markup(String, Parsed1, false, ItalicCheck);

%Check for open italic tag
expand_markup([$_,$_|String], Parsed, BoldCheck ,false) ->
	Parsed1 = lists:append([Parsed,"<i>"]),
	expand_markup(String, Parsed1, BoldCheck ,true);

%Check for closing italic tag
expand_markup([$_,$_|String], Parsed, BoldCheck ,true) ->
	Parsed1 = lists:append([Parsed,"</i>"]),
	expand_markup(String, Parsed1, BoldCheck ,false);

%Check for closing italic tag with bold still open
expand_markup([$_,$_|String], Parsed, true ,true) ->
	Parsed1 = lists:append([Parsed,"<b></i></b>"]),
	expand_markup(String, Parsed1, true ,false);

%check for normal character
expand_markup([Character|String],Parsed,BoldCheck, ItalicCheck) ->
	Parsed1 = lists:append([Parsed, [Character]]),
	expand_markup(String, Parsed1,BoldCheck, ItalicCheck).	


count_atoms(A,X) ->
	{ok, Content} = X,
	List = make_list(Content,[]),
	{Count} = count_atoms(A,List,0),
	Count.

count_atoms(A,[atom,_,A|T],Count) ->
	count_atoms(A,T,Count+1);

count_atoms(A,[_|T],Count) ->
	count_atoms(A,T,Count);
count_atoms(_,[],Count) ->
	{Count}.
	

make_list([H|T], Parsed) when is_list(H) ->
	HList = make_list(H,[]),
	Parsed1 = lists:append([Parsed,HList]),
	make_list(T,Parsed1);

make_list([H|T], Parsed) when is_tuple(H) ->
	HList = tuple_to_list(H),
	HList1 = make_list(HList,[]),
	Parsed1 = lists:append([Parsed,HList1]),
	make_list(T,Parsed1);

make_list([H|T], Parsed) ->
	Parsed1 = lists:append([Parsed, [H]]),
	make_list(T,Parsed1);
make_list([],Parsed) ->
	Parsed.




















