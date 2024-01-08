CREATE OR REPLACE EDITIONABLE PACKAGE BODY TMCS_BK_SITE_INTF_PKG AS

FUNCTION Cmd (p_command IN VARCHAR2)
RETURN NUMBER
AS LANGUAGE JAVA
NAME 'Cmd.executeCommand (java.lang.String) return int';

PROCEDURE Populate_rec_in(txen_str IN varchar2, file_rec IN OUT TMP_RECTYPE_IN, status out varchar2)
IS
   l_string    varchar2(4000);
   l_store_no  varchar2(30);
   l_value     varchar2(1000);
BEGIN
   l_string := txen_str;
   l_value  := substr(l_string,1,INSTR(l_string, '|')-1);
   file_rec.SITE_no := trim(l_value);

   l_string := substr(l_string,INSTR(l_string, '|')+1);
   l_value  := substr(l_string,1,INSTR(l_string, '|')-1);
   file_rec.BK_NUMBER := trim(l_value);

   l_string := substr(l_string,INSTR(l_string, '|')+1);
   l_value  := substr(l_string,1,INSTR(l_string, '|')-1);
   file_rec.A_NUMBER := trim(l_value);

   l_string := substr(l_string,INSTR(l_string, '|')+1);
   l_value  := substr(l_string,1,INSTR(l_string, '|')-1);
   file_rec.DEVELOPMENT_MANAGER := trim(l_value);

   l_string := substr(l_string,INSTR(l_string, '|')+1);
   l_value  := substr(l_string,1,INSTR(l_string, '|')-1);
   file_rec.CONSTRUCTION_MANAGER := trim(l_value);

   l_string := substr(l_string,INSTR(l_string, '|')+1);
   l_value  := substr(l_string,1,INSTR(l_string, '|')-1);
   file_rec.REDCAT_STATUS := trim(l_value);

   l_string := substr(l_string,INSTR(l_string, '|')+1);
   l_value  := l_string;
   file_rec.ESTIMATED_OPENING_DATE := trim(l_value);
Exception
  when others then
   status := 'Site Number '||file_rec.SITE_no||' record has error'||sqlerrm;
   dbms_output.put_line(sqlerrm);
END;

PROCEDURE load_data_in(p_buffer out varchar2) IS
      buffer_str     varchar2(2000);
      sale_rec       TMP_RECTYPE_IN;
      rec_count      NUMBER    := 0;
      rec_insert     NUMBER    := 0;
      warning_count  NUMBER    := 0;
      found_errors   BOOLEAN   := FALSE;
      n_file_count   number    :=0;
      l_status       VARCHAR2(100);
      l_text_file    UTL_FILE.FILE_TYPE;
      l_file_name    VARCHAR2(500);
      l_dir_path     VARCHAR2(1000);
      l_statsus      VARCHAR2(1000);
      L_START_DATE   date;
      l_validate_store VARCHAR2(10);
      l_estimated_opening_date date;
      cursor c1 is
       SELECT column_value FROM TABLE(list_files('/home/bkuser/inbound/sites')) where upper(column_value) like 'SITE%' and upper(column_value) not like 'SITESPAF%';

BEGIN
  Begin
	select sysdate
	into   L_START_DATE
	from dual;
  End;
  l_status  := null;
  For r1 in c1 Loop
--dbms_output.put_line(1);
      n_file_count := n_file_count + 1;
      l_text_file := utl_file.fopen('BK_SITE_INTERFACE_IN', r1.column_value, 'r');
      rec_count   	:= 0;
      p_buffer      := null;
      l_file_name   := r1.column_value;
--dbms_output.put_line(2);
      WHILE TRUE LOOP
		BEGIN
--dbms_output.put_line(3);
		   buffer_str := null;
		   l_estimated_opening_date := null;
           utl_file.get_line(l_text_file, buffer_str);
--dbms_output.put_line('buffer_str '||buffer_str);
           rec_count := rec_count + 1;
		   p_buffer  := null;
           If rec_count != 0 then  --Because there is no label row so it is 0 instead of 1)
			 Populate_rec_in(buffer_str, sale_rec, p_buffer);
--dbms_output.put_line('store number '||sale_rec.SITE_no);
			 If sale_rec.SITE_no is not null then
