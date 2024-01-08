CREATE OR REPLACE EDITIONABLE TYPE JSON_O as object (
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

  /* Variables */
  json_data tmcs.json_value_array_o,
  check_for_duplicate number,

  /* Constructors */
  constructor function json_o return self as result,
  constructor function json_o(str varchar2) return self as result,
  constructor function json_o(str in clob) return self as result,
  constructor function json_o(cast tmcs.json_value_o) return self as result,
  constructor function json_o(l in out nocopy json_list_o) return self as result,

  /* Member setter methods */
  member procedure remove(pair_name varchar2),
  member procedure put(self in out nocopy json_o, pair_name varchar2, pair_value tmcs.json_value_o, position pls_integer default null),
  member procedure put(self in out nocopy json_o, pair_name varchar2, pair_value varchar2, position pls_integer default null),
  member procedure put(self in out nocopy json_o, pair_name varchar2, pair_value number, position pls_integer default null),
  member procedure put(self in out nocopy json_o, pair_name varchar2, pair_value boolean, position pls_integer default null),
  member procedure check_duplicate(self in out nocopy json_o, v_set boolean),
  member procedure remove_duplicates(self in out nocopy json_o),

  /* deprecated putter use tmcs.json_value */
  member procedure put(self in out nocopy json_o, pair_name varchar2, pair_value json_o, position pls_integer default null),
  member procedure put(self in out nocopy json_o, pair_name varchar2, pair_value json_list_o, position pls_integer default null),

  /* Member getter methods */
  member function count return number,
  member function get(pair_name varchar2) return tmcs.json_value_o,
  member function get(position pls_integer) return tmcs.json_value_o,
  member function index_of(pair_name varchar2) return number,
  member function exist(pair_name varchar2) return boolean,

  /* Output methods */
  member function to_char(spaces boolean default true, chars_per_line number default 0) return varchar2,
  member procedure to_clob(self in json_o, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true),
  member procedure print(self in json_o, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null), --32512 is maximum
  member procedure htp(self in json_o, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null),

  member function to_json_value return tmcs.json_value_o,
  /* json path */
  member function path(json_path varchar2, base number default 1) return tmcs.json_value_o,

  /* json path_put */
  member procedure path_put(self in out nocopy json_o, json_path varchar2, elem tmcs.json_value_o, base number default 1),
  member procedure path_put(self in out nocopy json_o, json_path varchar2, elem varchar2  , base number default 1),
  member procedure path_put(self in out nocopy json_o, json_path varchar2, elem number    , base number default 1),
  member procedure path_put(self in out nocopy json_o, json_path varchar2, elem boolean   , base number default 1),
  member procedure path_put(self in out nocopy json_o, json_path varchar2, elem json_list_o , base number default 1),
  member procedure path_put(self in out nocopy json_o, json_path varchar2, elem json_o      , base number default 1),

  /* json path_remove */
  member procedure path_remove(self in out nocopy json_o, json_path varchar2, base number default 1),

  /* map functions */
  member function get_values return json_list_o,
  member function get_keys return json_list_o

) not final;
/

