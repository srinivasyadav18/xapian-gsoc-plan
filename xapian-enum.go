package main

import ("fmt"
	"xapian")

func main(){
	tm := xapian.NewTermGenerator()
	// tm.Set_stemming_strategy(xapian.TermGeneratorSTEM_NONE) --> fails
	/*for Stem Startegy enum in TermGenerator class 
	swig defines a type XapianTermGeneratorStem_strategy int 
	and for each element in  enum a type is created as 
	type TermGeneratorSTEM_SOME int is created.
	so before passing to the functions converion should happen
	even both hold the same internal type.
	*/
	tm.Set_stemming_strategy(xapian.TermGeneratorSTEM_NONE(xapian.TermGeneratorSTEM_SOME))
}
