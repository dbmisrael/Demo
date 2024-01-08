CREATE OR REPLACE EDITIONABLE PACKAGE BODY TMCS_MACY_OUT_INTF_PKG
AS
  /******************************************************************************
    NAME:       TMCS_CENT_OUT_INTF_PKG
                CLIENT_ID:205,CLIENT_CODE=MACY,CLIENT_NAME:MACYS
    REVISIONS:

    Ver              Date              Developer                Description
    ---------     ----------       ---------------             ------------------------------------
    1.0         11/22/2019   Swetha Reddy                         TASD-34578 -- Project Budget Export Out
    2.0         02/17/2020   Ramesh Babu Mittapalli               TASD-37215 -- Project-Delegated Commitments should not be more than the corresponding delegated budgets
    3.0         02/17/2020   Ramesh Babu Mittapalli               TASD-39132 -- Macy's: Excluded Projects Outbound Integration
    4.0         06/30/2022   Pavani Srivatsavaye                  TASD-69859 -- Macy's: Projects Export Outbound Integration.
  ********************************************************************************************************************/


FUNCTION Cmd (p_command IN VARCHAR2)
      RETURN NUMBER
   AS
      LANGUAGE JAVA
      NAME 'Cmd.executeCommand (java.lang.String) return int';

FUNCTION tmcs_db_instance_name
   RETURN VARCHAR2
IS
   l_instance_name   VARCHAR2 (100);
BEGIN
   SELECT (CASE
              WHEN global_name = 'TADEV' THEN 'DEV Database'
              WHEN global_name = 'MULTITES' THEN 'TEST Database'
              WHEN global_name = 'MULTIPRD' THEN 'PRODUCTION Database'
              ELSE NULL
           END)
     INTO l_instance_name
     FROM global_name;

   IF l_instance_name IS NOT NULL
   THEN
      l_instance_name := ' From ' || l_instance_name;
   END IF;

   RETURN l_instance_name;
EXCEPTION
   WHEN OTHERS
   THEN
      RETURN NULL;
END tmcs_db_instance_name;

   PROCEDURE tmcs_project_budget_export_out(P_USER    IN      VARCHAR2 :='SCHEDULER') AS

l_file_name     VARCHAR2(100);
l_err_fname    VARCHAR2(100);
l_dir_path        VARCHAR2(100);
l_val                   VARCHAR2(1000);
output_file       UTL_FILE.FILE_TYPE;
err_file              UTL_FILE.FILE_TYPE;
l_start_date     Date;
l_msg                 VARCHAR2(4000);
l_cnt                   NUMBER := 0;
l_statsus           VARCHAR2(1000);
l_client_id         NUMBER;
p_buf                 VARCHAR2(4000);
l_prog_name   VARCHAR2(100) := 'TMCS_MACY_PRJ_BGT_OUT_INT';
l_file_moved_status          NUMBER;
l_gen_file                              VARCHAR2(10) := NULL;
l_baseline_id                        NUMBER:=0;
l_status                                  VARCHAR2(10);
p_buffer                                VARCHAR2(4000);

 CURSOR c1 IS
     SELECT ver.baseline_id,
                    ver.c_ext_attr01,
                    ver.project_id,
                    ver.baseline_id capital_req_num,
                    bud.budget_id,
                    TRIM(NVL(SUBSTR( bud.task_name,1,INSTR(bud.task_name,' ')),bud.task_name)) task_name,
                    bud.sub_task_type,
                    bud.approved_budget - NVL(TO_NUMBER(segment2),0) as approved_budget,
                    p.project_number
       FROM tmcs.tmcs_proj_baseline_versions ver,
                    tmcs.tmcs_budgets bud,
                    tmcs.tmcs_projects p,
                    tmcs.tmcs_project_attributes tpa
     WHERE ver.project_id = bud.entity_id
          AND ver.project_id = p.project_id
          AND p.project_id = tpa.project_id
          AND tpa.c_ext_attr190 IS NOT NULL
          AND ver.wf_status ='APPROVED'
          AND (ver.d_ext_attr01 IS NULL OR ver.d_ext_attr01 <> to_date('11/11/9999','MM/DD/YYYY'))  --As trigger is reverting back c_ext_attr01, changed the value to d_ext_attr01
--          AND (ver.c_ext_attr01 IS NULL OR ver.c_ext_attr01 not in ('EXPORTED'))
          AND bud.segment1 ='BUDGET'
          AND bud.entity_type ='PROJECT'
          AND UPPER(bud.description) IN ('CAPITAL', 'CAPITAL-SAGE', 'EXPENSE', 'EXPENSE-SAGE')
          AND ver.client_id = 205
          AND bud.client_id = 205
          AND p.client_id = 205
--          AND p.project_id in (63905,71330)
     UNION ALL
     SELECT ver.baseline_id,
                    ver.c_ext_attr01,
                    ver.project_id,
                    ver.baseline_id capital_req_num,
                    bud.budget_id,
                    TRIM(NVL(SUBSTR( bud.task_name,1,INSTR(bud.task_name,' ')),bud.task_name)) task_name,
                    bud.store_number sub_task_type,
                    bud.approved_budget - NVL(TO_NUMBER(segment2),0) as approved_budget,
                     p.project_number
       FROM tmcs.tmcs_proj_baseline_versions ver,
                    tmcs.tmcs_budgets bud,
                    tmcs.tmcs_projects p,
                    tmcs.tmcs_project_attributes tpa
     WHERE ver.project_id = bud.master_project_id
          AND bud.master_project_id <> bud.entity_id
          AND ver.project_id = p.project_id
          AND p.project_id = tpa.project_id
          AND tpa.c_ext_attr190 IS NOT NULL
          AND ver.wf_status ='APPROVED'
          AND (ver.d_ext_attr01 IS NULL OR ver.d_ext_attr01 <> to_date('11/11/9999','MM/DD/YYYY'))  --As trigger is reverting back c_ext_attr01, changed the value to d_ext_attr01
--          AND (ver.c_ext_attr01 IS NULL OR ver.c_ext_attr01 not in ('EXPORTED'))
          AND bud.segment1 ='BUDGET'
          AND bud.entity_type ='PROJECT'
          AND ver.client_id = 205
          AND bud.client_id = 205
          AND p.client_id = 205
          AND UPPER(bud.description) IN ('CAPITAL', 'CAPITAL-SAGE', 'EXPENSE', 'EXPENSE-SAGE')
