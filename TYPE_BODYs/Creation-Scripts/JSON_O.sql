CREATE OR REPLACE EDITIONABLE TYPE BODY JSON_O as

  /* Constructors */
  constructor function json_o return self as result as
  begin
    self.json_data := json_value_array_o();
    self.check_for_duplicate := 1;
    return;
  end;

  constructor function json_o(str varchar2) return self as result as
  begin
    self := json_parser_o.parser(str);
    self.check_for_duplicate := 1;
    return;
  end;

  constructor function json_o(str in clob) return self as result as
  begin
    self := json_parser_o.parser(str);
    self.check_for_duplicate := 1;
    return;
  end;

  constructor function json_o(cast tmcs.json_value_o) return self as result as
    x number;
  begin
    x := cast.object_or_array.getobject(self);
    self.check_for_duplicate := 1;
    return;
  end;

  constructor function json_o(l in out nocopy json_list_o) return self as result as
  begin
    for i in 1 .. l.list_data.count loop
      if(l.list_data(i).mapname is null or l.list_data(i).mapname like 'row%') then
      l.list_data(i).mapname := 'row'||i;
      end if;
      l.list_data(i).mapindx := i;
    end loop;

    self.json_data := l.list_data;
    self.check_for_duplicate := 1;
    return;
  end;

  /* Member setter methods */
  member procedure remove(self in out nocopy json_o, pair_name varchar2) as
    temp tmcs.json_value_o;
    indx pls_integer;

    function get_member(pair_name varchar2) return tmcs.json_value_o as
      indx pls_integer;
    begin
      indx := json_data.first;
      loop
        exit when indx is null;
        if(pair_name is null and json_data(indx).mapname is null) then return json_data(indx); end if;
        if(json_data(indx).mapname = pair_name) then return json_data(indx); end if;
        indx := json_data.next(indx);
      end loop;
      return null;
    end;
  begin
    temp := get_member(pair_name);
    if(temp is null) then return; end if;

    indx := json_data.next(temp.mapindx);
    loop
      exit when indx is null;
      json_data(indx).mapindx := indx - 1;
      json_data(indx-1) := json_data(indx);
      indx := json_data.next(indx);
    end loop;
    json_data.trim(1);
    --num_elements := num_elements - 1;
  end;

  member procedure put(self in out nocopy json_o, pair_name varchar2, pair_value tmcs.json_value_o, position pls_integer default null) as
    insert_value json_value_o := nvl(pair_value, tmcs.json_value_o.makenull);
    indx pls_integer; x number;
    temp tmcs.json_value_o;
    function get_member(pair_name varchar2) return tmcs.json_value_o as
      indx pls_integer;
    begin
      indx := json_data.first;
      loop
        exit when indx is null;
        if(pair_name is null and json_data(indx).mapname is null) then return json_data(indx); end if;
        if(json_data(indx).mapname = pair_name) then return json_data(indx); end if;
        indx := json_data.next(indx);
      end loop;
      return null;
    end;
  begin
    --dbms_output.put_line('PN '||pair_name);

--    if(pair_name is null) then
--      raise_application_error(-20102, 'JSON put-method type error: name cannot be null');
--    end if;
    insert_value.mapname := pair_name;
--    self.remove(pair_name);
    if(self.check_for_duplicate = 1) then temp := get_member(pair_name); else temp := null; end if;
    if(temp is not null) then
      insert_value.mapindx := temp.mapindx;
      json_data(temp.mapindx) := insert_value;
      return;
    elsif(position is null or position > self.count) then
      --insert at the end of the list
      --dbms_output.put_line('Test');
--      indx := self.count + 1;
      json_data.extend(1);
      json_data(json_data.count) := insert_value;
--      insert_value.mapindx := json_data.count;
      json_data(json_data.count).mapindx := json_data.count;
