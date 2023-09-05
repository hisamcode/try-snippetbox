FROM golang:alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -v -o ./web ./cmd/web/

FROM alpine
WORKDIR /app
COPY --from=builder /app/web ./web
CMD ./web -notls -addr :3200 -dsn "snippetbox:snippetbox@tcp(db:3306)/snippetbox?parseTime=true"
