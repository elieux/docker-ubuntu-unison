FROM ubuntu:20.04 AS build
ARG unison_version
WORKDIR /tmp

RUN true \
&& apt update \
&& env DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
	ca-certificates \
	curl \
	make \
	ocaml-nox \
&& rm -Rf /var/{cache/apt,lib/apt/lists,log/{alternatives.log,apt,dpkg.log}} \
&& true

RUN curl -sL https://github.com/bcpierce00/unison/archive/v${unison_version}.tar.gz | tar -xzf -

RUN true \
&& make -C unison-${unison_version}/src/ UISTYLE=text \
&& mkdir -p /tmp/install/usr/local/bin \
&& cp unison-${unison_version}/src/unison /tmp/install/usr/local/bin/ \
&& true


FROM ubuntu:20.04
COPY --from=build /tmp/install /
