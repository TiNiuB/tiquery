package main

import (
	"flag"
	"net/http"

	"github.com/tiniub/tiquery"
)

var serviceAddr = flag.String("addr", ":8080", "HTTP service address")

func main() {
	flag.Parse()
	http.ListenAndServe(*serviceAddr, tiquery.NewHandler())
}
