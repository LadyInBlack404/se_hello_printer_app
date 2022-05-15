.PHONY: deps test

deps:
	pip install -r requirements.txt; \
		pip install -r test_requirements.txt

lint:
	flake8 --exit-zero hello_world test

test:
	PYTHONPATH=. py.test --verbose -s

run:
	PYTHONPATH=. FLASK_APP=hello_world flask run

docker_build:
	docker build -t hello-world-printer .

docker_run: docker_build
		docker_run \
		--name hello_world_printer-dev \
		-p 5000:5000 \
		-d hello_world_printer

test_smoke:
	curl -s -o /dev/null -w "%{http_code}" --fail 127.0.0.1:5000
