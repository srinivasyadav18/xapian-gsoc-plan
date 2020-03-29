package main

import (
	"fmt"
	xp "xapian"
)

func main() {
	d := xp.NewDocument()
	d.Add_term("this")
	d.Add_term("is")
	d.Add_term("raw")
	d.Add_term("Implementation")
	d.Add_term("of")
	d.Add_term("Iterator")
	d.Add_term("using channels")
	fmt.Println(d.Termlist_count())
	var myDoc xp.MyDocument
	myDoc.Obj = d //this is explicitly done for now because to use this normally it needs complete rewrapping which is done in second week

	//Using range construct on TermIterator
	for term := range myDoc.Terms() {
		fmt.Println(term)
	}
}
