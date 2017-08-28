container_name     := telegraf
container_registry := quay.io/nordstrom
container_release  := 1.4.0-1

build:
	docker build \
		--build-arg "HTTP_PROXY=$(HTTP_PROXY)" \
		--build-arg "HTTPS_PROXY=$(HTTP_PROXY)" \
		--tag $(container_name) .

tag: build
	docker tag $(container_name) $(container_registry)/$(container_name):$(container_release)

push: tag
	docker push $(container_registry)/$(container_name):$(container_release)
