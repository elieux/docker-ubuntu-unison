ubuntu_version:=26.04
unison_version:=2.54.0
tag:=elieux/ubuntu-unison:$(unison_version)-ubuntu$(ubuntu_version)

.PHONY: build
build: Dockerfile
	docker build . \
		--pull \
		--build-arg ubuntu_version=$(ubuntu_version) \
		--build-arg unison_version=$(unison_version) \
		-t $(tag)

.PHONY: push
push:
	docker push $(tag)
