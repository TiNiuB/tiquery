package pd

import (
	"fmt"
	"strconv"
	"time"

	gh "github.com/dustin/go-humanize"
)

// ByteSize is a retype uint64 for TOML and JSON.
type ByteSize uint64

// MarshalJSON returns the size as a JSON string.
func (b ByteSize) MarshalJSON() ([]byte, error) {
	return []byte(`"` + gh.IBytes(uint64(b)) + `"`), nil
}

// UnmarshalJSON parses a JSON string into the bytesize.
func (b *ByteSize) UnmarshalJSON(text []byte) error {
	s, err := strconv.Unquote(string(text))
	if err != nil {
		return err
	}
	v, err := gh.ParseBytes(s)
	if err != nil {
		return err
	}
	*b = ByteSize(v)
	return nil
}

// UnmarshalText parses a Toml string into the bytesize.
func (b *ByteSize) UnmarshalText(text []byte) error {
	v, err := gh.ParseBytes(string(text))
	if err != nil {
		return err
	}
	*b = ByteSize(v)
	return nil
}

// Duration is a wrapper of time.Duration for TOML and JSON.
type Duration struct {
	time.Duration
}

// NewDuration creates a Duration from time.Duration.
func NewDuration(duration time.Duration) Duration {
	return Duration{Duration: duration}
}

// MarshalJSON returns the duration as a JSON string.
func (d *Duration) MarshalJSON() ([]byte, error) {
	return []byte(fmt.Sprintf(`"%s"`, d.String())), nil
}

// UnmarshalJSON parses a JSON string into the duration.
func (d *Duration) UnmarshalJSON(text []byte) error {
	s, err := strconv.Unquote(string(text))
	if err != nil {
		return err
	}
	duration, err := time.ParseDuration(s)
	if err != nil {
		return err
	}
	d.Duration = duration
	return nil
}

// UnmarshalText parses a TOML string into the duration.
func (d *Duration) UnmarshalText(text []byte) error {
	var err error
	d.Duration, err = time.ParseDuration(string(text))
	return err
}
