package main

import (
	"flag"
	"log"
	"net/http"
	"os"

	"github.com/tiniub/tiquery/osquery"

	"github.com/gorilla/mux"
	"github.com/tiniub/tiquery/agent"
)

var (
	tiqueryAddr  = flag.String("tiquery-addr", "127.0.0.1:8080", "tiquery address")
	serviceAddr  = flag.String("addr", "127.0.0.1:8081", "service address")
	instanceName = flag.String("instance", "", "instance name")
)

func main() {
	flag.Parse()

	if len(*instanceName) == 0 {
		hostname, err := os.Hostname()
		if err != nil {
			log.Fatal(err)
		}
		*instanceName = hostname
	}

	agent.RegisterAndKeepalive(*tiqueryAddr, *instanceName, *serviceAddr)

	router := mux.NewRouter()
	osquery.RegisterAgent(router)

	http.ListenAndServe(*serviceAddr, router)
}
