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

sourdough(
    Expected_Starter_Gm, Expected_Water_Gm, Expected_Flour_Gm, 
    Expected_Starter_Oz, Expected_Water_Oz, Expected_Flour_Oz,
    Actual_Starter_Gm, Actual_Water_Gm, Actual_Flour_Gm,
    Actual_Starter_Oz, Actual_Water_Oz, Actual_Flour_Oz
) :-
    gram_ounce(Expected_Starter_Gm, Expected_Starter_Oz),
    gram_ounce(Expected_Water_Gm, Expected_Water_Oz),
    gram_ounce(Expected_Flour_Gm, Expected_Flour_Oz),
    gram_ounce(Actual_Starter_Gm, Actual_Starter_Oz),
    Excess_Starter_Gm is Actual_Starter_Gm - Expected_Starter_Gm,
    starter_water_flour(Excess_Starter_Gm, Excess_Water_Gm, Excess_Flour_Gm),
    Actual_Water_Gm is Expected_Water_Gm - Excess_Water_Gm,
    Actual_Flour_Gm is Expected_Flour_Gm - Excess_Flour_Gm,
    gram_ounce(Actual_Water_Gm, Actual_Water_Oz),
    gram_ounce(Actual_Flour_Gm, Actual_Flour_Oz).
sourdough(
        Expected_Starter_Gm,
        _,
        _,
        _,
        _,
        _,
        Actual_Starter_Gm,
        _,
        _,
        Actual_Starter_Oz,
        _,
        _
        ) :-
        gram_ounce(Actual_Starter_Gm, Actual_Starter_Oz),
        Actual_Starter_Gm < Expected_Starter_Gm,
        print('Using less starter than expected is discouraged!').

sourdough(
    200, 525, 700,
    Expected_Starter_Oz, Expected_Water_Oz, Expected_Flour_Oz,
    Actual_Starter_Gm, Actual_Water_Gm, Actual_Flour_Gm,
    5.5, Actual_Water_Oz, Actual_Flour_Oz
    ).