--dbms_output.put_line(4);
			   If p_buffer is not null Then
		    	 TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_IN', 1, p_buffer, r1.column_value, 'Scheduler', L_START_DATE, sysdate);
		    	 l_status := 'Error';
			   End If;
--dbms_output.put_line(5);
               Begin
                 select 1
                 into  l_validate_store
                 from  tmcs_sites_b
                 where target_number = sale_rec.site_no;
               Exception
                 when no_data_found then
                    p_buffer := 'File '||l_file_name||' has error. SITE number '||sale_rec.SITE_no||' is null or invalid';
		    		TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_IN', 1, p_buffer, r1.column_value, 'Scheduler', L_START_DATE, sysdate);
		    	 When others then
                    p_buffer := 'File '||l_file_name||' has error. SITE number '||sale_rec.SITE_no||' record is not valid.';
		    		TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_IN', 1, p_buffer||sqlerrm, r1.column_value, 'Scheduler', L_START_DATE, sysdate);
		    		l_status := 'Error';
               End;
--dbms_output.put_line('p_buffer '||p_buffer);
			   l_estimated_opening_date := to_date(substr(sale_rec.ESTIMATED_OPENING_DATE,1,10),'MM/DD/YYYY');
			   IF p_buffer is null then
					update tmcs_sites_b  a
					set  C_EXT_ATTR35 = sale_rec.BK_NUMBER
						,SITE_NUMBER =	sale_rec.A_NUMBER
						,REAL_ESTATE_MANAGER  = sale_rec.DEVELOPMENT_MANAGER
						,CONSTRUCTION_MANAGER = sale_rec.CONSTRUCTION_MANAGER
					 	,C_EXT_ATTR19  = sale_rec.REDCAT_STATUS
						,D_EXT_ATTR14  = l_estimated_opening_date --sale_rec.ESTIMATED_OPENING_DATE
						,last_update_date = sysdate
						,last_updated_by = 'Site_Interface'
					where  target_number = sale_rec.site_no;
			   END IF;
			 End If;
           End If;
       	EXCEPTION
       	  WHEN NO_DATA_FOUND THEN EXIT;
		  WHEN OTHERS THEN
			--dbms_output.put_line('Error :'||sqlerrm);
		      p_buffer := 'File '||r1.column_value||' has error.'||sqlerrm||' for SITE Number '||sale_rec.SITE_no;
		      TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_IN', 1, p_buffer, r1.column_value, 'Scheduler', L_START_DATE, sysdate);
		      l_status := 'Error';
		  EXIT;
	    END;
      END LOOP;
      utl_file.fclose_all;
      If nvl(l_status,'#') != 'Error' Then
	      l_statsus := TMCS_DUKB_STORE_SALES_INTF_PKG.Cmd('mv /home/bkuser/inbound/sites/'||r1.column_value||' /home/bkuser/inbound/sites/processed/');
	      p_buffer := 'File '||r1.column_value||' uploaded successfully';
	      TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_IN', 0, p_buffer, r1.column_value, 'Scheduler', L_START_DATE, sysdate);
	      dbms_output.put_line(p_buffer);
	      commit;
      Else
	      p_buffer := 'File '||r1.column_value||' has error. Please check error table for more detail.';
	      TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_IN', 1, p_buffer, r1.column_value, 'Scheduler', L_START_DATE, sysdate);
	      dbms_output.put_line(p_buffer);
	      rollback;
	      Exit;
      End If;
    End Loop;
    If n_file_count = 0 Then
       p_buffer := 'There is no file to process right now';
       TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_IN', 1, p_buffer, '', 'Scheduler', L_START_DATE, sysdate);
    End If;
    utl_file.fclose_all;
    commit;
EXCEPTION
	 WHEN OTHERS THEN
	    p_buffer := 'File '||l_file_name||' has error. Please check error table for more detail.';
        TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_IN', 1, sqlerrm, l_file_name, 'Scheduler', L_START_DATE, sysdate);
        dbms_output.put_line(p_buffer);
	 	ROLLBACK;
END;

PROCEDURE Populate_rec_paf(txen_str IN varchar2, file_rec IN OUT TMP_RECTYPE_PAF, status out varchar2)
IS
   l_string    varchar2(4000);
   l_store_no  varchar2(30);
   l_value     varchar2(1000);
