default: tiquery tiquery-agent

tiquery:
	GO111MODULE=on go build -o bin/tiquery cmd/tiquery/main.go

tiquery-agent:
	GO111MODULE=on go build -o bin/tiquery-agent cmd/tiquery-agent/main.go