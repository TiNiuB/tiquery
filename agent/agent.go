package agent

import (
	"bytes"
	"encoding/json"
	"io/ioutil"
	"net/http"
	"sync"
	"time"

	"github.com/gorilla/mux"
)

var agentHeartbeatInterval = time.Second

// Service defines a service in tidb cluster.
type Service struct {
	Type    string `toml:"type" json:"type"`
	Name    string `toml:"name" json:"name"`
	Port    int    `toml:"port" json:"port"`
	LogFile string `toml:"log_file" json:"log_file"`
}

// Agent is a service to collect remote data.
type Agent struct {
	Instance      string    `json:"instance"`
	Address       string    `json:"address"`
	Services      []Service `json:"services"`
	lastHeartbeat time.Time
}

// NewAgent returns an agent instance.
func NewAgent() *Agent {
	return &Agent{}
}

type agentList struct {
	sync.Mutex
	agents map[string]*Agent
}

func (al *agentList) register(agent *Agent) {
	al.Lock()
	defer al.Unlock()
	agent.lastHeartbeat = time.Now()
	al.agents[agent.Instance] = agent
}

func (al *agentList) getActiveAgents() []*Agent {
	al.Lock()
	defer al.Unlock()
	var agents []*Agent
	for instance, agent := range al.agents {
		if time.Since(agent.lastHeartbeat) < agentHeartbeatInterval*3 {
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
		defer r.Body.Close()
		payload, err := ioutil.ReadAll(r.Body)
		if err != nil {
			w.WriteHeader(500)
			w.Write([]byte(err.Error()))
			return
		}
		var agt Agent
		err = json.Unmarshal(payload, &agt)
		if err != nil {
			w.WriteHeader(500)
			w.Write([]byte(err.Error()))
			return
		}
		theAgentList.register(&agt)
	})

	r.HandleFunc("/service", func(w http.ResponseWriter, r *http.Request) {
		type ServiceData struct {
			Instance string `json:"instance"`
			Service
		}
		var services []ServiceData
		for _, agt := range GetAgentList() {
			for _, s := range agt.Services {
				services = append(services, ServiceData{
					Instance: agt.Instance,
					Service:  s,
				})
			}
		}
		data, _ := json.Marshal(services)
		w.Write(data)
	})
}

// RegisterAndKeepalive registers an agent to tiquery and keep it active state.
func RegisterAndKeepalive(tiqueryAddr string, agt *Agent) {
	go func() {
		for {
			data, _ := json.Marshal(agt)
			http.Post("http://"+tiqueryAddr+"/agent/register", "application/json", bytes.NewReader(data))
			time.Sleep(agentHeartbeatInterval)
		}
	}()
}

// GetAgentList returns the active agents list.
func GetAgentList() []*Agent {
	return theAgentList.getActiveAgents()
}

var theAgentList *agentList

func init() {
	theAgentList = &agentList{
		agents: make(map[string]*Agent),
	}
}