--      dbms_output.put_line('Test2'||insert_value.mapindx);
--      dbms_output.put_line('Test2'||insert_value.mapname);
--      insert_value.print(false);
--      self.print;
    elsif(position < 2) then
      --insert at the start of the list
      indx := json_data.last;
      json_data.extend;
      loop
        exit when indx is null;
        temp := json_data(indx);
        temp.mapindx := indx+1;
        json_data(temp.mapindx) := temp;
        indx := json_data.prior(indx);
      end loop;
      json_data(1) := insert_value;
      insert_value.mapindx := 1;
    else
      --insert somewhere in the list
      indx := json_data.last;
--      dbms_output.put_line('Test '||indx);
      json_data.extend;
--      dbms_output.put_line('Test '||indx);
      loop
--        dbms_output.put_line('Test '||indx);
        temp := json_data(indx);
        temp.mapindx := indx + 1;
        json_data(temp.mapindx) := temp;
        exit when indx = position;
        indx := json_data.prior(indx);
      end loop;
      json_data(position) := insert_value;
      json_data(position).mapindx := position;
    end if;
--    num_elements := num_elements + 1;
  end;

  member procedure put(self in out nocopy json_o, pair_name varchar2, pair_value varchar2, position pls_integer default null) as
  begin
    put(pair_name, tmcs.json_value_o(pair_value), position);
  end;

  member procedure put(self in out nocopy json_o, pair_name varchar2, pair_value number, position pls_integer default null) as
  begin
    if(pair_value is null) then
      put(pair_name, tmcs.json_value_o(), position);
    else
      put(pair_name, tmcs.json_value_o(pair_value), position);
    end if;
  end;

  member procedure put(self in out nocopy json_o, pair_name varchar2, pair_value boolean, position pls_integer default null) as
  begin
    if(pair_value is null) then
      put(pair_name, tmcs.json_value_o(), position);
    else
      put(pair_name, tmcs.json_value_o(pair_value), position);
    end if;
  end;

  member procedure check_duplicate(self in out nocopy json_o, v_set boolean) as
  begin
    if(v_set) then
      check_for_duplicate := 1;
    else
      check_for_duplicate := 0;
    end if;
  end;

  /* deprecated putters */

  member procedure put(self in out nocopy json_o, pair_name varchar2, pair_value json_o, position pls_integer default null) as
  begin
    if(pair_value is null) then
      put(pair_name, tmcs.json_value_o(), position);
    else
      put(pair_name, pair_value.to_json_value, position);
    end if;
  end;

  member procedure put(self in out nocopy json_o, pair_name varchar2, pair_value json_list_o, position pls_integer default null) as
  begin
    if(pair_value is null) then
      put(pair_name, tmcs.json_value_o(), position);
    else
      put(pair_name, pair_value.to_json_value, position);
    end if;
  end;

  /* Member getter methods */
  member function count return number as
  begin
    return self.json_data.count;
  end;

  member function get(pair_name varchar2) return tmcs.json_value_o as
    indx pls_integer;
  begin
    indx := json_data.first;
    loop
      exit when indx is null;
      if(pair_name is null and json_data(indx).mapname is null) then return json_data(indx); end if;
      if(json_data(indx).mapname = pair_name) then return json_data(indx); end if;
      indx := json_data.next(indx);
    end loop;
    return null;
  end;

  member function get(position pls_integer) return tmcs.json_value_o as
  begin
    if(self.count >= position and position > 0) then
      return self.json_data(position);
    end if;
    return null; -- do not throw error, just return null
  end;

  member function index_of(pair_name varchar2) return number as
    indx pls_integer;
  begin
    indx := json_data.first;
    loop
      exit when indx is null;
      if(pair_name is null and json_data(indx).mapname is null) then return indx; end if;
      if(json_data(indx).mapname = pair_name) then return indx; end if;
      indx := json_data.next(indx);
    end loop;
    return -1;
  end;

  member function exist(pair_name varchar2) return boolean as
  begin
    return (self.get(pair_name) is not null);
  end;

  /* Output methods */
  member function to_char(spaces boolean default true, chars_per_line number default 0) return varchar2 as
  begin
    if(spaces is null) then
      return json_printer_o.pretty_print(self, line_length => chars_per_line);
    else
      return json_printer_o.pretty_print(self, spaces, line_length => chars_per_line);
    end if;
  end;

  member procedure to_clob(self in json_o, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true) as
  begin
    if(spaces is null) then
      json_printer_o.pretty_print(self, false, buf, line_length => chars_per_line, erase_clob => erase_clob);
    else
      json_printer_o.pretty_print(self, spaces, buf, line_length => chars_per_line, erase_clob => erase_clob);
    end if;
  end;

  member procedure print(self in json_o, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null) as --32512 is the real maximum in sqldeveloper
    my_clob clob;
  begin
    my_clob := empty_clob();
    dbms_lob.createtemporary(my_clob, true);
    json_printer_o.pretty_print(self, spaces, my_clob, case when (chars_per_line>32512) then 32512 else chars_per_line end);
    json_printer_o.dbms_output_clob(my_clob, json_printer_o.newline_char, jsonp);
    dbms_lob.freetemporary(my_clob);
  end;

  member procedure htp(self in json_o, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null) as
    my_clob clob;
  begin
    my_clob := empty_clob();
    dbms_lob.createtemporary(my_clob, true);
    json_printer_o.pretty_print(self, spaces, my_clob, chars_per_line);
    json_printer_o.htp_output_clob(my_clob, jsonp);
    dbms_lob.freetemporary(my_clob);
  end;

  member function to_json_value return tmcs.json_value_o as
  begin
    return tmcs.json_value_o(sys.anydata.convertobject(self));
  end;

  /* json path */
  member function path(json_path varchar2, base number default 1) return tmcs.json_value_o as
  begin
    return json_ext_o.get_json_value(self, json_path, base);
  end path;

  /* json path_put */
  member procedure path_put(self in out nocopy json_o, json_path varchar2, elem tmcs.json_value_o, base number default 1) as
  begin
    json_ext_o.put(self, json_path, elem, base);
  end path_put;

  member procedure path_put(self in out nocopy json_o, json_path varchar2, elem varchar2, base number default 1) as
  begin
    json_ext_o.put(self, json_path, elem, base);
  end path_put;

  member procedure path_put(self in out nocopy json_o, json_path varchar2, elem number, base number default 1) as
  begin
    if(elem is null) then
      json_ext_o.put(self, json_path, tmcs.json_value_o(), base);
    else
      json_ext_o.put(self, json_path, elem, base);
    end if;
  end path_put;

  member procedure path_put(self in out nocopy json_o, json_path varchar2, elem boolean, base number default 1) as
  begin
    if(elem is null) then
      json_ext_o.put(self, json_path, tmcs.json_value_o(), base);
    else
      json_ext_o.put(self, json_path, elem, base);
    end if;
  end path_put;

  member procedure path_put(self in out nocopy json_o, json_path varchar2, elem json_list_o, base number default 1) as
  begin
    if(elem is null) then
      json_ext_o.put(self, json_path, tmcs.json_value_o(), base);
    else
      json_ext_o.put(self, json_path, elem, base);
    end if;
  end path_put;

  member procedure path_put(self in out nocopy json_o, json_path varchar2, elem json_o, base number default 1) as
  begin
    if(elem is null) then
      json_ext_o.put(self, json_path, tmcs.json_value_o(), base);
    else
      json_ext_o.put(self, json_path, elem, base);
    end if;
  end path_put;

  member procedure path_remove(self in out nocopy json_o, json_path varchar2, base number default 1) as
  begin
    json_ext_o.remove(self, json_path, base);
  end path_remove;

  /* Thanks to Matt Nolan */
  member function get_keys return json_list_o as
    keys json_list_o;
    indx pls_integer;
  begin
    keys := json_list_o();
    indx := json_data.first;
    loop
      exit when indx is null;
      keys.append(json_data(indx).mapname);
      indx := json_data.next(indx);
    end loop;
    return keys;
  end;

  member function get_values return json_list_o as
    vals json_list_o := json_list_o();
  begin
    vals.list_data := self.json_data;
    return vals;
  end;

  member procedure remove_duplicates(self in out nocopy json_o) as
  begin
    json_parser_o.remove_duplicates(self);
  end remove_duplicates;


end;
/

