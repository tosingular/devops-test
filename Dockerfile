FROM golang:1.20
WORKDIR /app/
COPY .build/ /app
CMD ["./devops-test"]