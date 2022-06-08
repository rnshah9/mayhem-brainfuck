FROM --platform=linux/amd64 ubuntu:20.04 as builder

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential pkg-config bison flex

ADD . /Brainfuck
WORKDIR /Brainfuck
RUN make

RUN mkdir -p /deps
RUN ldd /Brainfuck/bin/bf2lua | tr -s '[:blank:]' '\n' | grep '^/' | xargs -I % sh -c 'cp % /deps;'

FROM ubuntu:20.04 as package

COPY --from=builder /deps /deps
COPY --from=builder /Brainfuck/bin/bf2lua /Brainfuck/bin/bf2lua
ENV LD_LIBRARY_PATH=/deps
