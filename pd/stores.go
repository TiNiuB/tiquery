package pd

import (
	"encoding/json"
	"time"
)

func getStores() ([]byte, error) {
	type PDStores struct {
		Count  int `json:"count"`
		Stores []struct {
			Meta struct {
				ID      int64  `json:"id"`
				Address string `json:"address"`
				Version string `json:"version"`
				State   string `json:"state_name"`
			} `json:"store"`
			Status struct {
				Capacity        ByteSize  `json:"capacity"`
				Available       ByteSize  `json:"available"`
				LeaderCount     int       `json:"leader_count"`
				RegionCount     int       `json:"region_count"`
				IsBusy          bool      `json:"is_busy"`
				StartTS         time.Time `json:"start_ts"`
				LastHeartbeatTS time.Time `json:"last_heartbeat_ts"`
				Uptime          Duration  `json:"uptime"`
			} `json:"status"`
		} `json:"stores"`
	}

	var pdStores PDStores
	if err := httpGet("/pd/api/v1/stores", &pdStores); err != nil {
		return nil, err
	}

	type Store struct {
		ID              int64  `json:"id"`
		Address         string `json:"address"`
		State           string `json:"state"`
		Version         string `json:"version"`
		Capacity        int64  `json:"capacity"`
		Available       int64  `json:"available"`
		LeaderCount     int64  `json:"leader_count"`
		RegionCount     int64  `json:"region_count"`
		IsBusy          bool   `json:"is_busy"`
		StartTS         string `json:"start_ts"`
		LastHeartbeatTS string `json:"last_heratbeat_ts"`
		Uptime          string `json:"uptime"`
	}

	stores := make([]Store, 0, pdStores.Count)
	for _, s := range pdStores.Stores {
		stores = append(stores, Store{
			ID:              s.Meta.ID,
			Address:         s.Meta.Address,
			State:           s.Meta.State,
			Version:         s.Meta.Version,
			Capacity:        int64(s.Status.Capacity),
			Available:       int64(s.Status.Available),
			LeaderCount:     int64(s.Status.LeaderCount),
			RegionCount:     int64(s.Status.RegionCount),
			IsBusy:          s.Status.IsBusy,
			StartTS:         s.Status.StartTS.String(),
			LastHeartbeatTS: s.Status.LastHeartbeatTS.String(),
			Uptime:          s.Status.Uptime.String(),
		})
	}

	data, err := json.Marshal(stores)
	return data, err
}
