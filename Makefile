TAG := $(shell git describe --tags `git rev-list --tags --max-count=1`)

prepare:
	pip install --upgrade pip
	pip install -r requirements.txt
	pip install pylint grpcio-tools setuptools wheel twine

check/tag:
	@echo "TAG: $(TAG)"
	@echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]

test:
	python -m unittest -v miniq/tests/*.py


protoc: protoc/clean
	python -m grpc_tools.protoc -I ./miniq/protobuf/ --python_out=./miniq/protobuf/ --grpc_python_out=./miniq/protobuf/ ./miniq/protobuf/*.proto
	@cd ./miniq/protobuf && for file in *.py; do \
		sed -i "/import .*_pb2/ s/^import /from . import /g" $$file; \
	done

protoc/clean:
	rm -rf ./miniq/protobuf/*.py


lint:
	pylint miniq/*.py



@package/bundle: @packages/clean
	python setup.py sdist bdist_wheel

@package/publish:
	python -m twine upload dist/* --verbose

@packages/publish-test:
	twine upload --repository testpypi dist/*

@packages/clean:
	rm -rf ./miniq.egg-info
	rm -rf ./build
	rm -rf ./dist