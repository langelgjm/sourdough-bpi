test:
	swipl -g run_tests -g halt sourdough.pl

develop:
	swipl bpi.pl --fork=false --port=8000

get:
	curl 'http://127.0.0.1:8000/sourdough?starter_gm=200&water_gm=525&flour_gm=700&starter_oz=7.5'

post:
	curl -X POST -H "Content-Type: application/json" -d '{"starter_gm": 200, "water_gm": 525, "flour_gm": 700, "starter_oz": 7.5}' localhost:8000/sourdough