BEGIN
   l_string := txen_str;
   l_value  := substr(l_string,1,INSTR(l_string, '|')-1);
   file_rec.SITE_no := trim(l_value);

   l_string := substr(l_string,INSTR(l_string, '|')+1);
   l_value  := substr(l_string,1,INSTR(l_string, '|')-1);
   file_rec.ENCR_TYPE := trim(l_value);

   l_string := substr(l_string,INSTR(l_string, '|')+1);
   l_value  := substr(l_string,1,INSTR(l_string, '|')-1);
   file_rec.encr_no := trim(l_value);

   l_string := substr(l_string,INSTR(l_string, '|')+1);
   l_value  := substr(l_string,1,INSTR(l_string, '|')-1);
   file_rec.notification_sent := trim(l_value);

   l_string := substr(l_string,INSTR(l_string, '|')+1);
   l_value  := substr(l_string,1,INSTR(l_string, '|')-1);
   file_rec.DEADLINE_DATE := trim(l_value);

   l_string := substr(l_string,INSTR(l_string, '|')+1);
   l_value  := substr(l_string,1,INSTR(l_string, '|')-1);
   file_rec.OBJECTION_STATUS := trim(l_value);

   l_string := substr(l_string,INSTR(l_string, '|')+1);
   l_value  := l_string;
   file_rec.ADR_RECEIVE_DATE := trim(l_value);
Exception
  when others then
   status := 'SITE Numbe '||file_rec.SITE_no||' record has error'||sqlerrm;
   dbms_output.put_line(sqlerrm);
END;

PROCEDURE load_data_paf(p_buffer out varchar2) IS
      buffer_str     varchar2(2000);
      sale_rec       TMP_RECTYPE_PAF;
      rec_count      NUMBER    := 0;
      rec_insert     NUMBER    := 0;
      warning_count  NUMBER    := 0;
      found_errors   BOOLEAN   := FALSE;
      n_file_count   number    :=0;
      l_status       VARCHAR2(100);
      l_text_file    UTL_FILE.FILE_TYPE;
      l_file_name    VARCHAR2(500);
      l_dir_path     VARCHAR2(1000);
      l_statsus      VARCHAR2(1000);
      L_START_DATE   date;
      l_site_id		 number;
      l_encr_no      number;
      cursor c1 is
       SELECT column_value FROM TABLE(list_files('/home/bkuser/inbound/sites')) where upper(column_value) like 'SITESPAF%';

BEGIN
  Begin
	select sysdate
	into   L_START_DATE
	from dual;
  End;
  l_status  := null;
  For r1 in c1 Loop
--dbms_output.put_line(1);
      n_file_count := n_file_count + 1;
      l_text_file := utl_file.fopen('BK_SITE_INTERFACE_IN', r1.column_value, 'r');
      rec_count   	:= 0;
      p_buffer      := null;
      l_file_name   := r1.column_value;
--dbms_output.put_line(2);
      WHILE TRUE LOOP
		BEGIN
--dbms_output.put_line(3);
		   buffer_str := null;
           utl_file.get_line(l_text_file, buffer_str);
--dbms_output.put_line('buffer_str '||buffer_str);
           rec_count := rec_count + 1;
		   p_buffer  := null;
		   l_site_id := null;
		   l_encr_no := null;
           If rec_count != 0 then  --Because there is no label row so it is 0 instead of 1)
			 Populate_rec_paf(buffer_str, sale_rec, p_buffer);
--dbms_output.put_line('store number '||sale_rec.SITE_no);
			 If sale_rec.SITE_no is not null then
--dbms_output.put_line(4);
--dbms_output.put_line(5);
               Begin
                 select site_id
                 into  l_site_id
                 from  tmcs_SITEs_b
                 where target_number = sale_rec.SITE_no;
               Exception
                 when no_data_found then
                    p_buffer := 'File '||l_file_name||' has error. SITE number '||sale_rec.SITE_no||' is null or invalid';
		    		TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_PAF', 1, p_buffer, r1.column_value, 'Scheduler', L_START_DATE, sysdate);
		    	 When others then
                    p_buffer := 'File '||l_file_name||' has error. SITE number '||sale_rec.SITE_no||' record is not valid.';
		    		TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_PAF', 1, p_buffer||sqlerrm, r1.column_value, 'Scheduler', L_START_DATE, sysdate);
		    		l_status := 'Error';
               End;

               If sale_rec.encr_type = 'T' Then
                Begin
                 select target_id
                 into  l_encr_no
                 from  tmcs_targets_b
                 where target_number = sale_rec.encr_no;
                Exception
                 when no_data_found then null;
		    	 When others then null;
                End;
               else
                 l_encr_no := sale_rec.encr_no;
               End If;
