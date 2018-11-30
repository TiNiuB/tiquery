default: tiquery osquery-agent

tiquery:
	go build -o bin/tiquery cmd/tiquery/main.go

osquery-agent:
	go build -o bin/osquery-agent cmd/osquery-agent/main.go