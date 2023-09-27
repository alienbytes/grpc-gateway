SWAGGER_UI_VERSION:=v4.15.5
BUF_VERSION:=v1.17.0
# generate: 
# 	protoc -I ./proto \
#   --go_out ./proto --go_opt paths=source_relative \
#   --go-grpc_out ./proto --go-grpc_opt paths=source_relative \
#   --grpc-gateway_out ./proto --grpc-gateway_opt paths=source_relative \
# 	--openapiv2_out . \
#     --openapiv2_opt logtostderr=true \
#     --openapiv2_opt use_go_templates=true \
#   ./proto/*.proto

# generate/swagger-ui:
# 	SWAGGER_UI_VERSION=$(SWAGGER_UI_VERSION) ./scripts/swagger.sh


# install:
# 	go get \
# 		github.com/bufbuild/buf/cmd/buf \
# 		github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
# 		github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2 \
# 		google.golang.org/grpc/cmd/protoc-gen-go-grpc \
# 		google.golang.org/protobuf/cmd/protoc-gen-go

run: 
	go run cmd/standalone/main.go
dev: 
	go run main.go


generate: generate/proto generate/swagger-ui
generate/proto:
	go run github.com/bufbuild/buf/cmd/buf@$(BUF_VERSION) generate
generate/swagger-ui:
	SWAGGER_UI_VERSION=$(SWAGGER_UI_VERSION) ./scripts/swagger.sh

lint:
	go run github.com/bufbuild/buf/cmd/buf@$(BUF_VERSION) lint
	go run github.com/bufbuild/buf/cmd/buf@$(BUF_VERSION) breaking --against 'https://github.com/johanbrandhorst/grpc-gateway-boilerplate.git#branch=main'