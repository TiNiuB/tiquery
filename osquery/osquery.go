package osquery

import (
	"encoding/json"
	"io/ioutil"
	"net/http"
	"sync"
	"time"

	"github.com/gorilla/mux"
)

// Register service to router.
func Register(r *mux.Router) {
	r.HandleFunc("/osquery/register", func(w http.ResponseWriter, r *http.Request) {
		type Data struct {
			Instance string `json:"instance"`
			Address  string `json:"address"`
		}
		var data Data
		defer r.Body.Close()
		payload, err := ioutil.ReadAll(r.Body)
		if err != nil {
			w.WriteHeader(500)
			w.Write([]byte(err.Error()))
			return
		}
		err = json.Unmarshal(payload, &data)
		if err != nil {
			w.WriteHeader(500)
			w.Write([]byte(err.Error()))
			return
		}
		al.register(data.Instance, data.Address)
	})
	r.HandleFunc("/osquery_{table}", func(w http.ResponseWriter, r *http.Request) {
		table := mux.Vars(r)["table"]
		var res []map[string]interface{}
		for _, addr := range al.getAgents() {
			var partialRes []map[string]interface{}
			if err := httpGet(addr, "/"+table, &partialRes); err == nil {
				res = append(res, partialRes...)
			}
		}
		data, _ := json.Marshal(res)
		w.Write(data)
	})
}

// Agent is a service to exec osqueryi.
type Agent struct {
	address string
	ka      time.Time
}

// AgentList manages all active agents.
type AgentList struct {
	sync.RWMutex
	agents map[string]Agent
}

func (al *AgentList) register(name, address string) {
	al.Lock()
	defer al.Unlock()
	al.agents[name] = Agent{address: address, ka: time.Now()}
}

func (al *AgentList) getAgents() []string {
	al.RLock()
	defer al.RUnlock()
	var addrs []string
	for _, agent := range al.agents {
		if time.Since(agent.ka) < 3*time.Second {
			addrs = append(addrs, agent.address)
		}
	}
	return addrs
}

var al *AgentList

func init() {
	al = &AgentList{
		agents: make(map[string]Agent),
	}
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
