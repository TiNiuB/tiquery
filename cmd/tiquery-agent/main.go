package main

import (
	"flag"
	"log"
	"net/http"
	"os"

	"github.com/BurntSushi/toml"
	"github.com/gorilla/mux"
	"github.com/tiniub/tiquery/agent"
	"github.com/tiniub/tiquery/osquery"
	"github.com/tiniub/tiquery/psutil"
)

var (
	tiqueryAddr  = flag.String("tiquery-addr", "127.0.0.1:8080", "tiquery address")
	agentAddr    = flag.String("addr", "127.0.0.1:8081", "agent service address")
	instanceName = flag.String("instance", "", "instance name")
	configFile   = flag.String("c", "agent.toml", "config file")
)

// Config is used for parsing config file.
type Config struct {
	Services []agent.Service `toml:"service"`
}

func main() {
	flag.Parse()

	if len(*instanceName) == 0 {
		hostname, err := os.Hostname()
		if err != nil {
			log.Fatal(err)
		}
		*instanceName = hostname
	}

	agt := agent.NewAgent()
	agt.Instance = *instanceName
	agt.Address = *agentAddr

	if len(*configFile) > 0 {
		var conf Config
		_, err := toml.DecodeFile(*configFile, &conf)
		if err != nil {
			log.Fatal(err)
		}
		agt.Services = conf.Services
	}

	agent.RegisterAndKeepalive(*tiqueryAddr, agt)

	router := mux.NewRouter()
	osquery.RegisterAgent(router)
	psutil.RegisterAgent(router)

	http.ListenAndServe(*agentAddr, router)
}
