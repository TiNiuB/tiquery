package osquery

import (
	"encoding/json"
	"io/ioutil"
	"net/http"
	"os/exec"

	"github.com/gorilla/mux"
	"github.com/tiniub/tiquery/agent"
)

// Register service to router.
func Register(r *mux.Router) {
	r.HandleFunc("/osquery_{table}", func(w http.ResponseWriter, r *http.Request) {
		table := mux.Vars(r)["table"]
		var res []map[string]interface{}
		for _, agent := range agent.GetAgentList() {
			var partialRes []map[string]interface{}
			if err := httpGet(agent.Address, "/"+table, &partialRes); err == nil {
				for _, row := range partialRes {
					row["instance"] = agent.Instance
				}
				res = append(res, partialRes...)
			}
		}
		data, _ := json.Marshal(res)
		w.Write(data)
	})
}

// RegisterAgent registers the service for tiquery-agent.
func RegisterAgent(r *mux.Router) {
	r.HandleFunc("/{table}", func(w http.ResponseWriter, r *http.Request) {
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

		res, _ := json.Marshal(output)
		w.Write(res)
	})
}

func httpGet(address, uri string, data interface{}) error {
	res, err := http.Get("http://" + address + uri)
	if err != nil {
		return err
	}
	defer res.Body.Close()
	payload, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return err
	}
	return json.Unmarshal(payload, data)
}
