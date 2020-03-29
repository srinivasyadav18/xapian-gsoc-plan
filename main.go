package main

import (
	"fmt"
	"os"
	xp "xapian"
)

func main() {
	d := xp.NewWrapped_Document()
	d.Add_term("this")
	d.Add_term("is")
	d.Add_term("raw")
	d.Add_term("Implementation")
	d.Add_term("of")
	d.Add_term("Iterator")
	d.Add_term("using channels")

	var myDoc xp.Document
	myDoc.Obj = d

	/*
		After complete wrapping this can be used as
		doc := NewDocument()
		for term := range doc.Terms(){
			fmt.Println(term)
		}
	*/

	//Using for-range construct on TermIterator
	for term := range myDoc.Terms() {
		fmt.Println(term)
	}

	// Database class object creation and error handling
	db, err := xp.NewDatabase("/sdfkln")
	if err != nil {
		fmt.Println(err)
		os.Exit(2)
	}
	fmt.Println(db) //Do something with database db when there is no error
}
