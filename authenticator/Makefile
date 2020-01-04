NAME   		= kiesia/zd-security-challenge
TAG    		= $(shell git log -1 --pretty=%h)
IMG    		= ${NAME}:${TAG}
LATEST 		= ${NAME}:latest

build :
	docker build -t ${IMG} .
	docker tag ${IMG} ${LATEST}

push:
	docker push ${IMG}
