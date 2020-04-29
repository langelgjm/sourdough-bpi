test:
	swipl -g run_tests -g halt sourdough.pl

develop:
	swipl bpi.pl --fork=false --port=8000

run:
	swipl bpi.pl --fork=true --port=8000

get:
	curl 'http://127.0.0.1:8000/sourdough?starterGm=200&waterGm=525&flourGm=700&starterOz=7.5'

post:
	curl -X POST -H "Content-Type: application/json" -d '{"starterGm": 200, "waterGm": 525, "flourGm": 700, "starterOz": 7.5}' localhost:8000/sourdough

swagger:
	docker pull swaggerapi/swagger-ui
	docker run -p 8080:8080 -e SWAGGER_JSON=/spec/swagger.yml -v $(shell pwd)/spec:/spec swaggerapi/swagger-ui
