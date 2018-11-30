package pd

import "encoding/json"

func getStoreLabels() ([]byte, error) {
	type PDStores struct {
		Stores []struct {
			Meta struct {
				ID     int64 `json:"id"`
				Labels []struct {
					Key   string `json:"key"`
					Value string `json:"value"`
				} `json:"labels"`
			} `json:"store"`
		} `json:"stores"`
	}

	var pdStores PDStores
	if err := httpGet("/pd/api/v1/stores", &pdStores); err != nil {
		return nil, err
	}

	type StoreLabel struct {
		ID         int64  `json:"id"`
		LabelKey   string `json:"label_key"`
		LabelValue string `json:"label_value"`
	}

	var storeLabels []StoreLabel
	for _, s := range pdStores.Stores {
		for _, l := range s.Meta.Labels {
			storeLabels = append(storeLabels, StoreLabel{
				ID:         s.Meta.ID,
				LabelKey:   l.Key,
				LabelValue: l.Value,
			})
		}
	}

	data, err := json.Marshal(storeLabels)
	return data, err
}
