package osquery

import (
	"encoding/json"
	"io/ioutil"
	"net/http"

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
				res = append(res, partialRes...)
			}
		}
		data, _ := json.Marshal(res)
		w.Write(data)
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
