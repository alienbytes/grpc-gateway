# Build stage
FROM golang AS build-env
ADD . /src/gateway
ENV CGO_ENABLED=0
RUN cd /src/gateway && go build -o /app

# Production stage
FROM scratch
COPY --from=build-env /app /

ENTRYPOINT ["/app"]