--dbms_output.put_line('p_buffer '||p_buffer);
			   IF l_site_id is not null then
					update TMCS_ENTITY_ENCROACHMENTS  a
					set D_EXT_ATTR2   = to_date(sale_rec.NOTIFICATION_SENT,'MM/DD/YYYY')
						,D_EXT_ATTR3  = to_date(sale_rec.DEADLINE_DATE,'MM/DD/YYYY')
						,D_EXT_ATTR5  = to_date(sale_rec.ADR_RECEIVE_DATE,'MM/DD/YYYY')
						,C_EXT_ATTR2  = sale_rec.OBJECTION_STATUS
						,last_update_date = sysdate
						,last_updated_by = 'Site_PAF_Interface'
					where  ENTITY_TYPE = 'SITE'
					and    entity_id = l_site_id
					--and    encr_type = decode(sale_rec.encr_type,'T','TARGET','R','PAF')
					and    encr_number  = sale_rec.encr_no;
			   END IF;
			 End If;
           End If;
       	EXCEPTION
       	  WHEN NO_DATA_FOUND THEN EXIT;
		  WHEN OTHERS THEN
			--dbms_output.put_line('Error :'||sqlerrm);
		      p_buffer := 'File '||r1.column_value||' has error.'||sqlerrm||' for SITE Number '||sale_rec.SITE_no;
		      TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_PAF', 1, p_buffer, r1.column_value, 'Scheduler', L_START_DATE, sysdate);
		      l_status := 'Error';
		  EXIT;
	    END;
      END LOOP;
      utl_file.fclose_all;
       If l_status is null Then
	      l_statsus := TMCS_DUKB_STORE_SALES_INTF_PKG.Cmd('mv /home/bkuser/inbound/sites/'||r1.column_value||' /home/bkuser/inbound/sites/processed/');
	      p_buffer := 'File '||r1.column_value||' uploaded successfully';
	      TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_PAF', 0, p_buffer, r1.column_value, 'Scheduler', L_START_DATE, sysdate);
	      dbms_output.put_line(p_buffer);
	      commit;
      Else
	      p_buffer := 'File '||r1.column_value||' has error. Please check error table for more detail!';
	      TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_PAF', 1, p_buffer, r1.column_value, 'Scheduler', L_START_DATE, sysdate);
	      dbms_output.put_line(p_buffer);
	      rollback;
	      Exit;
      End If;
    End Loop;
    If n_file_count = 0 Then
       p_buffer := 'There is no file to process right now';
       TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_PAF', 1, p_buffer, '', 'Scheduler', L_START_DATE, sysdate);
    End If;
    utl_file.fclose_all;
    commit;
EXCEPTION
	 WHEN OTHERS THEN
	    p_buffer := 'File '||l_file_name||' has error. Please check error table for more detail.';
        TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_PAF', 1, sqlerrm, l_file_name, 'Scheduler', L_START_DATE, sysdate);
        dbms_output.put_line(p_buffer);
	 	ROLLBACK;
END;

PROCEDURE SITE_OUTBOUND_FILE(P_ERR       OUT     NUMBER,
                               P_ERR_TXT   OUT     VARCHAR2)
IS
    output_file  utl_file.file_type;
    file_name    varchar2(100);
    l_start_date    date;
    l_file_count    number := 0;
    l_row_count    number := 0;
    l_longitude    varchar2(8);
    l_latitude     varchar2(8);
    l_deal_type_desc  varchar2(200);
    l_dev_type_desc   varchar2(200);
    l_arch_group_desc  varchar2(200);
    l_arch_type_desc   varchar2(200);
    l_play_type_desc   varchar2(200);
    l_loc_group_desc	 varchar2(200);
    l_loc_type_desc     varchar2(200);
    l_target_number   varchar2(100);

    cursor c1 is
    select TARGET_ID,SITE_NAME,LATITUDE,LONGITUDE,ADDRESS,ADDRESS2,C_EXT_ATTR47,CITY,STATE,ZIP_CODE,N_EXT_ATTR01,C_EXT_ATTR03,C_EXT_ATTR48,C_EXT_ATTR02,C_EXT_ATTR18,C_EXT_ATTR21
			,C_EXT_ATTR41,C_EXT_ATTR25,C_EXT_ATTR43,C_EXT_LOV5,C_EXT_LOV2,SITE_TYPE,C_EXT_LOV3,C_EXT_ATTR26,C_EXT_ATTR27,N_EXT_ATTR21,N_EXT_ATTR22,N_EXT_ATTR23,C_EXT_LOV4,SQ_FT,N_EXT_ATTR19
    from  tmcs_sites_b
    where target_number is not null
    and   nvl(category,'N') = 'Y';
    --and   created_by not like 'bktest%';

