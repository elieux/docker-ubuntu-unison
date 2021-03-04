unison_version:=2.51.3

.PHONY: image
image: Dockerfile
	docker build . --build-arg unison_version=$(unison_version) -t elieux/ubuntu-unison:$(unison_version)-ubuntu20.04

.PHONY: upload
upload:
	docker push elieux/ubuntu-unison:$(unison_version)-ubuntu20.04
