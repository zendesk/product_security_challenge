NAME   		= kiesia/zd-security-challenge
TAG    		= $(shell git log -1 --pretty=%h)
IMG    		= ${NAME}:${TAG}
LATEST 		= ${NAME}:latest

build :
	docker build -t ${IMG} .
	docker tag ${IMG} ${LATEST}

bundle :
	docker-compose run --rm --no-deps --user=root --entrypoint "" app bundle install

test :
	docker-compose run --rm app rspec spec/

push:
	docker push ${IMG}

restart :
	touch tmp/restart.txt

.PHONY: test
