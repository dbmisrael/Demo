CREATE OR REPLACE EDITIONABLE PACKAGE BODY JSON_AC_O as
  procedure object_remove(p_self in out nocopy json_o, pair_name varchar2) as
  begin p_self.remove(pair_name); end;
  procedure object_put(p_self in out nocopy json_o, pair_name varchar2, pair_value json_value_o, position pls_integer default null) as
  begin p_self.put(pair_name, pair_value, position); end;
  procedure object_put(p_self in out nocopy json_o, pair_name varchar2, pair_value varchar2, position pls_integer default null) as
  begin p_self.put(pair_name, pair_value, position); end;
  procedure object_put(p_self in out nocopy json_o, pair_name varchar2, pair_value number, position pls_integer default null) as
  begin p_self.put(pair_name, pair_value, position); end;
  procedure object_put(p_self in out nocopy json_o, pair_name varchar2, pair_value boolean, position pls_integer default null) as
  begin p_self.put(pair_name, pair_value, position); end;
  procedure object_check_duplicate(p_self in out nocopy json_o, v_set boolean) as
  begin p_self.check_duplicate(v_set); end;
  procedure object_remove_duplicates(p_self in out nocopy json_o) as
  begin p_self.remove_duplicates; end;

  procedure object_put(p_self in out nocopy json_o, pair_name varchar2, pair_value json_o, position pls_integer default null) as
  begin p_self.put(pair_name, pair_value, position); end;
  procedure object_put(p_self in out nocopy json_o, pair_name varchar2, pair_value json_list_o, position pls_integer default null) as
  begin p_self.put(pair_name, pair_value, position); end;

  function object_count(p_self in json_o) return number as
  begin return p_self.count; end;
  function object_get(p_self in json_o, pair_name varchar2) return json_value_o as
  begin return p_self.get(pair_name); end;
  function object_get(p_self in json_o, position pls_integer) return json_value_o as
  begin return p_self.get(position); end;
  function object_index_of(p_self in json_o, pair_name varchar2) return number as
  begin return p_self.index_of(pair_name); end;
  function object_exist(p_self in json_o, pair_name varchar2) return boolean as
  begin return p_self.exist(pair_name); end;

  function object_to_char(p_self in json_o, spaces boolean default true, chars_per_line number default 0) return varchar2 as
  begin return p_self.to_char(spaces, chars_per_line); end;
  procedure object_to_clob(p_self in json_o, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true) as
  begin p_self.to_clob(buf, spaces, chars_per_line, erase_clob); end;
  procedure object_print(p_self in json_o, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null) as
  begin p_self.print(spaces, chars_per_line, jsonp); end;
  procedure object_htp(p_self in json_o, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null) as
  begin p_self.htp(spaces, chars_per_line, jsonp); end;

  function object_to_json_value(p_self in json_o) return json_value_o as
  begin return p_self.to_json_value; end;
  function object_path(p_self in json_o, json_path varchar2, base number default 1) return json_value_o as
  begin return p_self.path(json_path, base); end;

  procedure object_path_put(p_self in out nocopy json_o, json_path varchar2, elem json_value_o, base number default 1) as
  begin p_self.path_put(json_path, elem, base); end;
  procedure object_path_put(p_self in out nocopy json_o, json_path varchar2, elem varchar2  , base number default 1) as
  begin p_self.path_put(json_path, elem, base); end;
  procedure object_path_put(p_self in out nocopy json_o, json_path varchar2, elem number    , base number default 1) as
  begin p_self.path_put(json_path, elem, base); end;
  procedure object_path_put(p_self in out nocopy json_o, json_path varchar2, elem boolean   , base number default 1) as
  begin p_self.path_put(json_path, elem, base); end;
  procedure object_path_put(p_self in out nocopy json_o, json_path varchar2, elem json_list_o , base number default 1) as
  begin p_self.path_put(json_path, elem, base); end;
  procedure object_path_put(p_self in out nocopy json_o, json_path varchar2, elem json_o      , base number default 1) as
  begin p_self.path_put(json_path, elem, base); end;

  procedure object_path_remove(p_self in out nocopy json_o, json_path varchar2, base number default 1) as
  begin p_self.path_remove(json_path, base); end;

  function object_get_values(p_self in json_o) return json_list_o as
  begin return p_self.get_values; end;
  function object_get_keys(p_self in json_o) return json_list_o as
  begin return p_self.get_keys; end;

  --json_list_o type
  procedure array_append(p_self in out nocopy json_list_o, elem json_value_o, position pls_integer default null) as
  begin p_self.append(elem, position); end;
  procedure array_append(p_self in out nocopy json_list_o, elem varchar2, position pls_integer default null) as
  begin p_self.append(elem, position); end;
  procedure array_append(p_self in out nocopy json_list_o, elem number, position pls_integer default null) as
  begin p_self.append(elem, position); end;
  procedure array_append(p_self in out nocopy json_list_o, elem boolean, position pls_integer default null) as
  begin p_self.append(elem, position); end;
  procedure array_append(p_self in out nocopy json_list_o, elem json_list_o, position pls_integer default null) as
  begin p_self.append(elem, position); end;

  procedure array_replace(p_self in out nocopy json_list_o, position pls_integer, elem json_value_o) as
  begin p_self.replace(position, elem); end;
  procedure array_replace(p_self in out nocopy json_list_o, position pls_integer, elem varchar2) as
  begin p_self.replace(position, elem); end;
  procedure array_replace(p_self in out nocopy json_list_o, position pls_integer, elem number) as
  begin p_self.replace(position, elem); end;
  procedure array_replace(p_self in out nocopy json_list_o, position pls_integer, elem boolean) as
  begin p_self.replace(position, elem); end;
  procedure array_replace(p_self in out nocopy json_list_o, position pls_integer, elem json_list_o) as
  begin p_self.replace(position, elem); end;

  function array_count(p_self in json_list_o) return number as
  begin return p_self.count; end;
  procedure array_remove(p_self in out nocopy json_list_o, position pls_integer) as
  begin p_self.remove(position); end;
  procedure array_remove_first(p_self in out nocopy json_list_o) as
  begin p_self.remove_first; end;
  procedure array_remove_last(p_self in out nocopy json_list_o) as
  begin p_self.remove_last; end;
  function array_get(p_self in json_list_o, position pls_integer) return json_value_o as
  begin return p_self.get(position); end;
  function array_head(p_self in json_list_o) return json_value_o as
  begin return p_self.head; end;
  function array_last(p_self in json_list_o) return json_value_o as
  begin return p_self.last; end;
  function array_tail(p_self in json_list_o) return json_list_o as
  begin return p_self.tail; end;

  function array_to_char(p_self in json_list_o, spaces boolean default true, chars_per_line number default 0) return varchar2 as
  begin return p_self.to_char(spaces, chars_per_line); end;
  procedure array_to_clob(p_self in json_list_o, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true) as
  begin p_self.to_clob(buf, spaces, chars_per_line, erase_clob); end;
  procedure array_print(p_self in json_list_o, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null) as
  begin p_self.print(spaces, chars_per_line, jsonp); end;
  procedure array_htp(p_self in json_list_o, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null) as
  begin p_self.htp(spaces, chars_per_line, jsonp); end;

  function array_path(p_self in json_list_o, json_path varchar2, base number default 1) return json_value_o as
  begin return p_self.path(json_path, base); end;
  procedure array_path_put(p_self in out nocopy json_list_o, json_path varchar2, elem json_value_o, base number default 1) as
  begin p_self.path_put(json_path, elem, base); end;
  procedure array_path_put(p_self in out nocopy json_list_o, json_path varchar2, elem varchar2  , base number default 1) as
  begin p_self.path_put(json_path, elem, base); end;
  procedure array_path_put(p_self in out nocopy json_list_o, json_path varchar2, elem number    , base number default 1) as
  begin p_self.path_put(json_path, elem, base); end;
  procedure array_path_put(p_self in out nocopy json_list_o, json_path varchar2, elem boolean   , base number default 1) as
  begin p_self.path_put(json_path, elem, base); end;
  procedure array_path_put(p_self in out nocopy json_list_o, json_path varchar2, elem json_list_o , base number default 1) as
  begin p_self.path_put(json_path, elem, base); end;

  procedure array_path_remove(p_self in out nocopy json_list_o, json_path varchar2, base number default 1) as
  begin p_self.path_remove(json_path, base); end;

  function array_to_json_value(p_self in json_list_o) return json_value_o as
  begin return p_self.to_json_value; end;

  --json_value_o


  function jv_get_type(p_self in json_value_o) return varchar2 as
  begin return p_self.get_type; end;
  function jv_get_string(p_self in json_value_o, max_byte_size number default null, max_char_size number default null) return varchar2 as
  begin return p_self.get_string(max_byte_size, max_char_size); end;
  procedure jv_get_string(p_self in json_value_o, buf in out nocopy clob) as
  begin p_self.get_string(buf); end;
  function jv_get_number(p_self in json_value_o) return number as
  begin return p_self.get_number; end;
  function jv_get_bool(p_self in json_value_o) return boolean as
  begin return p_self.get_bool; end;
  function jv_get_null(p_self in json_value_o) return varchar2 as
  begin return p_self.get_null; end;

  function jv_is_object(p_self in json_value_o) return boolean as
  begin return p_self.is_object; end;
  function jv_is_array(p_self in json_value_o) return boolean as
  begin return p_self.is_array; end;
  function jv_is_string(p_self in json_value_o) return boolean as
  begin return p_self.is_string; end;
  function jv_is_number(p_self in json_value_o) return boolean as
  begin return p_self.is_number; end;
  function jv_is_bool(p_self in json_value_o) return boolean as
  begin return p_self.is_bool; end;
  function jv_is_null(p_self in json_value_o) return boolean as
  begin return p_self.is_null; end;

  function jv_to_char(p_self in json_value_o, spaces boolean default true, chars_per_line number default 0) return varchar2 as
  begin return p_self.to_char(spaces, chars_per_line); end;
  procedure jv_to_clob(p_self in json_value_o, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true) as
  begin p_self.to_clob(buf, spaces, chars_per_line, erase_clob); end;
  procedure jv_print(p_self in json_value_o, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null) as
  begin p_self.print(spaces, chars_per_line, jsonp); end;
  procedure jv_htp(p_self in json_value_o, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null) as
  begin p_self.htp(spaces, chars_per_line, jsonp); end;

  function jv_value_of(p_self in json_value_o, max_byte_size number default null, max_char_size number default null) return varchar2 as
  begin return p_self.value_of(max_byte_size, max_char_size); end;

end;
/

