package pd

import (
	"encoding/json"
	"fmt"
)

func getConfigs() ([]byte, error) {
	type PDConfigs struct {
		Name                    string `json:"name"`
		DataDir                 string `json:"data-dir"`
		ClientUrls              string `json:"client-urls"`
		PeerUrls                string `json:"peer-urls"`
		AdvertiseClientUrls     string `json:"advertise-client-urls"`
		AdvertisePeerUrls       string `json:"advertise-peer-urls"`
		LeaderLease             int64  `json:"lease"`
		TsoSaveInterval         string `json:"tso-save-interval"`
		ClusterVersion          string `json:"cluster-version"`
		QuotaBackendBytes       string `json:"quota-backend-bytes"`
		AutoCompactionMode      string `json:"auto-compaction-mode"`
		AutoCompactionRetention string `json:"auto-compaction-retention-v2"`
		NamespaceClassifier     string `json:"namespace-classifier"`

		Schedule struct {
			MaxSnapshotCount             uint64  `json:"max-snapshot-count"`
			MaxPendingPeerCount          uint64  `json:"max-pending-peer-count"`
			MaxMergeRegionSize           uint64  `json:"max-merge-region-size"`
			MaxMergeRegionKeys           uint64  `json:"max-merge-region-keys"`
			SplitMergeInterval           string  `json:"split-merge-interval"`
			PatrolRegionInterval         string  `json:"patrol-region-interval"`
			MaxStoreDownTime             string  `json:"max-store-down-time"`
			LeaderScheduleLimit          uint64  `json:"leader-schedule-limit"`
			RegionScheduleLimit          uint64  `json:"region-schedule-limit"`
			ReplicaScheduleLimit         uint64  `json:"replica-schedule-limit"`
			MergeScheduleLimit           uint64  `json:"merge-schedule-limit"`
			TolerantSizeRatio            float64 `json:"tolerant-size-ratio"`
			LowSpaceRatio                float64 `json:"low-space-ratio"`
			HighSpaceRatio               float64 `json:"high-space-ratio"`
			DisableLearner               bool    `json:"disable-raft-learner,string"`
			DisableRemoveDownReplica     bool    `json:"disable-remove-down-replica,string"`
			DisableReplaceOfflineReplica bool    `json:"disable-replace-offline-replica,string"`
			DisableMakeUpReplica         bool    `json:"disable-make-up-replica,string"`
			DisableRemoveExtraReplica    bool    `json:"disable-remove-extra-replica,string"`
			DisableLocationReplacement   bool    `json:"disable-location-replacement,string"`
			DisableNamespaceRelocation   bool    `json:"disable-namespace-relocation,string"`
		} `json:"schedule"`

		Replication struct {
			MaxReplicas    uint64 `json:"max-replicas"`
			LocationLabels string `json:"location-labels"`
		} `json:"replication"`
	}

	var pdConfigs PDConfigs
	if err := httpGet("/pd/api/v1/config", &pdConfigs); err != nil {
		return nil, err
	}

	type Config struct {
		Module string `json:"module"`
		Key    string `json:"key"`
		Value  string `json:"value"`
	}

	var configs []Config
	configs = append(configs, Config{Module: "main", Key: "name", Value: fmt.Sprintf("%v", pdConfigs.Name)})
	configs = append(configs, Config{Module: "main", Key: "data_dir", Value: fmt.Sprintf("%v", pdConfigs.DataDir)})
	configs = append(configs, Config{Module: "main", Key: "client_urls", Value: fmt.Sprintf("%v", pdConfigs.ClientUrls)})
	configs = append(configs, Config{Module: "main", Key: "peer_urls", Value: fmt.Sprintf("%v", pdConfigs.PeerUrls)})
	configs = append(configs, Config{Module: "main", Key: "advertise_client_urls", Value: fmt.Sprintf("%v", pdConfigs.AdvertiseClientUrls)})
	configs = append(configs, Config{Module: "main", Key: "advertise_peer_urls", Value: fmt.Sprintf("%v", pdConfigs.AdvertisePeerUrls)})
	configs = append(configs, Config{Module: "main", Key: "lease", Value: fmt.Sprintf("%v", pdConfigs.LeaderLease)})
	configs = append(configs, Config{Module: "main", Key: "tso_save_interval", Value: fmt.Sprintf("%v", pdConfigs.TsoSaveInterval)})
	configs = append(configs, Config{Module: "main", Key: "cluster_version", Value: fmt.Sprintf("%v", pdConfigs.ClusterVersion)})
	configs = append(configs, Config{Module: "main", Key: "quota_backend_bytes", Value: fmt.Sprintf("%v", pdConfigs.QuotaBackendBytes)})
	configs = append(configs, Config{Module: "main", Key: "auto_compaction_mode", Value: fmt.Sprintf("%v", pdConfigs.AutoCompactionMode)})
	configs = append(configs, Config{Module: "main", Key: "auto_compaction_retention", Value: fmt.Sprintf("%v", pdConfigs.AutoCompactionRetention)})
	configs = append(configs, Config{Module: "main", Key: "namespace_classifier", Value: fmt.Sprintf("%v", pdConfigs.NamespaceClassifier)})

	configs = append(configs, Config{Module: "schedule", Key: "max_snapshot_count", Value: fmt.Sprintf("%v", pdConfigs.Schedule.MaxSnapshotCount)})
	configs = append(configs, Config{Module: "schedule", Key: "max_pending_peer_count", Value: fmt.Sprintf("%v", pdConfigs.Schedule.MaxPendingPeerCount)})
	configs = append(configs, Config{Module: "schedule", Key: "max_merge_region_size", Value: fmt.Sprintf("%v", pdConfigs.Schedule.MaxMergeRegionSize)})
	configs = append(configs, Config{Module: "schedule", Key: "max_merge_region_keys", Value: fmt.Sprintf("%v", pdConfigs.Schedule.MaxMergeRegionKeys)})
	configs = append(configs, Config{Module: "schedule", Key: "split_merge_interval", Value: fmt.Sprintf("%v", pdConfigs.Schedule.SplitMergeInterval)})
	configs = append(configs, Config{Module: "schedule", Key: "patrol_region_interval", Value: fmt.Sprintf("%v", pdConfigs.Schedule.PatrolRegionInterval)})
	configs = append(configs, Config{Module: "schedule", Key: "max_store_down_time", Value: fmt.Sprintf("%v", pdConfigs.Schedule.MaxStoreDownTime)})
	configs = append(configs, Config{Module: "schedule", Key: "leader_schedule_limit", Value: fmt.Sprintf("%v", pdConfigs.Schedule.LeaderScheduleLimit)})
	configs = append(configs, Config{Module: "schedule", Key: "region_schedule_limit", Value: fmt.Sprintf("%v", pdConfigs.Schedule.RegionScheduleLimit)})
	configs = append(configs, Config{Module: "schedule", Key: "replica_schedule_limit", Value: fmt.Sprintf("%v", pdConfigs.Schedule.ReplicaScheduleLimit)})
	configs = append(configs, Config{Module: "schedule", Key: "merge_schedule_limit", Value: fmt.Sprintf("%v", pdConfigs.Schedule.MergeScheduleLimit)})
	configs = append(configs, Config{Module: "schedule", Key: "tolerant_size_ratio", Value: fmt.Sprintf("%v", pdConfigs.Schedule.TolerantSizeRatio)})
	configs = append(configs, Config{Module: "schedule", Key: "low_space_ratio", Value: fmt.Sprintf("%v", pdConfigs.Schedule.LowSpaceRatio)})
	configs = append(configs, Config{Module: "schedule", Key: "high_space_ratio", Value: fmt.Sprintf("%v", pdConfigs.Schedule.HighSpaceRatio)})
	configs = append(configs, Config{Module: "schedule", Key: "disable_raft_learner", Value: fmt.Sprintf("%v", pdConfigs.Schedule.DisableLearner)})
	configs = append(configs, Config{Module: "schedule", Key: "disable_remove_down_replica", Value: fmt.Sprintf("%v", pdConfigs.Schedule.DisableRemoveDownReplica)})
	configs = append(configs, Config{Module: "schedule", Key: "disable_replace_offline_replica", Value: fmt.Sprintf("%v", pdConfigs.Schedule.DisableReplaceOfflineReplica)})
	configs = append(configs, Config{Module: "schedule", Key: "disable_make_up_replica", Value: fmt.Sprintf("%v", pdConfigs.Schedule.DisableMakeUpReplica)})
	configs = append(configs, Config{Module: "schedule", Key: "disable_remove_extra_replica", Value: fmt.Sprintf("%v", pdConfigs.Schedule.DisableRemoveExtraReplica)})
	configs = append(configs, Config{Module: "schedule", Key: "disable_location_replacement", Value: fmt.Sprintf("%v", pdConfigs.Schedule.DisableLocationReplacement)})
	configs = append(configs, Config{Module: "schedule", Key: "disable_namespace_relocation", Value: fmt.Sprintf("%v", pdConfigs.Schedule.DisableNamespaceRelocation)})

	configs = append(configs, Config{Module: "replication", Key: "max_replicas", Value: fmt.Sprintf("%v", pdConfigs.Replication.MaxReplicas)})
	configs = append(configs, Config{Module: "replication", Key: "location_labels", Value: fmt.Sprintf("%v", pdConfigs.Replication.LocationLabels)})

	data, err := json.Marshal(configs)
	return data, err
}
