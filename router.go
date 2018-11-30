package tiquery

import (
	"net/http"

	"github.com/gorilla/mux"
	"github.com/tiniub/tiquery/osquery"
	"github.com/tiniub/tiquery/pd"
)

// NewHandler returns an HTTP handler to provide all services.
func NewHandler() http.Handler {
	r := mux.NewRouter()
	pd.Register(r)
	osquery.Register(r)
	return r
}
