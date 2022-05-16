# Self-Documented Makefile
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

tao-docker-run: ## TAO用コンテナを建てる
	docker-compose -f docker-compose.yaml up -d

tao-docker-build: ## TAO用コンテナをビルド
	docker-compose -f docker-compose.yaml build

tao-convert:
	docker exec -it faciallandmarks-tao-toolkit tao-converter -k nvidia_tlt -p input_face_images,1x1x80x80,32x1x80x80,32x1x80x80 \
		-t fp16 -d 1,80,80 -e /app/src/faciallandmarks.engine /app/src/faciallandmarks.etlt 

tao-docker-login: ## TAO用コンテナにログイン
	docker exec -it faciallandmarks-tao-toolkit bash


