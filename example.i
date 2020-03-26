%module example
%{
#include "example.h"
#include <stdexcept>

// custom exceptions to demonstrate for go
#include "myexcept.h"
%}

// to use standard exceptions provided by go
%include "exception.i"

%include <typemaps.i>
%include <std_string.i>

%exception {
        try {
                $action;
        } catch (MyException & e){
                //calls the panic in go
                _swig_gopanic(e.msg());
        }
        catch (std::exception & e){
                _swig_gopanic(e.what());
        }
}

//renamed for re-wrapping 

%rename (wrapped_Myfun) Myfun;
%rename (Wrapped_Myclass) Myclass;
%rename (Wrapped_Print) Myclass::print();

%go_import("fmt")
%insert(go_wrapper) %{

//enabling c++ exception for Myfun and storing error in err as they are treated as value
func Myfun(arg1,arg2 int) (ans int,err error){
        //catches the exception from panic and pass it to catch for recover
        defer catch(&err)
        ans=Wrapped_Myfun(arg1,arg2)
        return
}
//function recovers from the panic and stores err message ing err
func catch(err *error){
        if r := recover(); r != nil {
        *err = fmt.Errorf("error %v",r)
        }
}
//storing the swig generated object in Myclass and providing customised types for Myclass
type MyClass struct {
        obj Wrapped_Myclass
        X int
}

func (ms *MyClass) Print()(err error){
        defer catch(&err)
        (*ms).obj.Wrapped_Print()
        return
}

func (ms *MyClass) Add(a ...interface{})(ret int){
        ret = (*ms).obj.Add(a)
        return
}
//function(constructor)  which can take any number of values of different types

func NewMyClass(a ...interface{})(MyClass){
        var retobj MyClass
        w := NewWrapped_Myclass(a)
        retobj.obj = w
        retobj.X=10
        return retobj
}

%}
%include "insert.h"
