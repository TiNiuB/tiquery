package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/exec"
	"strings"
	"time"

	"github.com/gorilla/mux"
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

	go func() {
		data := fmt.Sprintf(`{"instance": "%v", "address": "%v"}`, *instanceName, *serviceAddr)
		http.Post("http://"+*tiqueryAddr+"/osquery/register", "application/json", strings.NewReader(data))
		time.Sleep(5 * time.Second)
	}()

	router := mux.NewRouter()
	router.HandleFunc("/{table}", func(w http.ResponseWriter, r *http.Request) {
		table := mux.Vars(r)["table"]
		cmd := exec.Command(`osqueryi`, `SELECT * FROM `+table, `--json`)
		out, err := cmd.CombinedOutput()
		if err != nil {
			w.WriteHeader(500)
			w.Write([]byte(err.Error()))
			return
		}

		var output []map[string]interface{}
		err = json.Unmarshal(out, &output)
		if err != nil {
			w.WriteHeader(500)
			w.Write([]byte(err.Error()))
			return
		}
		for _, x := range output {
			x["instance"] = *instanceName
		}

		res, _ := json.Marshal(output)
		w.Write(res)
	})

	http.ListenAndServe(*serviceAddr, router)
}