BEGIN
    select systimestamp
    into l_start_date
    from dual;

    Begin
            select 'sites_'||to_char(sysdate, 'YYYYMMDD')||'_'||to_char(systimestamp, 'HH24MISS')||'.txt'
            into file_name
            from dual;

            dbms_output.put_line('Before file open ');
            output_file := utl_file.fopen ('BK_SITE_INTERFACE_OUT',file_name, 'W');
            dbms_output.put_line('After file open ');


            for r1 in c1
            loop
            	l_deal_type_desc  := null;
            	l_dev_type_desc   := null;
			    l_arch_group_desc := null;
			    l_arch_type_desc  := null;
			    l_play_type_desc  := null;
			    l_loc_group_desc  := null;
			    l_loc_type_desc   := null;
			    l_target_number   := null;
			    Begin
					select name
					into  l_deal_type_desc
					from tmcs_lookup_values
					where lookup_id = (select lookup_id from tmcs_lookup_types where lookup_code like 'DEAL_TYPE')
					and lookup_code = r1.C_EXT_ATTR18;
				Exception
				   when no_data_found then
				       l_deal_type_desc := r1.C_EXT_ATTR18;
				   when others then null;
			    End;

            	l_dev_type_desc := null;
            	Begin
					select name
					into  l_dev_type_desc
					from tmcs_lookup_values
					where lookup_id = (select lookup_id from tmcs_lookup_types where lookup_code like 'Development Type')
					and lookup_code = r1.C_EXT_ATTR21;
				Exception
				   when others then null;
			    End;

            	l_arch_group_desc := null;
            	Begin
					select name
					into  l_arch_group_desc
					from tmcs_lookup_values
					where lookup_id = (select lookup_id from tmcs_lookup_types where lookup_code like 'SITELOV1')
					and lookup_code = r1.C_EXT_ATTR25;
				Exception
				   when others then null;
			    End;

            	l_arch_type_desc := null;
            	Begin
					select name
					into  l_arch_type_desc
					from tmcs_lookup_values
					where lookup_id = (select lookup_id from tmcs_lookup_types where lookup_code like 'SITELOV6')
					and lookup_code = r1.C_EXT_ATTR43;
				Exception
				   when others then null;
			    End;

            	l_play_type_desc := null;
            	Begin
					select name
					into  l_play_type_desc
					from tmcs_lookup_values
					where lookup_id = (select lookup_id from tmcs_lookup_types where lookup_code like 'SITELOV6')
					and lookup_code = r1.C_EXT_LOV5;
				Exception
				   when others then null;
			    End;

            	l_loc_group_desc := null;
            	Begin
					select name
					into  l_loc_group_desc
					from tmcs_lookup_values
					where lookup_id = (select lookup_id from tmcs_lookup_types where lookup_code like 'SITELOV6')
					and lookup_code = r1.C_EXT_LOV2;
				Exception
				   when others then null;
			    End;

            	l_loc_type_desc := null;
            	Begin
					select name
					into  l_loc_type_desc
					from tmcs_lookup_values
					where lookup_id = (select lookup_id from tmcs_lookup_types where lookup_code like 'SITELOV6')
					and lookup_code = r1.SITE_TYPE;
				Exception
				   when others then null;
			    End;
            	Begin
					select target_number
					into  l_target_number
					from tmcs_targets_b
					where target_id =  r1.target_id;
				Exception
				   when others then null;
			    End;

			    if l_target_number is not null then
	                utl_file.put_line(output_file,l_target_number||'|'||r1.SITE_NAME||'|'||r1.LATITUDE||'|'||r1.LONGITUDE||'|'||r1.ADDRESS||'|'||r1.ADDRESS2||'|'||r1.C_EXT_ATTR47||'|'||r1.CITY||'|'||r1.STATE||'|'||r1.ZIP_CODE||'|'||r1.N_EXT_ATTR01||'|'||r1.C_EXT_ATTR03||'|'||r1.C_EXT_ATTR48||'|'||r1.C_EXT_ATTR02||'|'||l_deal_type_desc||'|'||l_dev_type_desc
												||'|'||r1.C_EXT_ATTR41||'|'||l_arch_group_desc||'|'||l_arch_type_desc||'|'||l_play_type_desc||'|'||l_loc_group_desc||'|'||l_loc_type_desc||'|'||r1.C_EXT_LOV3||'|'||r1.C_EXT_ATTR26||'|'||r1.C_EXT_ATTR27||'|'||r1.N_EXT_ATTR21||'|'||r1.N_EXT_ATTR22||'|'||r1.N_EXT_ATTR23||'|'||r1.C_EXT_LOV4||'|'||r1.SQ_FT||'|'||r1.N_EXT_ATTR19);
				end if;
                --dbms_output.put_line('Row written ');
            end loop;

            utl_file.fclose(output_file);
            dbms_output.put_line('file closed ');
            TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_OUT', 0, 'Success', file_name, '', L_START_DATE, sysdate);
	exception
	when others then
	    dbms_output.put_line(sqlerrm);
        rollback;
        TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_INTERFACE_OUT', sqlcode, sqlerrm, file_name, '', L_START_DATE, sysdate);
    end;
