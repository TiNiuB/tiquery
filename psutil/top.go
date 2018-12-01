package psutil

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/shirou/gopsutil/cpu"
	"github.com/shirou/gopsutil/process"
	"github.com/tiniub/tiquery/agent"
)

func Register(r *mux.Router) {
	r.HandleFunc("/psutil_memory", func(w http.ResponseWriter, r *http.Request) {
		var res []map[string]interface{}
		for _, agent := range agent.GetAgentList() {
			var partialRes []map[string]interface{}
			if err := httpGet(agent.Address, "/psutil/memory", &partialRes); err == nil {
				for _, row := range partialRes {
					row["instance"] = agent.Instance
				}
				res = append(res, partialRes...)
			}
		}
		data, _ := json.Marshal(res)
		w.Write(data)
	})

	r.HandleFunc("/psutil_cpu", func(w http.ResponseWriter, r *http.Request) {
		var res []map[string]interface{}
		for _, agent := range agent.GetAgentList() {
			var partialRes []map[string]interface{}
			if err := httpGet(agent.Address, "/psutil/cpu", &partialRes); err == nil {
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

func RegisterAgent(r *mux.Router) {
	r.HandleFunc("/psutil/memory", func(w http.ResponseWriter, r *http.Request) {
		pids, err := process.Pids()
		if err != nil {
			return
		}

		ret := make([]MemoryInfoStat, 0, len(pids))
		for _, pid := range pids {
			if p, err := process.NewProcess(pid); err == nil {
				m, err := p.MemoryInfo()
				if err != nil {
					continue
				}
				tmp := MemoryInfoStat{Pid: pid, MemoryInfoStat: *m}
				ret = append(ret, tmp)
			}
		}
		enc := json.NewEncoder(w)
		enc.Encode(ret)
	})

	r.HandleFunc("/psutil/cpu", func(w http.ResponseWriter, r *http.Request) {
		pids, err := process.Pids()
		if err != nil {
			return
		}

		ret := make([]TimesStat, 0, len(pids))
		for _, pid := range pids {
			if p, err := process.NewProcess(pid); err == nil {
				stat, err := p.Times()
				if err != nil {
					continue
				}
				tmp := TimesStat{Pid: pid, TimesStat: *stat}
				fmt.Println(".........", tmp)
				ret = append(ret, tmp)
			}
		}
		enc := json.NewEncoder(w)
		enc.Encode(ret)
	})
}

type TimesStat struct {
	Pid int32 `json:"pid"`
	cpu.TimesStat
}

type MemoryInfoStat struct {
	Pid int32 `json:"pid"`
	process.MemoryInfoStat
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
