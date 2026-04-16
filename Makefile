# Makefile for convenience, (doesn't look for command outputs)
.PHONY: all
all: vrepatate

# Setting environment variables from .env file
# "-" == "if exists" , do not forget to copy .env.template to .env
-include .env

.PHONY: vrepatate
vrepatate : conda-lock apt docker

conda-lock:
	cd vrepatate ; \
	conda-lock lock -f environment.yml -f ../.base_layer/base-notebook-environment.yml  -f ../.base_layer/pangeo-notebook-environment.yml  -p linux-64  --no-mamba; \
	conda-lock render -k explicit -p linux-64; \
	../generate-packages-list.py conda-linux-64.lock > packages.txt

apt:
	cd vrepatate ; \
	../merge-apt.sh ../.base_layer/base-notebook-apt.txt apt.txt ../.base_layer/pangeo-notebook-apt.txt  apt.txt

docker:
	docker build -t cnes/vrepatate:master . --progress=plain --platform linux/amd64; \
	docker run -w $(TESTDIR) -v $(PWD):$(TESTDIR) cnes/vrepatate:master ./run_tests.sh vrepatate


update:
	python update_base_layer.py