package pd

import (
	"encoding/json"
	"flag"
	"io/ioutil"
	"net/http"

	"github.com/gorilla/mux"
)

var pdAddr = flag.String("pd-addr", "127.0.0.1:2379", "pd server address")

// Register service to router.
func Register(r *mux.Router) {
	r.HandleFunc("/pd_store", handlerFunc(getStores))
	r.HandleFunc("/pd_store_label", handlerFunc(getStoreLabels))
	r.HandleFunc("/pd_region", handlerFunc(getRegions))
}

func handlerFunc(f func() ([]byte, error)) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		data, err := f()
		if err != nil {
			w.WriteHeader(500)
			w.Write([]byte(err.Error()))
			return
		}
		w.Write(data)
	}
}

func httpGet(uri string, data interface{}) error {
	res, err := http.Get("http://" + *pdAddr + uri)
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
