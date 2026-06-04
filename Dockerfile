FROM debian:trixie

RUN apt update
RUN apt install -y curl
RUN apt install -y libatomic1
RUN apt install -y libgomp1

ARG ARTIFACT_DOWNLOAD_URL="llmster.lmstudio.ai/download"
ARG APP_VERSION="0.0.15-2"
ARG APP_VARIANT="full"
ARG ZIP_EXT=".tar.gz"

RUN --mount=type=cache,target=/tmp case "$(uname -sm)" in \
	"Linux x86_64") \
		curl -sL "$ARTIFACT_DOWNLOAD_URL/${APP_VERSION}-linux-x64.${APP_VARIANT}$ZIP_EXT" | tar -xvz -C /tmp \
	;; \
	"Linux aarch64"|"Linux arm64") \
		curl -sL "$ARTIFACT_DOWNLOAD_URL/${APP_VERSION}-linux-arm64.${APP_VARIANT}$ZIP_EXT" | tar -xvz -C /tmp \
	;; \
    esac

RUN --mount=type=cache,target=/tmp /tmp/llmster bootstrap

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.lmstudio/bin
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
VOLUME /root/.lmstudio/models

