:- module(html_recipe, [html_sourdough/8]).


html_sourdough(
    Recipe_Starter_Oz, Recipe_Water_Oz, Recipe_Flour_Oz,
    Starter_Oz, Water_Oz, Flour_Oz,
    Title, Html
) :-
    format(string(Title), "Sourdough Recipe with ~1f oz starter", [Starter_Oz]),
    format(string(Para1), "The recipe calls for ~1f oz starter, ~1f oz water, and ~1f oz flour.", [Recipe_Starter_Oz, Recipe_Water_Oz, Recipe_Flour_Oz]),
    format(string(Para2), "Because you're using ~1f oz starter, you should instead use ~1f oz water and ~1f oz flour.", [Starter_Oz, Water_Oz, Flour_Oz]),
    Html = [p(Para1), p(b(Para2)), p("This assumes you want to make the same amount of dough overall.")].
