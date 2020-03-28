package main

import (
	"fmt"
)

type Node struct {
	prev *Node
	next *Node
	key  int
}

type List struct {
	head *Node
	tail *Node
}

func (L *List) Insert(key int) {
	list := &Node{
		next: L.head,
		key:  key,
	}
	if L.head != nil {
		L.head.prev = list
	}
	L.head = list

	l := L.head
	for l.next != nil {
		l = l.next
	}
	L.tail = l
}

func (l *List) Iter() <-chan int {
	ch := make(chan int)
	go func() {
		list := l.head
		for list != nil {
			ch <- list.key
			list = list.next
		}
		close(ch)
	}()
	return ch
}
func main() {
	link := List{}
	link.Insert(1)
	link.Insert(2)
	link.Insert(3)
	link.Insert(4)
	link.Insert(5)
	for i := range link.Iter() {
		fmt.Println(i)
	}
}