--          AND p.project_id in (63905,71330)
      ORDER BY  project_number, budget_ID;

   CURSOR c2 IS
     SELECT *
        FROM tmcs.tmcs_service_log
       WHERE program_name = 'TMCS_MACY_PRJ_BGT_OUT_INT'
            AND client_id=205
            AND TRUNC(start_date) = TRUNC(SYSDATE);
 BEGIN

      SELECT SYSTIMESTAMP INTO l_start_date FROM dual;

      l_file_name :='Tango_Macys_Project_Budget_'||TO_CHAR(SYSDATE,'MMDDYYYYHHMISS')||'.txt';

       SELECT directory_path
           INTO l_dir_path
         FROM all_directories
       WHERE directory_name = 'TMCS_MACY_PRJ_BGT_OUT_DIR';

      l_client_id := 205;

   FOR file_move IN (SELECT COLUMN_VALUE file_name
                                        FROM TABLE (list_files (l_dir_path))
                                      WHERE UPPER (COLUMN_VALUE) LIKE '%MACYS_%.TXT')
      LOOP
      dbms_output.put_line('moving file');
     l_file_moved_status := TMCS_MACY_OUT_INTF_PKG.cmd  ('mv '|| l_dir_path|| '/'|| file_move.file_name|| ' ' || l_dir_path|| '/processed');
     dbms_output.put_line('status of l_file_moved_status : '||l_file_moved_status);
     END LOOP;


    output_file  := UTL_FILE.FOPEN('TMCS_MACY_PRJ_BGT_OUT_DIR', l_file_name, 'W', 32767);

    UTL_FILE.PUT_LINE(output_file,'Timberline Project Number|Capital Request Number|Tango Budget ID|Tradecode|Extra|Approved Budget');

        FOR r1 IN c1 LOOP

            l_cnt := l_cnt +1;

       UTL_FILE.PUT_LINE(output_file,r1.project_number||'|'||r1.capital_req_num||'|'||r1.budget_id||'|'||r1.task_name||'|'||r1.sub_task_type||'|'||r1.approved_budget);

       dbms_output.put_line('baseline_id : '|| r1.baseline_id);
        BEGIN

          UPDATE tmcs.tmcs_proj_baseline_versions
                 SET --c_ext_attr01 = 'EXPORTED',
                     d_ext_attr01 = to_date('11/11/9999','MM/DD/YYYY'),  --Updated mapping as trigger is reverting back c_ext_attr01 the value to numm
                     last_update_date = SYSDATE,
                     last_updated_by ='integration'
          WHERE baseline_id =  r1.baseline_id
               AND client_id = 205;
          COMMIT;

          UPDATE tmcs.tmcs_budgets
                  SET segment2 = approved_budget,
                      last_update_date = SYSDATE,
                      last_updated_by ='integration'
           WHERE budget_id = r1.budget_id
                AND client_id = 205;
         COMMIT;

        EXCEPTION
          WHEN OTHERS THEN
            p_buf := 'Error '||SQLERRM|| 'While writing payment '||r1.project_id ||' record in file '||l_file_name ;
            TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG(l_prog_name,SQLCODE,p_buf, l_file_name,  p_user, l_start_date,SYSDATE,l_client_id, 'PRJ_BGT_OUT', r1.project_id, 'E');
        END;

           UPDATE tmcs.tmcs_projects
                   SET status ='APPROVED'
           WHERE client_id = 205
                AND project_id = r1.project_id
                AND UPPER(status) not in ('ACTIVE','OP','INACTIVE','ARCHIVED') ;

           COMMIT;
      END LOOP;

      COMMIT;

      UTL_FILE.FCLOSE(output_file);

      IF l_cnt = 0 THEN
        UTL_FILE.FREMOVE('TMCS_MACY_PRJ_BGT_OUT_DIR', l_file_name);
        TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG(l_prog_name,0,'No approved budget exist to get the file generated', l_file_name,  p_user, l_start_date,SYSDATE,l_client_id, 'PRJ_BGT_OUT', '', 'E');
      ELSE
        TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG(l_prog_name,  0,'File is exported Successfully. ', l_file_name,  p_user, l_start_date,SYSDATE, l_client_id, 'PRJ_BGT_OUT', '', 'S');
      END IF;

    IF l_file_name IS NOT NULL  THEN

      BEGIN
        SELECT message || '.'
          INTO l_msg
          FROM tmcs_service_log
         WHERE program_name = l_prog_name
           AND UPPER(message) LIKE '%SUCCESS%'
           AND TRUNC(start_date) = TRUNC(SYSDATE)
           AND file_name = l_file_name
           AND ROWNUM < 2;
      EXCEPTION
        WHEN OTHERS THEN  NULL;
      END;

      l_err_fname := 'Macys_ProjectBudget_Export_Logfile_' || TO_CHAR(SYSDATE, 'mmddyyyy') || '.txt';
      dbms_output.put_line('file name is' || l_err_fname);

      err_file := utl_file.fopen('TMCS_MACY_PRJ_BGT_OUT_DIR',l_err_fname, 'W',32767);
      utl_file.put_line(err_file, 'PROGRAM_NAME' || '|' || 'START_DATE' || '|' || 'END_DATE' || '|' || 'FILE_NAME' || '|' || 'MESSAGE' || '|' ||
                                           'CREATION_DATE' || '|' || 'CREATED_BY' || '|' || 'LAST_UPDATE_DATE' || '|' ||'LAST_UPDATED_BY' || '|' || 'LAST_UPDATE_LOGIN' || '|' ||'SERVICE_LOG_ID');

      FOR r2 IN c2 LOOP
        dbms_output.put_line('writing in loop');
        utl_file.put_line(err_file, r2.program_name || '|' || r2.start_date || '|' || r2.end_date || '|' || r2.file_name || '|' || r2.message || '|' || r2.creation_date || '|' ||
                                             r2.created_by || '|' || r2.last_update_date || '|' || r2.last_updated_by || '|' || r2.last_update_login || '|' ||r2.service_log_id);
      END LOOP;

      utl_file.fclose_all;
      dbms_output.put_line('dir path' || l_dir_path);

      tmcs_Send_Mail.Prc_Send_Mail('admin@tangoanalytics.com',
                                   'Pavan.Kotta@TangoAnalytics.com,Vinay.Malashetti@TangoAnalytics.com, ICS@macys.com',
                                   NULL,
                                   NULL,
                                   'Macy - Project Budget Export Outbound Integration Service Log - ' ||TO_CHAR(SYSDATE, 'MM/DD/YYYY'),
                                   'Hello MACY,' || CHR(13) || l_msg || 'Please see the attachment for more details.' || CHR(13) || CHR(13) || '- Tango Analytics',
                                   l_dir_path, l_err_fname );
      utl_file.fclose_all;
    END IF;

 EXCEPTION
     WHEN OTHERS THEN
        TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG(l_prog_name,SQLCODE,SQLERRM||'at:'||dbms_utility.format_error_backtrace , l_file_name,  p_user, l_start_date,SYSDATE,l_client_id, 'PRJ_BGT_OUT', '', 'E');
        ROLLBACK;
    tmcs_Send_Mail.Prc_Send_Mail('admin@tangoanalytics.com', --p_in_from
                                  'Pavan.Kotta@TangoAnalytics.com,Vinay.Malashetti@TangoAnalytics.com,ICS@macys.com',
                                  NULL,  --p_in_cc
                                  NULL,  --p_in_bcc
                                  'Macy - Project Budget Export Outbound Integration Service Log - '||TO_CHAR(SYSDATE, 'MM/DD/YYYY'),
                                  'Hello Team MACY,'||CHR(13)||'Program has errored out because of '||SQLERRM||CHR(13)||CHR(13)||'- Tango Analytics',
                                  NULL,-- '/sftphome/bbby_dev/outbound/ap_invoices' --directory path
                                  NULL --p_file_name
                               );
 END;

