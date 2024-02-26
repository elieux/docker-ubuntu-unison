ubuntu_version:=22.04
unison_version:=2.53.4
tag:=elieux/ubuntu-unison:$(unison_version)-ubuntu$(ubuntu_version)

.PHONY: image
image: Dockerfile
	docker build . \
		--pull \
		--build-arg ubuntu_version=$(ubuntu_version) \
		--build-arg unison_version=$(unison_version) \
		-t $(tag)

.PHONY: upload
upload:
	docker push $(tag)
