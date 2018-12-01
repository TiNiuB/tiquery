package tiquery

import (
	"net/http"

	"github.com/gorilla/mux"
	"github.com/tiniub/tiquery/agent"
	"github.com/tiniub/tiquery/osquery"
	"github.com/tiniub/tiquery/pd"
	"github.com/tiniub/tiquery/psutil"
)

// NewHandler returns an HTTP handler to provide all services.
func NewHandler() http.Handler {
	r := mux.NewRouter()
	agent.Register(r)
	pd.Register(r)
	osquery.Register(r)
	psutil.Register(r)
	return r
}
