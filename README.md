# Sourdough BPI (Bread Programming Interface)

When making sourdough bread, sometimes one wishes to use more (or less) starter than the recipe calls for, but without adjusting the overall amount of dough.

While this is a simple arithmetic excercise, it is better to automate it.

In general, we use the following recipe for proportions: https://thepioneerwoman.com/food-and-friends/how-to-make-artisan-sourdough-bread/ but any recipe will work.

## Installation

This BPI requires SWIPL Prolog. Swagger requires docker.

## Usage

Run

    make run

Then use the `GET` or `POST` endpoints to adjust the recipe..

## Documentation

Run

    make run && make swagger

to view the Swagger documentation and try out the endpoints.

## Caveats

The starter water/flour ratio is currently fixed at 1:1.

## Tests

Run

    make test

to run the tests.

## Implementations

### Prolog

The Prolog implementation provides a `sourdough/12` predicate that will relate the following variables:

* Expected_Starter_Gm
* Expected_Water_Gm
* Expected_Flour_Gm
* Expected_Starter_Oz
* Expected_Water_Oz
* Expected_Flour_Oz
* Actual_Starter_Gm
* Actual_Water_Gm
* Actual_Flour_Gm
* Actual_Starter_Oz
* Actual_Water_Oz
* Actual_Flour_Oz

The API assumes you will provide:

* Expected_Starter_Gm
* Expected_Water_Gm
* Expected_Flour_Gm
* Actual_Starter_Oz

It will return:

* Actual_Starter_Oz
* Actual_Water_Oz
* Actual_Flour_Oz

Either as an HTML page or a JSON object, depending on the request method.

### Scala

TODO
