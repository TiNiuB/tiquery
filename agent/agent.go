package agent

import (
	"encoding/json"
	"io/ioutil"
	"net/http"
	"sync"
	"time"

	"github.com/gorilla/mux"
)

// Agent is a service to collect remote data.
type Agent struct {
	Instance      string
	Address       string
	lastHeartbeat time.Time
}

type agentList struct {
	sync.Mutex
	agents map[string]Agent
}

func (al *agentList) register(instance, address string) {
	al.Lock()
	defer al.Unlock()
	al.agents[instance] = Agent{
		Instance:      instance,
		Address:       address,
		lastHeartbeat: time.Now(),
	}
}

func (al *agentList) getActiveAgents() []Agent {
	al.Lock()
	defer al.Unlock()
	var agents []Agent
	for instance, agent := range al.agents {
		if time.Since(agent.lastHeartbeat) < 3*time.Second {
			agents = append(agents, agent)
		} else {
			delete(al.agents, instance)
		}
	}
	return agents
}

// Register agent service to router.
func Register(r *mux.Router) {
	r.HandleFunc("/agent/register", func(w http.ResponseWriter, r *http.Request) {
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
		theAgentList.register(data.Instance, data.Address)
	})
}

// GetAgentList returns the active agents list.
func GetAgentList() []Agent {
	return theAgentList.getActiveAgents()
}

var theAgentList *agentList

func init() {
	theAgentList = &agentList{
		agents: make(map[string]Agent),
	}
}
