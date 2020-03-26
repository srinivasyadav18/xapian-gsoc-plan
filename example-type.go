package main

import("fmt")

type Integer int
//BOTH THE TYPES int and Integer are now different
func example (a Integer){
        fmt.Println(a)
}

func main(){
        var x int =10
        example(x)
}

