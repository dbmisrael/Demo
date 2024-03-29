CREATE OR REPLACE EDITIONABLE TYPE JSON_LIST_O as object (
  /*
  Copyright (c) 2010 Jonas Krogsboell

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the Software), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  */

  list_data tmcs.json_value_array_o,
  constructor function json_list_o return self as result,
  constructor function json_list_o(str varchar2) return self as result,
  constructor function json_list_o(str clob) return self as result,
  constructor function json_list_o(cast tmcs.json_value_o) return self as result,

  member procedure append(self in out nocopy json_list_o, elem tmcs.json_value_o, position pls_integer default null),
  member procedure append(self in out nocopy json_list_o, elem varchar2, position pls_integer default null),
  member procedure append(self in out nocopy json_list_o, elem number, position pls_integer default null),
  member procedure append(self in out nocopy json_list_o, elem boolean, position pls_integer default null),
  member procedure append(self in out nocopy json_list_o, elem json_list_o, position pls_integer default null),

  member procedure replace(self in out nocopy json_list_o, position pls_integer, elem tmcs.json_value_o),
  member procedure replace(self in out nocopy json_list_o, position pls_integer, elem varchar2),
  member procedure replace(self in out nocopy json_list_o, position pls_integer, elem number),
  member procedure replace(self in out nocopy json_list_o, position pls_integer, elem boolean),
  member procedure replace(self in out nocopy json_list_o, position pls_integer, elem json_list_o),

  member function count return number,
  member procedure remove(self in out nocopy json_list_o, position pls_integer),
  member procedure remove_first(self in out nocopy json_list_o),
  member procedure remove_last(self in out nocopy json_list_o),
  member function get(position pls_integer) return tmcs.json_value_o,
  member function head return tmcs.json_value_o,
  member function last return tmcs.json_value_o,
  member function tail return json_list_o,

  /* Output methods */
  member function to_char(spaces boolean default true, chars_per_line number default 0) return varchar2,
  member procedure to_clob(self in json_list_o, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true),
  member procedure print(self in json_list_o, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null), --32512 is maximum
  member procedure htp(self in json_list_o, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null),

  /* json path */
  member function path(json_path varchar2, base number default 1) return tmcs.json_value_o,
  /* json path_put */
  member procedure path_put(self in out nocopy json_list_o, json_path varchar2, elem tmcs.json_value_o, base number default 1),
  member procedure path_put(self in out nocopy json_list_o, json_path varchar2, elem varchar2  , base number default 1),
  member procedure path_put(self in out nocopy json_list_o, json_path varchar2, elem number    , base number default 1),
  member procedure path_put(self in out nocopy json_list_o, json_path varchar2, elem boolean   , base number default 1),
  member procedure path_put(self in out nocopy json_list_o, json_path varchar2, elem json_list_o , base number default 1),

  /* json path_remove */
  member procedure path_remove(self in out nocopy json_list_o, json_path varchar2, base number default 1),

  member function to_json_value return tmcs.json_value_o
  /* --backwards compatibility
  ,
  member procedure add_elem(self in out nocopy json_list_o, elem tmcs.json_value, position pls_integer default null),
  member procedure add_elem(self in out nocopy json_list_o, elem varchar2, position pls_integer default null),
  member procedure add_elem(self in out nocopy json_list_o, elem number, position pls_integer default null),
  member procedure add_elem(self in out nocopy json_list_o, elem boolean, position pls_integer default null),
  member procedure add_elem(self in out nocopy json_list_o, elem json_list_o, position pls_integer default null),

  member procedure set_elem(self in out nocopy json_list_o, position pls_integer, elem tmcs.json_value),
  member procedure set_elem(self in out nocopy json_list_o, position pls_integer, elem varchar2),
  member procedure set_elem(self in out nocopy json_list_o, position pls_integer, elem number),
  member procedure set_elem(self in out nocopy json_list_o, position pls_integer, elem boolean),
  member procedure set_elem(self in out nocopy json_list_o, position pls_integer, elem json_list_o),

  member procedure remove_elem(self in out nocopy json_list_o, position pls_integer),
  member function get_elem(position pls_integer) return tmcs.json_value,
  member function get_first return tmcs.json_value,
  member function get_last return tmcs.json_value
--  */

) not final;
/

