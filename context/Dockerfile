FROM maven:3.9.6-eclipse-temurin-11-alpine
LABEL maintainer "Andrea Zuccherelli <andrea@zuccherelli.net>"
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache \
    python3 \
    py3-pip \
    openssh
RUN mkdir /ansible-ee \
    && python3 -m venv /ansible-ee \
    && . /ansible-ee/bin/activate \
    && python3 -m pip install --user ansible-core
