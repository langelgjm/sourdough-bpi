% BPI (Bread Programming Interface)

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_unix_daemon)).
:- use_module(library(settings)).

:- use_module(sourdough).
:- use_module(html_recipe).


:- set_setting(http:cors, [*]).

sourdough_handler(Request) :-
    member(method(get), Request),
    http_parameters(Request, [
        starterGm(Recipe_Starter_Gm, [number]),
        waterGm(Recipe_Water_Gm, [number]),
        flourGm(Recipe_Flour_Gm, [number]),
        starterOz(Starter_Oz, [number])
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
    cors_enable,
    reply_html_page([title(Title)], Html).


sourdough_handler(Request) :-
    member(method(post), Request),
    http_read_json_dict(Request, Json_In, []),
    sourdough(
        Json_In.starterGm, Json_In.waterGm, Json_In.flourGm,
        _, _, _,
        _, _, _,
        Json_In.starterOz, Water_Oz, Flour_Oz
    ),
    Json_Out = _{
        starterOz: Json_In.starterOz,
        waterOz: Water_Oz,
        flourOz: Flour_Oz
    },
    cors_enable,
    reply_json_dict(Json_Out).


sourdough_handler(Request) :-
    option(method(options), Request),
    !,
    cors_enable(
        Request,
        [
            methods([get,post])
        ]
    ),
    format('~n').


:- http_handler('/sourdough', sourdough_handler, []).

:- initialization(http_daemon).
