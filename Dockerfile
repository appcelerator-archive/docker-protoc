FROM golang:1.7-alpine

# protoc: download source, build and install (required by protoc-gen-go)
RUN apk --no-cache add --virtual .builddeps \
        curl unzip autoconf automake make libtool g++ && \
    apk --no-cache add libstdc++ git && \
    git clone https://github.com/google/protobuf.git --branch v3.0.0 --depth 1 && \
    cd protobuf && \
    ./autogen.sh && \
    ./configure && \
    make -j 3 && \
    make install && \
    make clean && \
    cd .. && rm -r protobuf && \
    apk del .builddeps && \
    rm -rf /var/cache/apk/*

# Get the source from GitHub
RUN go get google.golang.org/grpc

# Install protoc-gen-go
RUN go get github.com/golang/protobuf/protoc-gen-go

WORKDIR /go/src
ENTRYPOINT [ "protoc" ]
CMD [ "--go_out=plugins=grpc:." ]
