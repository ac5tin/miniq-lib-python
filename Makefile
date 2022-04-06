TAG := $(shell git describe --tags `git rev-list --tags --max-count=1`)

check/tag:
	@echo "TAG: $(TAG)"
	@echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]

test:
	python -m unittest -v miniq/tests/*.py


protoc: protoc/clean
	python -m grpc_tools.protoc -I ./miniq/protobuf/ --python_out=./miniq/protobuf/ --grpc_python_out=./miniq/protobuf/ ./miniq/protobuf/*.proto

protoc/clean:
	rm -rf ./miniq/protobuf/*.py


lint:
	pylint miniq/*.py
