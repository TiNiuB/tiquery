package pd

import "encoding/json"

func getRegions() ([]byte, error) {
	type PDRegions struct {
		Count   int `json:"count"`
		Regions []struct {
			ID          uint64 `json:"id"`
			StartKey    string `json:"start_key"`
			EndKey      string `json:"end_key"`
			RegionEpoch struct {
				ConfVer uint64 `json:"conf_ver"`
				Version uint64 `json:"version"`
			} `json:"epoch"`
			Leader struct {
				ID        uint64 `json:"id"`
				StoreID   uint64 `json:"store_id"`
				IsLearner bool   `json:"is_learner"`
			} `json:"leader"`
			WrittenBytes    uint64 `json:"written_bytes"`
			ReadBytes       uint64 `json:"read_bytes"`
			ApproximateSize int64  `json:"approximate_size"`
			ApproximateKeys int64  `json:"approximate_keys"`
		} `json:"regions"`
	}

	var pdRegions PDRegions
	if err := httpGet("/pd/api/v1/regions", &pdRegions); err != nil {
		return nil, err
	}

	type Region struct {
		ID              uint64 `json:"id"`
		StartKey        string `json:"start_key"`
		EndKey          string `json:"end_key"`
		ConfVer         uint64 `json:"conf_ver"`
		Version         uint64 `json:"version"`
		LeaderPeerID    uint64 `json:"leader_peer_id"`
		LeaderStoreID   uint64 `json:"leader_store_id"`
		WrittenBytes    uint64 `json:"written_bytes"`
		ReadBytes       uint64 `json:"read_bytes"`
		ApproximateSize int64  `json:"approximate_size"`
		ApproximateKeys int64  `json:"approximate_keys"`
	}

	regions := make([]Region, 0, pdRegions.Count)
	for _, r := range pdRegions.Regions {
		regions = append(regions, Region{
			ID:              r.ID,
			StartKey:        r.StartKey,
			EndKey:          r.EndKey,
			ConfVer:         r.RegionEpoch.ConfVer,
			Version:         r.RegionEpoch.Version,
			LeaderPeerID:    r.Leader.ID,
			LeaderStoreID:   r.Leader.StoreID,
			WrittenBytes:    r.WrittenBytes,
			ReadBytes:       r.ReadBytes,
			ApproximateSize: r.ApproximateSize,
			ApproximateKeys: r.ApproximateKeys,
		})
	}

	data, err := json.Marshal(regions)
	return data, err
}
