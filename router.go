package tiquery

import (
	"net/http"

	"github.com/gorilla/mux"
)

// NewHandler returns an HTTP handler to provide all services.
func NewHandler() http.Handler {
	r := mux.NewRouter()
	return r
}
