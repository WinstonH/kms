FROM alpine:latest
ENV PORT 1688
RUN set -ex \
&& apk upgrade --no-cache \
&& apk --update --no-cache add curl
&& VERSION=$(curl -s https://api.github.com/repos/Wind4/vlmcsd/releases/latest | grep tag_name | awk  -F '"' '{print $4}') \
&& mkdir kms \
&& wget https://github.com/Wind4/vlmcsd/releases/download/$VERSION/binaries.tar.gz \
&& tar -xzvf binaries.tar.gz \
&& cd binaries/Linux/intel/static/ \
&& cp -rf vlmcsd-x64-musl-static /kms/ \
&& rm -rf /binaries*
EXPOSE $PORT

CMD /kms/vlmcsd-x64-musl-static -L 0.0.0.0:$PORT -Dev
