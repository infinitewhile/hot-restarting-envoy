defaut: clean build start

clean: 
	docker kill test_envoy || true
	docker rm test_envoy || true
	docker image rm hot-restarting-envoy:v1.14.1 || true

build:
	./build-container.sh

start:
	./start.sh