--TASD-37215 -- Project-Delegated Commitments
PROCEDURE tmcs_project_delegated_group_out (
   P_USER IN VARCHAR2 := 'SCHEDULER')
AS
   l_file_name                      VARCHAR2 (100);
   l_SFTP_directory_path            VARCHAR2 (100);
   -- l_UTL_output_file                UTL_FILE.file_type;
   l_start_date                     DATE;
   l_total_processed_record_count   NUMBER := 0;
   l_client_id                      NUMBER;
   l_programm_name                  VARCHAR2 (100);
   l_file_moved_status              NUMBER;
   l_status                         VARCHAR2 (10);
   l_buffer                         VARCHAR2 (4000);
   l_user                           VARCHAR2 (100);
   l_oracle_directory_name          VARCHAR2 (100);
   l_from_mail_id                   VARCHAR2 (100);
   l_to_mail_id                     VARCHAR2 (4000);
   l_query_str                      VARCHAR2 (4000);

   CURSOR c_service_log
   IS
      SELECT *
        FROM tmcs.tmcs_service_log
       WHERE     program_name = l_programm_name
             AND client_id = 205
             AND start_date >= l_start_date;
BEGIN
   l_start_date := SYSTIMESTAMP;
   l_client_id := 205;
   l_user := NVL (tmcs_sec_ctx.get_user, USER);
   l_programm_name := 'TMCS_MACY_PRJDELEGATED_OUT_INT';
   l_oracle_directory_name := 'TMCS_MACY_PRJDELEGATED_OUT_DIR';
   l_from_mail_id := 'admin@tangoanalytics.com';
   l_to_mail_id :=
      'ramesh.Mittapalli@tangoanalytics.com,pavan.kotta@tangoanalytics.com,Vinay.Malashetti@TangoAnalytics.com,ICS@macys.com';

   l_file_name :=
         'Tango_Macys_Overage_Delegated_Commitments_'
      || TO_CHAR (SYSDATE, 'MMDDRRRRHHMISS')
      || '.xlsx';

   SELECT directory_path
     INTO l_SFTP_directory_path
     FROM all_directories
    WHERE directory_name = l_oracle_directory_name;



   FOR file_move
      IN (SELECT COLUMN_VALUE file_name
            FROM TABLE (list_files (l_SFTP_directory_path))
           WHERE UPPER (COLUMN_VALUE) LIKE
                    'TANGO_MACYS_OVERAGE_DELEGATED_COMMITMENTS_%TXT')
   LOOP
      DBMS_OUTPUT.put_line ('moving file');
      l_file_moved_status :=
         TMCS_MACY_OUT_INTF_PKG.cmd (
               'mv '
            || l_SFTP_directory_path
            || '/'
            || file_move.file_name
            || ' '
            || l_SFTP_directory_path
            || '/processed');
      DBMS_OUTPUT.put_line (
         'status of l_file_moved_status : ' || l_file_moved_status);
   END LOOP;

   l_query_str :=
      q'[ SELECT proj.project_name AS Project_Name,
               proj.project_number AS Project_Number,
               --proj.country,
               --budg.entity_id,
               SUBSTR (budg.sub_task_type, 1, 4) AS Delegated_Group,
               SUM (NVL (budg.approved_budget, 0)) AS Approved_Budget,
               SUM (NVL (budg.total_anticipated_commitment, 0))
                AS  Approved_Commitment,
               contact.email
          FROM tmcs.tmcs_budgets budg,
               tmcs.tmcs_contacts contact,
               tmcs.tmcs_projects proj
         WHERE     budg.sub_task_type IS NOT NULL
              AND budg.entity_id = contact.entity_id(+)
               AND contact.role IN ('APPVR1', 'APPVR2')
               AND budg.entity_id = proj.project_id
               AND budg.client_id = 205
               AND SUBSTR (budg.sub_task_type, 1, 4) IN
                      ('1100', '1200', '1400', '1500', '1600')
       GROUP BY budg.entity_id,
               SUBSTR (budg.sub_task_type, 1, 4),
               contact.email,
               proj.project_name,
               proj.project_number,
               proj.country
        HAVING SUM (NVL (approved_budget, 0))
               - SUM (NVL (total_anticipated_commitment, 0)) < 0
      ORDER BY proj.project_number]';

   DBMS_OUTPUT.put_line (l_query_str);

   TMCS_EXP_TO_XLSX_SHEETS_PKG.query2sheet (l_query_str);
   TMCS_EXP_TO_XLSX_SHEETS_PKG.set_column_width (p_col      =>1,
                               p_width    =>40,
                               p_sheet   =>1); --Project_Name
   TMCS_EXP_TO_XLSX_SHEETS_PKG.set_column_width (p_col      =>2,
                               p_width    =>30,
                               p_sheet   =>1);  --Project_Number

   TMCS_EXP_TO_XLSX_SHEETS_PKG.set_column_width (p_col      =>3,
                               p_width    =>30,
                               p_sheet   =>1);  --Delegated_Group
   TMCS_EXP_TO_XLSX_SHEETS_PKG.set_column_width (p_col      =>4,
                               p_width    =>20,
                               p_sheet   =>1);  --Approved_Budget
   TMCS_EXP_TO_XLSX_SHEETS_PKG.set_column_width (p_col      =>5,
                               p_width    =>30,
                               p_sheet   =>1);   --Approved_Commitment
   TMCS_EXP_TO_XLSX_SHEETS_PKG.set_column_width (p_col      =>6,
                               p_width    =>100,
                               p_sheet   =>1);   --EMAIL
   TMCS_EXP_TO_XLSX_SHEETS_PKG.save (l_oracle_directory_name,
                                                l_file_name);



     SELECT COUNT (1)
       INTO l_total_processed_record_count
     FROM (SELECT   proj.project_name AS Project_Name,
               proj.project_number AS Project_Number,
               --proj.country,
               --budg.entity_id,
               SUBSTR (budg.sub_task_type, 1, 4) AS Delegated_Group,
               SUM (NVL (budg.approved_budget, 0)) AS Approved_Budget,
               SUM (NVL (budg.total_anticipated_commitment, 0))
                AS  Approved_Commitment,
               contact.email
       FROM tmcs.tmcs_budgets budg,
            tmcs.tmcs_contacts contact,
            tmcs.tmcs_projects proj
      WHERE     budg.sub_task_type IS NOT NULL
            AND budg.entity_id = contact.entity_id(+)
            AND contact.role IN ('APPVR1', 'APPVR2')
            AND budg.entity_id = proj.project_id
            AND budg.client_id = 205
            AND SUBSTR (budg.sub_task_type, 1, 4) IN
                   ('1100', '1200', '1400', '1500', '1600')
   GROUP BY budg.entity_id,
            SUBSTR (budg.sub_task_type, 1, 4),
            contact.email,
            proj.project_name,
            proj.project_number,
            proj.country
     HAVING SUM (NVL (approved_budget, 0))
            - SUM (NVL (total_anticipated_commitment, 0)) < 0
   ORDER BY proj.project_number);


   tmcs_Send_Mail.Prc_Send_Mail (
      l_from_mail_id,
      l_to_mail_id,
      NULL,
      NULL,
         'Macy''s - Project Delegated Commitments  Integration Details  '
      || tmcs_db_instance_name
      || ' - '
      || TO_CHAR (SYSDATE, 'MM/DD/RRRR'),
         'Hello ,'
      || '<br>'
      || '<br>'
      || 'Total records processed are :'
      || l_total_processed_record_count
      || '<br>'
      || '<br>'
      || 'Please see the attachment for more details.'
      || '<br>'
      || '<br>'
      || '- Tango Analytics',
      l_SFTP_directory_path,                                  --directory path
      l_file_name                                                --p_file_name
                 );
