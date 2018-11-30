package pd

import "encoding/json"

func getRegionPeers() ([]byte, error) {
	type PDRegions struct {
		Count   int `json:"count"`
		Regions []struct {
			ID    uint64 `json:"id"`
			Peers []struct {
				ID        uint64 `json:"id"`
				StoreID   uint64 `json:"store_id"`
				IsLearner bool   `json:"is_learner"`
			}
			Leader struct {
				ID uint64 `json:"id"`
			} `json:"leader"`
			DownPeers []struct {
				Peer struct {
					ID uint64 `json:"id"`
				} `json:"peer"`
			} `json:"down_peers"`
			PendingPeers []struct {
				ID uint64 `json:"id"`
			} `json:"pending_peers"`
		} `json:"regions"`
	}

	var pdRegions PDRegions
	if err := httpGet("/pd/api/v1/regions", &pdRegions); err != nil {
		return nil, err
	}

	type RegionPeer struct {
		ID        uint64 `json:"id"`
		RegionID  uint64 `json:"region_id"`
		StoreID   uint64 `json:"store_id"`
		IsLeader  bool   `json:"is_leader"`
		IsDown    bool   `json:"is_down"`
		IsPending bool   `json:"is_pending"`
	}

	var regionPeers []RegionPeer
	for _, r := range pdRegions.Regions {
		for _, p := range r.Peers {
			peer := RegionPeer{
				ID:       p.ID,
				RegionID: r.ID,
				StoreID:  p.StoreID,
				IsLeader: p.IsLearner,
			}
			for _, downPeer := range r.DownPeers {
				if downPeer.Peer.ID == p.ID {
					peer.IsDown = true
				}
			}
			for _, pendingPeer := range r.PendingPeers {
				if pendingPeer.ID == p.ID {
					peer.IsPending = true
				}
			}
			regionPeers = append(regionPeers, peer)
		}
	}

	data, err := json.Marshal(regionPeers)
	return data, err
}
