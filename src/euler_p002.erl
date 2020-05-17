%%% @author Alexandros Bantis <ambantis@gmail.com>
%%% @copyright (C) 2020, Alexandros Bantis
%%% @doc

%%% Even Fibonacci Numbers.
%%% Problem 2
%%%
%%% Each new term in the Fibonacci sequence is generated by adding the previous
%%% two terms. By starting with 1 and 2, the first 10 terms will be:
%%%
%%% 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
%%%
%%% By considering the terms in the Fibonacci sequence whose values do not
%%% exceed four million, find the sum of the even-valued terms
%%%
%%% https://projecteuler.net/problem=2
%%% @end
%%% Created : 16 May 2020 by Alexandros Bantis <ambantis@gmail.com>

-module(euler_p002).
-export([fibs_take/1, fibs_sum_all_to/1, fibs_sum_even_to/1]).

fibs_take(N) when N < 1 ->
    [];
fibs_take(1) ->
    [1];
fibs_take(2) ->
    [1, 2];
fibs_take(N) ->
    fibs_take(N-2, [2,1]).

fibs_take(0, Acc) ->
    lists:reverse(Acc);
fibs_take(N, [B,A|Tail]) ->
    fibs_take(N-1, [A+B, B, A | Tail]).

fibs_sum_all_to(N) -> fibs_sum_to(N, fun(_) -> true end).

fibs_sum_even_to(N) -> fibs_sum_to(N, fun(X) -> X rem 2 =:= 0 end).

fibs_sum_to(Limit, _Predicate) when Limit < 1 ->
    0;

fibs_sum_to(1, Predicate) ->
    case Predicate(1) of
        true -> 1;
        false -> 0
    end;

fibs_sum_to(N, Predicate) ->
    Acc = case {Predicate(1), Predicate(2)} of
              {false, false} -> 0;
              {true, false} -> 1;
              {false, true} -> 2;
              {true, true} -> 3
          end,
    fibs_sum_to(N, Acc, 1, 2, Predicate).

fibs_sum_to(Limit, Acc, A, B, Predicate) ->
    Next = A + B,
    case { Next > Limit, Predicate(Next) } of
        {true, _} -> Acc;
        {false, false} ->
            fibs_sum_to(Limit, Acc, B, Next, Predicate);
        {false, true} ->
            fibs_sum_to(Limit, Next+Acc, B, Next, Predicate)
    end.
