ARG ubuntu_version


FROM ubuntu:${ubuntu_version} AS build
ARG unison_version
WORKDIR /tmp

RUN : \
&& apt update \
&& env DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
	ca-certificates \
	curl \
	make \
	ocaml-nox \
&& rm -Rf /var/{cache/apt,lib/apt/lists,log/{alternatives.log,apt,dpkg.log}} \
;

RUN curl -sL https://github.com/bcpierce00/unison/archive/v${unison_version}.tar.gz | tar -xzf -

RUN : \
&& make -C unison-${unison_version}/src/ \
&& mkdir -p /tmp/install/usr/local/bin \
&& cp unison-${unison_version}/src/unison /tmp/install/usr/local/bin/ \
;


FROM ubuntu:${ubuntu_version}
COPY --from=build /tmp/install /
