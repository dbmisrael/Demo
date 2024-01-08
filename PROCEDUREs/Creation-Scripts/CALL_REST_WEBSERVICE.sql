CREATE OR REPLACE EDITIONABLE PROCEDURE CALL_REST_WEBSERVICE
as
  t_http_req     utl_http.req;
  t_http_resp    utl_http.resp;
  t_request_body varchar2(30000);
  t_respond      varchar2(30000);
  t_start_pos    integer := 1;
  t_output       varchar2(2000);
    l_raw_data       RAW(4000);
    l_clob_response  CLOB;
    l_buffer_size    NUMBER(10) := 100;

begin
  /*Construct the information you want to send to the webservice.
    Normally this would be in a xml structure. But for a REST-
    webservice this is not mandatory. The webservice i needed to
    call excepts plain test.*/
  t_request_body := '{ A1 : 205 }';

  /*Telling Oracle where the webservice can be found, what kind of request is made
    and the version of the HTTP*/
  t_http_req:= utl_http.begin_request( 'http://osdev.tangomc.com:3000/abc/xyc'
                                     , 'POST'
                                     , 'HTTP/1.1');

  /*In my case the webservice used authentication with a username an password
    that was provided to me. You can skip this line if it's a public webservice.*/
  --utl_http.set_authentication(t_http_req,'username','password');

  /*Describe in the request-header what kind of data is send*/
  utl_http.set_header(t_http_req, 'Content-Type', 'application/json');

  /*Describe in the request-header the lengt of the data*/
  utl_http.set_header(t_http_req, 'Content-Length', length(t_request_body));

  /*Put the data in de body of the request*/
  utl_http.write_text(t_http_req, t_request_body);

  /*make the actual request to the webservice en catch the responce in a
    variable*/
  t_http_resp:= utl_http.get_response(t_http_req);

  /*Read the body of the response, so you can find out if the information was
    received ok by the webservice.
    Go to the documentation of the webservice for what kind of responce you
    should expect. In my case it was:
    <responce>
      <status>ok</status>
    </responce>
  */
  utl_http.read_text(t_http_resp, t_respond);

  /*Some closing?1 Releasing some memory, i think....*/
  utl_http.end_response(t_http_resp);
    BEGIN
        <<response_loop>>
        LOOP
            UTL_HTTP.read_raw(t_http_resp, l_raw_data, l_buffer_size);
            l_clob_response := l_clob_response || UTL_RAW.cast_to_varchar2(l_raw_data);
        END LOOP response_loop;

        EXCEPTION
            WHEN UTL_HTTP.end_of_body THEN
                UTL_HTTP.end_response(t_http_resp);
    END;
    DBMS_OUTPUT.put_line('Response> length: ' || LENGTH(l_clob_response) || '');

end;
/