EXCEPTION
   WHEN OTHERS
   THEN
      l_buffer := SQLERRM || 'at:' || DBMS_UTILITY.format_error_backtrace;
        DBMS_OUTPUT.put_line (l_query_str);
      tmcs_dukb_service_log_pkg.insert_log (
         p_program_name    => l_programm_name,
         P_MESSAGE_CODE    => SQLCODE,
         p_message         => l_buffer,
         p_file_name       => NULL,
         p_log_user        => l_user,
         p_start_date      => l_start_date,
         p_end_date        => SYSDATE,
         p_client_id       => l_client_id,
         p_entity_type     => 'PROJECT_DELEGATED_GROUP',
         p_entity_number   => NULL,
         p_status          => 'E',
         p_service_data    => NULL);
      ROLLBACK;
END tmcs_project_delegated_group_out;

--TASD-39132 (Macy's: Excluded Projects Outbound Integration)
PROCEDURE tmcs_excluded_project_out_data (p_user IN VARCHAR2 := 'SCHEDULER')
IS
   l_oracle_directory_name   VARCHAR2 (50);
   l_programm_name           VARCHAR2 (100);
   l_SFTP_directory_path     VARCHAR2 (100);
   l_file_name               VARCHAR2 (100);
   l_start_date              DATE;
   l_file_moved_status       NUMBER;
   l_output_file             UTL_FILE.file_type;
   l_client_id               tmcs.tmcs_clients.client_id%TYPE;
   l_country                 tmcs.tmcs_client_countries.country_code%TYPE;
   l_file_size               NUMBER := 0;
   l_user                    VARCHAR2 (100);
   l_reasondescription       VARCHAR (4000);
   l_steps_to_fix_error      VARCHAR2 (4000);
   l_template_description    VARCHAR2 (4000);
   l_record_count            NUMBER;
   l_from_mail_id            VARCHAR2 (4000);
   l_to_mail_id              VARCHAR2 (4000);
   l_total_err_records       NUMBER;
   l_proj_number1            NUMBER;
   l_proj_number2            NUMBER;

   CURSOR c_proj
   IS
       SELECT projects.project_id AS tangoprojectid,
                 projects.project_number,
                 projects.project_name,
                 projects.project_type,
                 projects.brand_id,
                 projects.master_project_id,
                 proj_attr.n_ext_attr2 AS project_location_count,
                 proj_attr.c_ext_lov2 AS projectowner,
                 (SELECT baseline_id
                       FROM tmcs_proj_baseline_versions baseline_version
                   WHERE baseline_version.project_id = projects.project_id
                          AND baseline_version.wf_status = 'APPROVED'
                          AND ROWNUM = 1)
                 project_budget_approved,
                 CASE  WHEN projects.entity_type IN ('STORE', 'SITE')
                               THEN stores.facility_type
                   ELSE   '1'  END  facility_type,
                 projects.is_master_project,
                 projects.budget_template_id,
                 (SELECT COUNT (DISTINCT (budget_template_id))
                      FROM tmcs_projects
                   WHERE budget_template_id IS NOT NULL
                         AND master_project_id = projects.project_id) AS child_template_cnt ,
                  CASE WHEN projects.is_master_project = 'Y' THEN
                      (SELECT tt.description
                           FROM tmcs_templates tt
                        WHERE entity_type = 'BUDGET'
                             AND template_type = 'BUDGET'
                             AND template_id IN (SELECT budget_template_id
                                                                            FROM tmcs_projects
                                                                        WHERE master_project_id= projects.project_id
                                                                               AND ROWNUM = 1)
                             AND ROWNUM = 1)
                      ELSE
                      (SELECT tt.description
                           FROM tmcs_templates tt
                        WHERE entity_type = 'BUDGET'
                              AND template_type = 'BUDGET'
                             AND template_id = projects.budget_template_id
                             AND ROWNUM = 1)
                  END template_desc
    FROM tmcs_projects projects,
                 tmcs_project_attributes proj_attr,
                 tmcs_all_stores stores
WHERE stores.store_id(+) = projects.entity_id
       AND projects.client_id = l_client_id
       AND proj_attr.c_ext_lov2 IS NOT NULL
       AND proj_attr.project_id = projects.project_id
    --   AND projects.project_id =94812
       AND projects.status IN ('DRAFT', 'PLANNING', 'SETUPREV', 'APPREV', 'CHANGE')
       AND projects.master_project_id IS NULL
       AND proj_attr.c_ext_lov16 <> '0'
      AND projects.country =l_country
      AND (CASE WHEN projects.is_master_project = 'Y' THEN
                              (SELECT COUNT(DISTINCT(budget_template_id)) FROM tmcs_projects s
                               WHERE s.master_project_id= projects.project_id
                                     AND s.budget_template_id IS NOT NULL)
                   ELSE 1 END )= 1
      AND EXISTS
                    (SELECT 1
                         FROM tmcs_proj_baseline_versions
                      WHERE client_id = l_client_id
                            AND wf_status = 'APPROVED'
                            AND project_id = projects.Project_id);
BEGIN

   l_start_date := SYSDATE;
   l_oracle_directory_name := 'TMCS_MACY_EXCL_PRJ_OUT_INT_DIR';
   l_programm_name := 'TMCS_MACY_EXCL_PRJ_OUT_INT_DIR';
   l_client_id := APPS.tmcs_sec_ctx.get_client_id;
   l_user := NVL (APPS.tmcs_sec_ctx.get_user, USER);
   l_total_err_records := 0;

   SELECT directory_path
     INTO l_SFTP_directory_path
     FROM all_directories
    WHERE directory_name = l_oracle_directory_name;

   FOR country_rec IN (SELECT client_id, country_code
                                                FROM tmcs_client_countries
                                            WHERE client_id = l_client_id)
   LOOP
      APPS.tmcs_Sec_ctx.set_context ('integration', country_rec.country_code, country_rec.client_id);

      l_country := country_rec.country_code;

      l_file_name := NULL;
      l_file_name := 'Tango_Macys_Unexported_Projects_'|| TO_CHAR (SYSDATE, 'MMDDYYHHMISSAM') || '.txt';
      l_output_file :=UTL_FILE.fopen (l_oracle_directory_name, l_file_name,'w', 32767);
      UTL_FILE.put_line (l_output_file,'Project Name'|| '|' || 'Project Number'|| '|' || 'Reason for not exporting the project'|| '|'|| 'Steps to fix the the error');

      FOR proj_rec IN c_proj
      LOOP
         l_template_description := NULL;
         --l_total_err_records:=0;
         l_proj_number1 := NULL;
         l_proj_number2 := NULL;

         BEGIN
            SELECT TO_NUMBER (SUBSTR (proj_rec.project_number, 1,INSTR (proj_rec.project_number,'-',1,1)- 1)),
                   TO_NUMBER (SUBSTR (proj_rec.project_number,INSTR (proj_rec.project_number,'-',1,1)+ 1))
              INTO l_proj_number1, l_proj_number2
              FROM DUAL;
         EXCEPTION WHEN OTHERS  THEN
               l_proj_number1 := NULL;
               l_proj_number2 := NULL;
         END;

         IF proj_rec.tangoprojectid IS NULL  THEN
            l_total_err_records := l_total_err_records + 1;
            l_reasondescription := 'Fatal Error: Project ID is not available';
            l_steps_to_fix_error := 'Go to the project in question' || ' - ' || 'Make sure the project number on general page is available if null';
            UTL_FILE.put_line (
               l_output_file,
                  proj_rec.project_name
               || '|'
               || proj_rec.project_number
               || '|'
               || l_reasondescription
               || '|'
               || l_steps_to_fix_error);
         END IF;

         IF proj_rec.project_name IS NULL  THEN
            l_total_err_records := l_total_err_records + 1;
            l_reasondescription := 'Fatal Error: Project Name is not available';
            l_steps_to_fix_error :='Go to the project in question' || ' - ' || 'Make sure the project name on general page is available if null';
            UTL_FILE.put_line (
               l_output_file,
                  proj_rec.project_name
               || '|'
               || proj_rec.project_number
               || '|'
               || l_reasondescription
               || '|'
               || l_steps_to_fix_error);
         END IF;

         IF l_proj_number1 IS NULL OR l_proj_number2 IS NULL THEN
            l_total_err_records := l_total_err_records + 1;
            l_reasondescription :='Fatal Error : Timberline Project Number is not availabl';
            l_steps_to_fix_error :='Go to the project in question' || ' - '|| 'Make sure the Timberline project number on general page is available if null';
            UTL_FILE.put_line (
               l_output_file,
                  proj_rec.project_name
               || '|'
               || proj_rec.project_number
               || '|'
               || l_reasondescription
               || '|'
               || l_steps_to_fix_error);
         END IF;

         IF proj_rec.project_type IS NULL  THEN
            l_total_err_records := l_total_err_records + 1;
            l_reasondescription :='Fatal Error : Project Type is not available';
            l_steps_to_fix_error :='Go to the project in question' || ' - ' || 'Make sure the project type on general page is available if null';
            UTL_FILE.put_line (
               l_output_file,
                  proj_rec.project_name
               || '|'
               || proj_rec.project_number
               || '|'
               || l_reasondescription
               || '|'
               || l_steps_to_fix_error);
         END IF;

         IF proj_rec.brand_id IS NULL  THEN
            l_total_err_records := l_total_err_records + 1;
            l_reasondescription := 'Fatal Error : Division is not available';
            l_steps_to_fix_error := 'Go to the Location in question'|| ' - '|| 'Make sure the division is populated on the store module';
            UTL_FILE.put_line (
               l_output_file,
                  proj_rec.project_name
               || '|'
               || proj_rec.project_number
               || '|'
               || l_reasondescription
               || '|'
               || l_steps_to_fix_error);
         END IF;

         IF proj_rec.projectowner IS NULL  THEN
            l_total_err_records := l_total_err_records + 1;
            l_reasondescription := 'Fatal Error : Project Owner not present';
            l_steps_to_fix_error := 'Go to the project in question' || ' - ' || 'Make sure the project owner is populated on the attributes tab on projects module';
            UTL_FILE.put_line (
               l_output_file,
                  proj_rec.project_name
               || '|'
               || proj_rec.project_number
               || '|'
               || l_reasondescription
               || '|'
               || l_steps_to_fix_error);
         END IF;

         IF  proj_rec.template_desc IS NULL THEN
            l_total_err_records := l_total_err_records + 1;
            l_reasondescription :='Fatal Error : Project Budget is not present';
            l_steps_to_fix_error := 'Go to the project in question' || ' - '|| 'Make sure the budget template exists for the project or budget template on all child locations exists';
            UTL_FILE.put_line (
               l_output_file,
                  proj_rec.project_name
               || '|'
               || proj_rec.project_number
               || '|'
               || l_reasondescription
               || '|'
               || l_steps_to_fix_error);
         END IF;

         IF proj_rec.facility_type IS NULL THEN
            l_total_err_records := l_total_err_records + 1;
            l_reasondescription := 'Fatal Error : Project Building is not owned or leased';
            l_steps_to_fix_error := 'Go to the Location in question' || ' - ' || 'Make sure the project building exists for the project and is owned or leases';
            UTL_FILE.put_line (
               l_output_file,
                  proj_rec.project_name
               || '|'
               || proj_rec.project_number
               || '|'
               || l_reasondescription
               || '|'
               || l_steps_to_fix_error);
         END IF;
       /*
         IF proj_rec.project_location_count IS NULL  THEN
            l_total_err_records := l_total_err_records + 1;
            l_reasondescription := 'Fatal Error : Project Location count is null';
            l_steps_to_fix_error := 'Go to the project in question'|| ' - ' || 'Make sure the project location count is not null';
            UTL_FILE.put_line (
               l_output_file,
                  proj_rec.project_name
               || '|'
               || proj_rec.project_number
               || '|'
               || l_reasondescription
               || '|'
               || l_steps_to_fix_error);
         END IF; */

         IF proj_rec.project_budget_approved IS NULL  THEN
            l_total_err_records := l_total_err_records + 1;
            l_reasondescription :='Fatal Error : Project Budget is not approved';
            l_steps_to_fix_error :='Go to the project in question' || ' - ' || 'Make sure the budget is approved';
            UTL_FILE.put_line (
               l_output_file,
                  proj_rec.project_name
               || '|'
               || proj_rec.project_number
               || '|'
               || l_reasondescription
               || '|'
               || l_steps_to_fix_error);
         END IF;

         IF proj_rec.child_template_cnt > 1 AND proj_rec.Is_Master_Project = 'Y' THEN
            l_total_err_records := l_total_err_records + 1;
            l_reasondescription :='Fatal Error: Master Project has different child budget templates';
            l_steps_to_fix_error :='Go to the project in question' || ' - '|| 'Remove all the child projects associated with master project with wrong template and create new child projects with correct budget template and associate with master project';
            UTL_FILE.put_line (
               l_output_file,
                  proj_rec.project_name
               || '|'
               || proj_rec.project_number
               || '|'
               || l_reasondescription
               || '|'
               || l_steps_to_fix_error);
         END IF;
      END LOOP;                                                    ---Proj_rec
   END LOOP;

   UTL_FILE.put_line (l_output_file, 'Record Count' || '|' || l_total_err_records);

   UTL_FILE.fclose_all;

    IF l_total_err_records =0 THEN
       UTL_FILE.FREMOVE('TMCS_MACY_EXCL_PRJ_OUT_INT_DIR', l_file_name);
    END IF;

   tmcs_dukb_service_log_pkg.insert_log (
      p_program_name    => l_programm_name,
      p_message_code    => SQLCODE,
      p_message         => 'Record Count ' || l_record_count,
      p_file_name       => l_file_name,
      p_log_user        => l_user,
      p_start_date      => l_start_date,
      p_end_date        => SYSDATE,
      p_client_id       => l_client_id,
      p_entity_type     => NULL,
      p_entity_number   => NULL,
      p_status          => 'S',
      p_service_data    => NULL);

   l_from_mail_id := 'admin@tangoanalytics.com';
   l_to_mail_id := 'swetha.reddy@tangoanalytics.com,Vinay.Malashetti@TangoAnalytics.com,ICS@macys.com';  --pavan.kotta@tangoanalytics.com,

   tmcs_Send_Mail.Prc_Send_Mail (
      l_from_mail_id,
      l_to_mail_id,
      NULL,
      NULL,
      'Macy''s - Excluded Projects Details  ' || tmcs_db_instance_name || ' - ' || TO_CHAR (SYSDATE, 'MM/DD/RRRR'),
       'Hello ,'
      || '<br>'
      || 'Total project count not exported are :'|| l_total_err_records
      || '<br>'
      || CASE WHEN l_total_err_records =0 THEN  '- Tango Analytics'
             ELSE 'Please see the attachment for more details.'|| '<br>' || '- Tango Analytics'
             END,
      l_SFTP_directory_path,                                  --directory path
      l_file_name                                                --p_file_name
                 );
EXCEPTION  WHEN OTHERS THEN
      tmcs_dukb_service_log_pkg.insert_log (
         p_program_name    => l_programm_name,
         p_message_code    => SQLCODE,
         p_message         => SUBSTR (SQLERRM, 1, 250),
         p_file_name       => l_file_name,
         p_log_user        => l_user,
         p_start_date      => l_start_date,
         p_end_date        => SYSDATE,
         p_client_id       => l_client_id,
         p_entity_type     => NULL,
         p_entity_number   => NULL,
         p_status          => 'E',
         p_service_data    => NULL);
END tmcs_excluded_project_out_data;

    PROCEDURE TMCS_PROJECT_EXPORTS_OUT(P_USER IN VARCHAR2 := 'SCHEDULER')
    IS
          l_oracle_directory_name       VARCHAR2 (50);
          l_program_name                VARCHAR2 (100);
          l_os_directory_path           VARCHAR2 (100);
          l_file_moved_status           NUMBER;
          l_output_file                 UTL_FILE.file_type;
          err_file                      UTL_FILE.file_type;
          l_start_date                  DATE;
          l_client_id                   tmcs.tmcs_clients.client_id%TYPE;
          l_file_name                   VARCHAR2 (100);
          l_user                        VARCHAR2 (100);
          l_count_file                  NUMBER := 0;
          l_cnt                         NUMBER := 0;
          l_msg                         VARCHAR2(4000);
          l_err_fname                   VARCHAR2(100);

          CURSOR cur_prj_export IS
                SELECT
                         prj.project_id
                        ,prj.project_number
                        ,prj.project_name
                        ,(
                            SELECT  status
                            FROM    tmcs_entity_statuses sts
                            WHERE   sts.client_id           = 205
                            AND     sts.status_code         = prj.status
                            AND 	UPPER(sts.entity_type)  = 'PROJECT'
                            AND     ROWNUM = 1
                        ) status
                        ,NVL
                            (
                                (
                                    SELECT TO_CHAR(MIN(hist.last_update_date),'MM/DD/YYYY')
                                    FROM    tmcs_projects_hist hist
                                    WHERE   hist.client_id = prj.client_id
                                    AND     hist.project_id = prj.project_id
                                    AND     UPPER(hist.status) = 'APPROVED'
                                    GROUP BY hist.project_id
                                ), NULL
                            ) project_approved_date
                FROM tmcs_projects prj
                WHERE   UPPER(prj.status) IN ('APPROVED','CHANGE')
                AND     prj.client_id   = 205
                -- AND     project_id = 75499
                AND     prj.project_id NOT IN
                (
                    SELECT  project_id
                    FROM    tmcs_projects_hist
                    WHERE   client_id       =   205
                    -- AND project_id = 75499
                    AND     UPPER(status)   NOT IN ('APPROVED','CHANGE')
                    AND     TO_CHAR(last_update_date,'MM/DD/YYYY') > TO_CHAR((sysdate-2),'MM/DD/YYYY')
                );

           /* (
                    SELECT   project_id
                            ,project_number
                            ,status
                            ,TO_CHAR(MAX(last_update_date),'MM/DD/YYYY') max_last_update_date
                    FROM    tmcs_projects_hist
                    WHERE   project_id IN
                    (
                        SELECT  project_id
                        FROM    tmcs_projects
                        WHERE   status      = 'APPROVED'
                        AND     client_id   = 205
                    )
                    AND client_id       =   205
                    AND UPPER(status)   IN ('DRAFT','APPROVED')
                    AND (UPPER(last_updated_by) <> UPPER('conversion')
                    OR UPPER(last_updated_by) <> UPPER('integration'))
                    GROUP BY status, project_number, project_id
                    UNION ALL
                    SELECT   project_id
                            ,project_number
                            ,status
                            ,TO_CHAR(MAX(last_update_date),'MM/DD/YYYY') max_last_update_date
                    FROM    tmcs_projects_hist
                    WHERE   project_id IN
                    (
                        SELECT  project_id
                        FROM    tmcs_projects
                        WHERE   status      =   'CHANGE'
                        AND     client_id   =   205
                    )
                    AND     client_id   =   205
                    AND     status      IN  ('ACTIVE','CHANGE')
                    AND (UPPER(last_updated_by) <> UPPER('conversion')
                    OR UPPER(last_updated_by) <> UPPER('integration'))
                    GROUP BY status, project_number, project_id
            )
            ORDER BY project_id;*/


        CURSOR cur_log IS
            SELECT  *
            FROM    tmcs_service_log
            WHERE   program_name    = 'TMCS_MACY_PRJ_EXPORT_OUT_INTF'
            AND     client_id       = 205
            AND     start_date      =   (
                                            SELECT  MAX(start_date)
                                            FROM    tmcs_service_log
                                            WHERE   client_id = 205
                                            AND     program_name = 'TMCS_MACY_PRJ_EXPORT_OUT_INTF'
                                        );

    BEGIN

        l_start_date            :=  SYSDATE;
        l_client_id             :=  205;
        l_user                  :=  NVL (tmcs_sec_ctx.get_user, USER);
        l_oracle_directory_name :=  'TMCS_MACY_PRJ_EXPORT_OUT_DIR';
        l_program_name         :=  'TMCS_MACY_PRJ_EXPORT_OUT_INTF';

        SELECT  directory_path
        INTO    l_os_directory_path  -- /sftphome/macy_dev/outbound/capital_planning_report
        FROM    all_directories
        WHERE   directory_name = l_oracle_directory_name;

        SELECT  COUNT(column_value)
        INTO    l_count_file
        FROM    TABLE(list_files(l_os_directory_path))
        WHERE   UPPER(column_value) LIKE 'PROJECT_EXPORTS%.CSV'
        ORDER BY 1;

        DBMS_OUTPUT.put_line (l_os_directory_path);

         IF  l_count_file   >=  1 THEN

        FOR file_move IN (
                            SELECT  COLUMN_VALUE file_name
                            FROM    TABLE (list_files (l_os_directory_path))
                            WHERE   UPPER (COLUMN_VALUE) LIKE 'PROJECT_EXPORTS%.CSV'
                        )
        LOOP

                dbms_output.put_line('moving file');
                l_file_moved_status :=
                    TMCS_MACY_OUT_INTF_PKG.cmd (
                          'mv '
                       || l_os_directory_path
                       || '/'
                       || file_move.file_name
                       || ' '
                       || l_os_directory_path
                       || '/processed/');

                   dbms_output.put_line('status of l_file_moved_status : '||l_file_moved_status);
        END LOOP;

        END IF;


            BEGIN
                    SELECT 'Project_Exports_'|| TO_CHAR (SYSDATE, 'YYYMMDDHHMMSS') || '.csv'  INTO l_file_name FROM DUAL;
                    DBMS_OUTPUT.put_line ('File Name 1 before opening the file: '||l_file_name);

                    l_output_file := UTL_FILE.fopen (l_oracle_directory_name,l_file_name, 'W', 32767);
                    DBMS_OUTPUT.put_line ('File Name 1 After opening the file: '||l_file_name);

                    UTL_FILE.put_line (l_output_file,
                                      'Tango Project ID'      || ',' ||
                                      'Timberline Project/Job Number'  || ','||
                                      'Project Name'  || ','||
                                      'Status'          || ','||
                                      'Project Approved Date'
                                      );

                     FOR macy_prj_exp IN cur_prj_export
                     LOOP

                        IF  (macy_prj_exp.PROJECT_ID IS NULL OR
                            macy_prj_exp.PROJECT_NUMBER IS NULL OR
                            macy_prj_exp.PROJECT_NAME IS NULL OR
                            macy_prj_exp.STATUS IS NULL OR
                            macy_prj_exp.PROJECT_APPROVED_DATE IS NULL
                            )
                        THEN

                                 TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG (
                                            l_program_name,
                                            1,
                                            'Required fields are not present:  '
                                            || macy_prj_exp.PROJECT_ID,
                                            NULL,
                                            'Scheduler',
                                            l_start_date,
                                            SYSDATE,
                                            tmcs_sec_ctx.get_client_id,
                                            'macy_prj_exp',
                                            '',
                                            'F');
                        END IF;

                        IF  (macy_prj_exp.PROJECT_ID IS NOT NULL
                            AND macy_prj_exp.PROJECT_NUMBER IS NOT NULL
                            AND macy_prj_exp.PROJECT_NAME IS NOT NULL
                            AND macy_prj_exp.STATUS IS NOT NULL
                            AND macy_prj_exp.PROJECT_APPROVED_DATE IS NOT NULL
                            )
                        THEN

                            l_cnt := l_cnt +1;

                            UTL_FILE.put_line   (l_output_file,
                                                macy_prj_exp.PROJECT_ID         || ',' ||
                                                macy_prj_exp.PROJECT_NUMBER     || ','||
                                                macy_prj_exp.PROJECT_NAME     || ','||
                                                macy_prj_exp.STATUS             || ','||
                                                macy_prj_exp.PROJECT_APPROVED_DATE);

                        END IF;

                     END LOOP;

                     UTL_FILE.fclose (l_output_file);

                     tmcs_dukb_service_log_pkg.insert_log (
                        p_program_name    => l_program_name,
                        p_message_code    => SQLCODE,
                        p_message         => SQLERRM,
                        p_file_name       => l_file_name,
                        p_log_user        => l_user,
                        p_start_date      => l_start_date,
                        p_end_date        => SYSDATE,
                        p_client_id       => l_client_id,
                        p_entity_type     => NULL,
                        p_entity_number   => NULL,
                        p_status          => 'S',
                        p_service_data    => NULL);

                     COMMIT;

            EXCEPTION
            WHEN OTHERS
            THEN
                    ROLLBACK;

                    tmcs_dukb_service_log_pkg.insert_log (
                       p_program_name    => l_program_name,
                       p_message_code    => SQLCODE,
                       p_message         => SQLERRM||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                       p_file_name       => l_file_name,
                       p_log_user        => l_user,
                       p_start_date      => l_start_date,
                       p_end_date        => SYSDATE,
                       p_client_id       => l_client_id,
                       p_entity_type     => NULL,
                       p_entity_number   => NULL,
                       p_status          => 'E',
                       p_service_data    => NULL);

            END;

            IF l_cnt = 0 THEN    UTL_FILE.FREMOVE('TMCS_MACY_PRJ_EXPORT_OUT_DIR', l_file_name);

                TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG(
                                                        l_program_name
                                                        ,0
                                                        ,'No approved invoices exist to get the file generated'
                                                        ,l_file_name
                                                        , p_user
                                                        ,l_start_date
                                                        ,SYSDATE
                                                        ,l_client_id
                                                        ,'macy_prj_exp'
                                                        ,''
                                                        ,'E'
                                                    );

            ELSE

                TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG(
                                                        l_program_name
                                                        ,0
                                                        ,'File is exported Successfully.'
                                                        ,l_file_name
                                                        ,p_user
                                                        ,l_start_date
                                                        ,SYSDATE
                                                        ,l_client_id
                                                        ,'macy_prj_exp'
                                                        ,''
                                                        ,'S'
                                                    );

            END IF;

            IF l_file_name IS NOT NULL AND l_cnt <> 0  THEN

                    BEGIN

                        SELECT      message
                        INTO        l_msg
                        FROM        tmcs_service_log
                        WHERE       client_id           =       l_client_id
                        AND         program_name        like    'TMCS_MACY_PRJ_EXPORT_OUT_INTF'
                        AND         UPPER(message)      like    '%SUCCESS%'
                        AND         TRUNC(start_date)   =       TRUNC(SYSDATE)
                        AND         file_name           =       l_file_name
                        AND         ROWNUM < 2;

                        tmcs_Send_Mail.Prc_Send_Mail('admin@TangoAnalytics.com'
                                           ,'pavani.srivatsavaye@TangoAnalytics.com,misran.mohamed@tangoanalytics.com,vineet.joshi@tangoanalytics.com,
                                           joan.frudden@macys.com,joe.kohl@macys.com,julie.glenn@macys.com'
                                           ,NULL
                                           ,NULL
                                           ,'MACY Project Export Outbound Integration Service Log - '||TO_CHAR(SYSDATE, 'MM/DD/YYYY')
                                           ,'Hello ,'||CHR(13)||l_msg||'Please see the attachment for more details.'||CHR(13)||CHR(13)||'- Tango Analytics'
                                           ,l_os_directory_path
                                           ,l_file_name
                                           );

                    EXCEPTION WHEN OTHERS THEN

                        NULL;

                    END;

                          l_err_fname :=  'Project_Exports_OutLog_file_'||TO_CHAR(SYSDATE,'mmddyyyy')||'.txt';

                          err_file := utl_file.fopen('TMCS_MACY_PRJ_EXPORT_OUT_DIR',l_err_fname ,'W', 32767);

                          utl_file.put_line(
                                                err_file
                                                ,'PROGRAM_NAME'     ||'|'||
                                                'START_DATE'        ||'|'||
                                                'END_DATE'          ||'|'||
                                                'FILE_NAME'         ||'|'||
                                                'MESSAGE'           ||'|'||
                                                'CREATION_DATE'     ||'|'||
                                                'CREATED_BY'        ||'|'||
                                                'LAST_UPDATE_DATE'  ||'|'||
                                                'LAST_UPDATED_BY'   ||'|'||
                                                'LAST_UPDATE_LOGIN' ||'|'||
                                                'SERVICE_LOG_ID'
                                            );

                    FOR serv_log IN cur_log LOOP

                           utl_file.put_line(
                                                err_file,
                                                serv_log.program_name       ||'|'||
                                                serv_log.start_date         ||'|'||
                                                serv_log.end_date           ||'|'||
                                                serv_log.file_name          ||'|'||
                                                serv_log.message            ||'|'||
                                                serv_log.creation_date      ||'|'||
                                                serv_log.created_by         ||'|'||
                                                serv_log.last_update_date   ||'|'||
                                                serv_log.last_updated_by    ||'|'||
                                                serv_log.last_update_login  ||'|'||
                                                serv_log.service_log_id
                                            );

                     END LOOP;

                UTL_FILE.FCLOSE(err_file);

        END IF;


    END TMCS_PROJECT_EXPORTS_OUT;

END TMCS_MACY_OUT_INTF_PKG;
/

