%module(directors="1") xapian
%{
/* go.i: SWIG interface file for the Go bindings
 *
 * Copyright (C) 2014 Marius Tibeica
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
 * USA
 */
%}

#define XAPIAN_SWIG_DIRECTORS

%rename(Apply) operator();

%ignore Xapian::Compactor::resolve_duplicate_metadata(std::string const &key, size_t num_tags, std::string const tags[]);
%rename (Wrapped_Document) Document;
%insert(go_wrapper) %{
    
//rewrapping the Document interface currently adding only extra method Terms() to show how term iterator can be 
//used with go for-range construct
type Document struct {
        Obj Wrapped_Document
}

func (d *Document) Terms()<-chan string {
        ch := make(chan string)
        begin := d.Obj.Termlist_begin()
        end := d.Obj.Termlist_end()
        go func() {
                for !begin.Equals(end) {
                        ch <- begin.Get_term()
                        begin.Next()
                }
                close(ch)
        }()
        return ch
}

%}
%include ../xapian-head.i

//%include ../generic/except.i
%include ../xapian-headers.i
