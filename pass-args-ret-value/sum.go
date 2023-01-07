package main

func SumAndCap(xs []int) (int, int, int, int, int, int, int, int, int, int, int, int) {
	var n int
	for _, v := range xs {
		n += v
	}
	return n, cap(xs), 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
}

func main() {
}
