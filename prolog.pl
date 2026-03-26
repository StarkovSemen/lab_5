:- encoding(utf8).

/*
minmax(N, Min, Max) :-
    N < 10, !,                    
    Min = N,
    Max = N.
minmax(N, Min, Max) :-
    D is N mod 10,              
    R is N // 10,                 
    minmax(R, MinR, MaxR),
    Min is min(D, MinR),
    Max is max(D, MaxR).

go :-
    write('Введите натуральное число: '),
    read(Num),
    ( Num > 0 ->
        minmax(Num, Min, Max),
        write('Наибольшая цифра: '), write(Max), nl,
        write('Наименьшая цифра: '), write(Min), nl
    ).

:- go.
*/

/*
counta([], 0) :- !.

counta([Head|Tail], Count) :-
    counta(Tail, TailCount), 
    (   Head < 0, Head mod 2 =\= 0       
    ->  Count is TailCount + 1          
    ;   Count = TailCount          
    ).

go :-
    write('Введите список целых чисел: '),
    read(List),
    counta(List, Count),
    write('Количество нечётных отрицательных элементов: '), write(Count), nl.

:- go.
*/

:- encoding(utf8).

teachers([морозов, васильев, токарев]).

subjects([история, математика, биология, география, английский, французский]).

assign([], _, []).
assign([T|Ts], Subj, [T-[X,Y]|Rest]) :-
    select(X, Subj, S1),
    select(Y, S1, S2),
    X \= Y,
    assign(Ts, S2, Rest).

teacher_of(Subject, Assignments, Teacher) :-
    member(Teacher-Pair, Assignments),
    member(Subject, Pair).

conditions(Assignments) :-
    teacher_of(география, Assignments, Geog),
    teacher_of(французский, Assignments, French),
    Geog \= French,
    
    teacher_of(биология, Assignments, Bio),
    teacher_of(математика, Assignments, Math),
    Bio \= Math,                    
    \+ teacher_of(биология, Assignments, морозов), 
    
    teacher_of(французский, Assignments, French2),
    teacher_of(биология, Assignments, Bio2),
    member(токарев-_, Assignments), 
    токарев \= Bio2,
    токарев \= French2,
    Bio2 \= French2,
    
    teacher_of(математика, Assignments, Math2),
    teacher_of(английский, Assignments, Eng),
    морозов \= Math2,
    морозов \= Eng,
    Math2 \= Eng.

solve(Assignments) :-
    teachers(T),
    subjects(S),
    assign(T, S, Assignments),
    conditions(Assignments).

print_solution(Assignments) :-
    write('Решение:'), nl,
    member(морозов-P, Assignments), write('Морозов: '), write(P), nl,
    member(васильев-P2, Assignments), write('Васильев: '), write(P2), nl,
    member(токарев-P3, Assignments), write('Токарев: '), write(P3), nl.

main :-
    solve(Assignments),
    print_solution(Assignments).

:- initialization(main).