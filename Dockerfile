FROM golang:1.21-alpine AS build

RUN apk add --no-cache git

WORKDIR /src

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o /bin/ws-echo ./cmd/ws-echo

FROM scratch
COPY --from=build /bin/ws-echo /bin/ws-echo

EXPOSE 1400
ENTRYPOINT ["/bin/ws-echo"]
