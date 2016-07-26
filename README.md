# protoc

Simplified Docker image for generating protocol buffer bindings with gRPC support. Based on Alpine with latest protocol buffer (proto3) and gRPC versions.

Usage:

    docker run -it -v $PWD:/go/src protoc *.proto

If you want to disable the gRPC support or add other options, you will need to explicitly override
the entrypoint and specify exactly what you want. Ex:

    docker run -it -v $PWD:/go/src --entrypoint protoc protoc --go_out=. *.proto
