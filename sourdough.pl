:- multifile
        prolog:message//1.

prolog:message(starter_warning(Expected, Actual, Unit)) -->
    [ 'Using less starter (~1f ~w) than expected (~1f ~w) is not recommended.'-[Actual, Unit, Expected, Unit] ].


% gram <-> ounce conversion
gram_ounce(Grams, Ounces) :-
    ground(Grams),
    Ounces is Grams / 28.35.
gram_ounce(Grams, Ounces) :-
    ground(Ounces),
    Grams is Ounces * 28.35.

:- begin_tests(gram_ounce).

test(gram_ounce) :-
    gram_ounce(28.35, 1.0),
    gram_ounce(28.35, Oz), Oz = 1.0,
    gram_ounce(Gm, 1.0), Gm = 28.35.

:- end_tests(gram_ounce).


% starter water/flour ratio
starter_water_flour(Starter, Water, Flour) :-
    Flour = Water,
    Flour is Starter / 2,
    Water is Starter / 2.


% recipe
sourdough(
    Expected_Starter_Gm, Expected_Water_Gm, Expected_Flour_Gm, 
    Expected_Starter_Oz, Expected_Water_Oz, Expected_Flour_Oz,
    Actual_Starter_Gm, Actual_Water_Gm, Actual_Flour_Gm,
    Actual_Starter_Oz, Actual_Water_Oz, Actual_Flour_Oz
) :-
    maplist(
        gram_ounce,
        [Expected_Starter_Gm, Expected_Water_Gm, Expected_Flour_Gm, Actual_Starter_Gm],
        [Expected_Starter_Oz, Expected_Water_Oz, Expected_Flour_Oz, Actual_Starter_Oz]
    ),
    warn_if_starter_less_than_expected(Expected_Starter_Oz, Actual_Starter_Oz),
    Excess_Starter_Gm is Actual_Starter_Gm - Expected_Starter_Gm,
    starter_water_flour(Excess_Starter_Gm, Excess_Water_Gm, Excess_Flour_Gm),
    Actual_Water_Gm is Expected_Water_Gm - Excess_Water_Gm,
    Actual_Flour_Gm is Expected_Flour_Gm - Excess_Flour_Gm,
    maplist(
        gram_ounce,
        [Actual_Water_Gm, Actual_Flour_Gm],
        [Actual_Water_Oz, Actual_Flour_Oz]
    ).

warn_if_starter_less_than_expected(Expected_Starter_Oz, Actual_Starter_Oz) :-
    Actual_Starter_Oz < Expected_Starter_Oz,
    print_message(warning, starter_warning(Expected_Starter_Oz, Actual_Starter_Oz, 'oz')).
warn_if_starter_less_than_expected(Expected_Starter_Oz, Actual_Starter_Oz) :-
    Actual_Starter_Oz >= Expected_Starter_Oz.


:- begin_tests(sourdough).

test(sourdough) :-
    sourdough(
        200, 525, 700,
        A, B, C,
        D, E, F,
        7.0, H, I
    ),
    7 is round(A),
    19 is round(B),
    25 is round(C),
    198 is round(D),
    526 is round(E),
    701 is round(F),
    19 is round(H),
    25 is round(I).

test(sourdough) :-
    sourdough(
        200, 525, 700,
        _, _, _,
        _, _, _,
        8.0, _, _
    ).

:- end_tests(sourdough).
