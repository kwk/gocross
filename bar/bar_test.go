package bar

import "testing"

func TestBar(t *testing.T) {
	Bar()
}

// TestFooBar tests the FooBar() function which internally calls the Foo()
// function from the foo package that is not covered by any other test.
func TestFooBar(t *testing.T) {
	FooBar()
}
