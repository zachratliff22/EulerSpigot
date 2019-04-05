package main

import "fmt"
import "os"
import "strconv"

func multTen(a []int){

	for i := 0; i < len(a); i++ {
		a[i] = a[i] * 10
	}

}

func spigot(a []int, b []int){

	multTen(a)
	for i := len(a) - 1; i > 0; i-- {
		q := a[i] / b[i]
		r := a[i] % b[i]
		a[i - 1] = a[i - 1] + q
		a[i] = r
	}

	q := a[0] / b[0]
	r := a[0] % b[0]
	a[0] = r

	fmt.Printf("%d", q)
}

func main(){

	if len(os.Args) != 2 {
		fmt.Println("USAGE: ./EulerSpigot.go 5000")
		return
	}

	arg := os.Args[1]
	numDigits, err := strconv.Atoi(arg)
	if err != nil {
		fmt.Println("Error parsing command line arguments.")
		return
	}

	// Initialize mixed radix mode
	baseArr := make([]int, numDigits + 15000)
	valueArr := make([]int, numDigits + 15000)
	for i := 0; i < len(baseArr); i++ {
		baseArr[i] = i + 2
		valueArr[i] = 1
	}

	fmt.Printf("%d.", 2)
	for digit := 0; digit < numDigits; digit++ {
		spigot(valueArr, baseArr)
	}

	fmt.Printf("\n")

}
