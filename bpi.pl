% BPI (Bread Programming Interface)

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_unix_daemon)).

:- use_module(sourdough).
:- use_module(html_recipe).


sourdough_handler(Request) :-
    member(method(get), Request),
    http_parameters(Request, [
        starter_gm(Recipe_Starter_Gm, [number]),
        water_gm(Recipe_Water_Gm, [number]),
        flour_gm(Recipe_Flour_Gm, [number]),
        starter_oz(Starter_Oz, [number])
        ]
    ),
    sourdough(
        Recipe_Starter_Gm, Recipe_Water_Gm, Recipe_Flour_Gm,
        Recipe_Starter_Oz, Recipe_Water_Oz, Recipe_Flour_Oz,
        _, _, _,
        Starter_Oz, Water_Oz, Flour_Oz
    ),
    html_sourdough(
        Recipe_Starter_Oz, Recipe_Water_Oz, Recipe_Flour_Oz,
        Starter_Oz, Water_Oz, Flour_Oz,
        Title, Html
    ),
    reply_html_page([title(Title)], Html).

sourdough_handler(Request) :-
    member(method(post), Request),
    http_read_json_dict(Request, Json_In, []),
    sourdough(
        Json_In.starter_gm, Json_In.water_gm, Json_In.flour_gm,
        _, _, _,
        _, _, _,
        Json_In.starter_oz, Water_Oz, Flour_Oz
    ),
    Json_Out = _{
        starterOz: Json_In.starter_oz,
        waterOz: Water_Oz,
        flourOz: Flour_Oz
    },
    reply_json_dict(Json_Out).


:- http_handler('/sourdough', sourdough_handler, []).

:- initialization(http_daemon).