END;

PROCEDURE SITE_PAF_OUTBOUND_FILE(P_ERR       OUT     NUMBER,
                               P_ERR_TXT   OUT     VARCHAR2)
IS
    output_file  utl_file.file_type;
    file_name    varchar2(100);
    l_start_date    date;
    l_file_count    number := 0;
    l_row_count    number := 0;
    l_longitude    varchar2(8);
    l_latitude     varchar2(8);
    l_encr_number  varchar2(50);

    cursor c1 is
    select SITE_NUMBER ,ENCR_TYPE,ENCR_NUMBER,/*a.C_EXT_ATTR1,*/DEAL_TYPE,substr(Distance,1,7) Distance,a.D_EXT_ATTR1,a.sales
    from tmcs_entity_encroachments a, tmcs_sites_b  b
    where a.entity_id = b.SITE_id
    and  SITE_number is not null
    and  entity_type = 'SITE'
    and  b.status not in ('UA','UNASSIGNED');
BEGIN
    select systimestamp
    into l_start_date
    from dual;

    Begin
            select 'sitespaf_'||to_char(sysdate, 'YYYYMMDD')||'_'||to_char(systimestamp, 'HH24MISS')||'.txt'
            into file_name
            from dual;

            --dbms_output.put_line('Before file open ');
            output_file := utl_file.fopen ('BK_SITE_INTERFACE_OUT',file_name, 'W');
            --dbms_output.put_line('After file open ');


            for r1 in c1
            loop
	            --In case if Encr Type 'Target', Encr Number is Target ID on PAF Screen. So getting Target NUmber with below code.
	            If r1.ENCR_TYPE = 'TARGET' Then
		            Begin
		              select target_number
		              into   l_encr_number
		              from   tmcs_targets_b
		              where  target_id = r1.ENCR_NUMBER;
		            Exception
		              when no_data_found then null;
		            End;
		        Else
		            l_encr_number :=  r1.ENCR_NUMBER;
				End If;
                utl_file.put_line(output_file,r1.SITE_NUMBER||'|'||r1.ENCR_TYPE||'|'||l_encr_number||'|'||r1.DEAL_TYPE||'|'||r1.Distance||'|'||r1.D_EXT_ATTR1||'|'||r1.Sales);
                --dbms_output.put_line('Row written ');
            end loop;

            utl_file.fclose(output_file);
            --dbms_output.put_line('file closed ');
            TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_PAF_INTERFACE_OUT', 0, 'Success', file_name, '', L_START_DATE, sysdate);
	exception
	when others then
        rollback;
        TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG('BK_SITE_PAF_INTERFACE_OUT', sqlcode, sqlerrm, file_name, '', L_START_DATE, sysdate);
    end;
END;
End;
/

