CREATE OR REPLACE EDITIONABLE TYPE BODY JSON_LIST_O as

  constructor function json_list_o return self as result as
  begin
    self.list_data := tmcs.json_value_array_o();
    return;
  end;

  constructor function json_list_o(str varchar2) return self as result as
  begin
    self := json_parser_o.parse_list(str);
    return;
  end;

  constructor function json_list_o(str clob) return self as result as
  begin
    self := json_parser_o.parse_list(str);
    return;
  end;

  constructor function json_list_o(cast tmcs.json_value_o) return self as result as
    x number;
  begin
    x := cast.object_or_array.getobject(self);
    return;
  end;


  member procedure append(self in out nocopy json_list_o, elem tmcs.json_value_o, position pls_integer default null) as
    indx pls_integer;
    insert_value tmcs.json_value_o := NVL(elem, tmcs.json_value_o);
  begin
    if(position is null or position > self.count) then --end of list
      indx := self.count + 1;
      self.list_data.extend(1);
      self.list_data(indx) := insert_value;
    elsif(position < 1) then --new first
      indx := self.count;
      self.list_data.extend(1);
      for x in reverse 1 .. indx loop
        self.list_data(x+1) := self.list_data(x);
      end loop;
      self.list_data(1) := insert_value;
    else
      indx := self.count;
      self.list_data.extend(1);
      for x in reverse position .. indx loop
        self.list_data(x+1) := self.list_data(x);
      end loop;
      self.list_data(position) := insert_value;
    end if;

  end;

  member procedure append(self in out nocopy json_list_o, elem varchar2, position pls_integer default null) as
  begin
    append(tmcs.json_value_o(elem), position);
  end;

  member procedure append(self in out nocopy json_list_o, elem number, position pls_integer default null) as
  begin
    if(elem is null) then
      append(tmcs.json_value_o(), position);
    else
      append(tmcs.json_value_o(elem), position);
    end if;
  end;

  member procedure append(self in out nocopy json_list_o, elem boolean, position pls_integer default null) as
  begin
    if(elem is null) then
      append(tmcs.json_value_o(), position);
    else
      append(tmcs.json_value_o(elem), position);
    end if;
  end;

  member procedure append(self in out nocopy json_list_o, elem json_list_o, position pls_integer default null) as
  begin
    if(elem is null) then
      append(tmcs.json_value_o(), position);
    else
      append(elem.to_json_value, position);
    end if;
  end;

 member procedure replace(self in out nocopy json_list_o, position pls_integer, elem tmcs.json_value_o) as
    insert_value json_value_o := NVL(elem, tmcs.json_value_o);
    indx number;
  begin
    if(position > self.count) then --end of list
      indx := self.count + 1;
      self.list_data.extend(1);
      self.list_data(indx) := insert_value;
    elsif(position < 1) then --maybe an error message here
      null;
    else
      self.list_data(position) := insert_value;
    end if;
  end;

  member procedure replace(self in out nocopy json_list_o, position pls_integer, elem varchar2) as
  begin
    replace(position, tmcs.json_value_o(elem));
  end;

  member procedure replace(self in out nocopy json_list_o, position pls_integer, elem number) as
  begin
    if(elem is null) then
      replace(position, tmcs.json_value_o());
    else
      replace(position, tmcs.json_value_o(elem));
    end if;
  end;

  member procedure replace(self in out nocopy json_list_o, position pls_integer, elem boolean) as
  begin
    if(elem is null) then
      replace(position, tmcs.json_value_o());
    else
      replace(position, tmcs.json_value_o(elem));
    end if;
  end;

  member procedure replace(self in out nocopy json_list_o, position pls_integer, elem json_list_o) as
  begin
    if(elem is null) then
      replace(position, tmcs.json_value_o());
    else
      replace(position, elem.to_json_value);
    end if;
  end;

  member function count return number as
  begin
    return self.list_data.count;
  end;

  member procedure remove(self in out nocopy json_list_o, position pls_integer) as
  begin
    if(position is null or position < 1 or position > self.count) then return; end if;
    for x in (position+1) .. self.count loop
      self.list_data(x-1) := self.list_data(x);
    end loop;
    self.list_data.trim(1);
  end;

  member procedure remove_first(self in out nocopy json_list_o) as
  begin
    for x in 2 .. self.count loop
      self.list_data(x-1) := self.list_data(x);
    end loop;
    if(self.count > 0) then
      self.list_data.trim(1);
    end if;
  end;

  member procedure remove_last(self in out nocopy json_list_o) as
  begin
    if(self.count > 0) then
      self.list_data.trim(1);
    end if;
  end;

  member function get(position pls_integer) return tmcs.json_value_o as
  begin
    if(self.count >= position and position > 0) then
      return self.list_data(position);
    end if;
    return null; -- do not throw error, just return null
  end;

  member function head return tmcs.json_value_o as
  begin
    if(self.count > 0) then
      return self.list_data(self.list_data.first);
    end if;
    return null; -- do not throw error, just return null
  end;

  member function last return tmcs.json_value_o as
  begin
    if(self.count > 0) then
      return self.list_data(self.list_data.last);
    end if;
    return null; -- do not throw error, just return null
  end;

  member function tail return json_list_o as
    t json_list_o;
  begin
    if(self.count > 0) then
      t := json_list_o(self.list_data);
      t.remove(1);
      return t;
    else return json_list_o(); end if;
  end;

  member function to_char(spaces boolean default true, chars_per_line number default 0) return varchar2 as
  begin
    if(spaces is null) then
      return json_printer_o.pretty_print_list(self, line_length => chars_per_line);
    else
      return json_printer_o.pretty_print_list(self, spaces, line_length => chars_per_line);
    end if;
  end;

  member procedure to_clob(self in json_list_o, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true) as
  begin
    if(spaces is null) then
      json_printer_o.pretty_print_list(self, false, buf, line_length => chars_per_line, erase_clob => erase_clob);
    else
      json_printer_o.pretty_print_list(self, spaces, buf, line_length => chars_per_line, erase_clob => erase_clob);
    end if;
  end;

  member procedure print(self in json_list_o, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null) as --32512 is the real maximum in sqldeveloper
    my_clob clob;
  begin
    my_clob := empty_clob();
    dbms_lob.createtemporary(my_clob, true);
    json_printer_o.pretty_print_list(self, spaces, my_clob, case when (chars_per_line>32512) then 32512 else chars_per_line end);
    json_printer_o.dbms_output_clob(my_clob, json_printer_o.newline_char, jsonp);
    dbms_lob.freetemporary(my_clob);
  end;

  member procedure htp(self in json_list_o, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null) as
    my_clob clob;
  begin
    my_clob := empty_clob();
    dbms_lob.createtemporary(my_clob, true);
    json_printer_o.pretty_print_list(self, spaces, my_clob, chars_per_line);
    json_printer_o.htp_output_clob(my_clob, jsonp);
    dbms_lob.freetemporary(my_clob);
  end;

  /* json path */
  member function path(json_path varchar2, base number default 1) return tmcs.json_value_o as
    cp json_list_o := self;
  begin
    return json_ext_o.get_json_value(json_o(cp), json_path, base);
  end path;


  /* json path_put */
  member procedure path_put(self in out nocopy json_list_o, json_path varchar2, elem tmcs.json_value_o, base number default 1) as
    objlist json_o;
    jp json_list_o := json_ext_o.parsePath(json_path, base);
  begin
    while(jp.head().get_number() > self.count) loop
      self.append(tmcs.json_value_o());
    end loop;

    objlist := json_o(self);
    json_ext_o.put(objlist, json_path, elem, base);
    self := objlist.get_values;
  end path_put;

  member procedure path_put(self in out nocopy json_list_o, json_path varchar2, elem varchar2, base number default 1) as
    objlist json_o;
    jp json_list_o := json_ext_o.parsePath(json_path, base);
  begin
    while(jp.head().get_number() > self.count) loop
      self.append(tmcs.json_value_o());
    end loop;

    objlist := json_o(self);
    json_ext_o.put(objlist, json_path, elem, base);
    self := objlist.get_values;
  end path_put;

  member procedure path_put(self in out nocopy json_list_o, json_path varchar2, elem number, base number default 1) as
    objlist json_o;
    jp json_list_o := json_ext_o.parsePath(json_path, base);
  begin
    while(jp.head().get_number() > self.count) loop
      self.append(tmcs.json_value_o());
    end loop;

    objlist := json_o(self);

    if(elem is null) then
      json_ext_o.put(objlist, json_path, tmcs.json_value_o, base);
    else
      json_ext_o.put(objlist, json_path, elem, base);
    end if;
    self := objlist.get_values;
  end path_put;

  member procedure path_put(self in out nocopy json_list_o, json_path varchar2, elem boolean, base number default 1) as
    objlist json_o;
    jp json_list_o := json_ext_o.parsePath(json_path, base);
  begin
    while(jp.head().get_number() > self.count) loop
      self.append(tmcs.json_value_o());
    end loop;

    objlist := json_o(self);
    if(elem is null) then
      json_ext_o.put(objlist, json_path, tmcs.json_value_o, base);
    else
      json_ext_o.put(objlist, json_path, elem, base);
    end if;
    self := objlist.get_values;
  end path_put;

  member procedure path_put(self in out nocopy json_list_o, json_path varchar2, elem json_list_o, base number default 1) as
    objlist json_o;
    jp json_list_o := json_ext_o.parsePath(json_path, base);
  begin
    while(jp.head().get_number() > self.count) loop
      self.append(tmcs.json_value_o());
    end loop;

    objlist := json_o(self);
    if(elem is null) then
      json_ext_o.put(objlist, json_path, tmcs.json_value_o, base);
    else
      json_ext_o.put(objlist, json_path, elem, base);
    end if;
    self := objlist.get_values;
  end path_put;

  /* json path_remove */
  member procedure path_remove(self in out nocopy json_list_o, json_path varchar2, base number default 1) as
    objlist json_o := json_o(self);
  begin
    json_ext_o.remove(objlist, json_path, base);
    self := objlist.get_values;
  end path_remove;


  member function to_json_value return tmcs.json_value_o as
  begin
    return tmcs.json_value_o(sys.anydata.convertobject(self));
  end;

  /*--backwards compatibility
  member procedure add_elem(self in out nocopy json_list_o, elem tmcs.json_value_o, position pls_integer default null) as begin append(elem,position); end;
  member procedure add_elem(self in out nocopy json_list_o, elem varchar2, position pls_integer default null) as begin append(elem,position); end;
  member procedure add_elem(self in out nocopy json_list_o, elem number, position pls_integer default null) as begin append(elem,position); end;
  member procedure add_elem(self in out nocopy json_list_o, elem boolean, position pls_integer default null) as begin append(elem,position); end;
  member procedure add_elem(self in out nocopy json_list_o, elem json_list_o, position pls_integer default null) as begin append(elem,position); end;

  member procedure set_elem(self in out nocopy json_list_o, position pls_integer, elem tmcs.json_value_o) as begin replace(position,elem); end;
  member procedure set_elem(self in out nocopy json_list_o, position pls_integer, elem varchar2) as begin replace(position,elem); end;
  member procedure set_elem(self in out nocopy json_list_o, position pls_integer, elem number) as begin replace(position,elem); end;
  member procedure set_elem(self in out nocopy json_list_o, position pls_integer, elem boolean) as begin replace(position,elem); end;
  member procedure set_elem(self in out nocopy json_list_o, position pls_integer, elem json_list_o) as begin replace(position,elem); end;

  member procedure remove_elem(self in out nocopy json_list_o, position pls_integer) as begin remove(position); end;
  member function get_elem(position pls_integer) return tmcs.json_value_o as begin return get(position); end;
  member function get_first return tmcs.json_value_o as begin return head(); end;
  member function get_last return tmcs.json_value_o as begin return last(); end;
--  */

end;
/

