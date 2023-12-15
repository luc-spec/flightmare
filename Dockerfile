FROM ros:melodic-ros-base

ARG DEBIAN_FRONTEND=noninteractive 
ARG FLIGHTMARE_PATH=/flightmare
ENV FLIGHTMARE_PATH=/flightmare

# Installing some essential system packages
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 4B63CF8FDE49746E98FA01DDAD19BAB3CBF125EA
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
      lsb-release \
      build-essential \
      python3 python3-dev python3-pip \
      cmake \
      git \
      ca-certificates \
      libzmqpp-dev \
      libopencv-dev \
      gnupg2 \
      python3-setuptools \ 
      python3-catkin-tools

RUN apt-get clean autoclean &&\
    rm -rf /var/lib/apt/lists/*

RUN mkdir ${FLIGHTMARE_PATH}
COPY ./ /flightmare

RUN pip3 install -U pip wheel

WORKDIR ${FLIGHTMARE_PATH}/flightlib
RUN pip3 install . 

WORKDIR ${FLIGHTMARE_PATH}/flightrl
RUN pip3 install .
