container_name     := telegraf
container_registry := quay.io/nordstrom
container_release  := 1.3.0-1

.PHONY: build/image tag/image push/image

build/image:
	docker build \
		--build-arg "HTTP_PROXY=$(HTTP_PROXY)" \
		--build-arg "HTTPS_PROXY=$(HTTP_PROXY)" \
		--tag $(container_name) .

tag/image: build/image
	docker tag $(container_name) $(container_registry)/$(container_name):$(container_release)

push/image: tag/image
	docker push $(container_registry)/$(container_name):$(container_release)
