package bar

import (
	"fmt"

	"github.com/kwk/gocross/foo"
)

// Bar prints "Bar" to the screen.
func Bar() {
	fmt.Printf("Bar\n")
}

// FooBar prints "Foo" and then "Bar"
func FooBar() {
	foo.Foo()
	Bar()
}
