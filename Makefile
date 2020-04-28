VERSION=$(shell git rev-parse --short HEAD)
ENV="nestjs-eb-multi-container-docker-dev"

prepare_archive:
	git archive --format=zip -o app.zip HEAD; zip -d app.zip "Dockerfile"

clean_archive:
	rm app.zip

deploy_app: prepare_archive
	eb deploy $(ENV) --label app-$(VERSION)

deploy: deploy_app clean_archive