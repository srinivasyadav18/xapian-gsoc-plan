#include <iostream>
#include "myexcept.h"
#include <string>
int Myfun(int x,int y){
	if (x==0) throw MyException();
	return x+y;
}
void Myclass::print(){
	throw std::invalid_argument("invalid arg err being thrown");
	printf("hello\n");
}
int Myclass::add(){
	return 10;
}
Myclass::Myclass(){
	printf("empty const\n");
}
Myclass::Myclass(int x){
	printf("%d value const",x);
}
Myclass::Myclass(int x , std::string s){
	std::cout<<x<<s<<std::endl;
}
int Myclass::add(int x){
	return x;
}
