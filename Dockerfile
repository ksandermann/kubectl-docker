######################################################### TOOLCHAIN VERSIONING #########################################

ARG KUBECTL_VERSION

######################################################### BUILDER ######################################################
FROM alpine as builder
MAINTAINER Kevin Sandermann <kevin.sandermann@gmail.com>
LABEL maintainer="kevin.sandermann@gmail.com"

ARG KUBECTL_VERSION

USER root
WORKDIR /root/download

RUN apk --update add openssl wget

RUN wget https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl -O /root/download/kubectl

######################################################### IMAGE ########################################################
FROM bash:5.0.7
MAINTAINER Kevin Sandermann <kevin.sandermann@gmail.com>
LABEL maintainer="kevin.sandermann@gmail.com"

COPY --from=builder "/root/download/kubectl" "/usr/local/bin/kubectl"

RUN chmod +x "/usr/local/bin/kubectl" && \
    kubectl version --client=true

CMD ["kubectl"]