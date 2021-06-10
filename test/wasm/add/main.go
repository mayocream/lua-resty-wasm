package main

import "fmt"

// Declare a main function, this is the entrypoint into our go module
// That will be run. In our example, we won't need this
func main() {}


// This exports an add function.
// It takes in two 32-bit integer values
// And returns a 32-bit integer value.
// To make this function callable from JavaScript,
// we need to add the: "export add" comment above the function
//export add
func add() int {
	fmt.Println("wasm running...")
  	return 1000;
}