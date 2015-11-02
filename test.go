package main

import (
	"github.com/ryanuber/shortstr"
)

func main() {
	shortener := shortstr.NewStrings([]string{})
	shortener.Insert("hello")
	shortener.Insert("help me")
	println(shortener.Shortest("hello"))
}
