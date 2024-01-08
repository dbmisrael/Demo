CREATE OR REPLACE EDITIONABLE PACKAGE BODY TMCS_LANDLORD_SALE_AUTOMATION
AS

function get_customized_data(p_query_str varchar2,p_lease_id number) return report_ref_cursor IS
    PRAGMA UDF;
    l_ref_cursor report_ref_cursor := null;
    p_query_str_new varchar2(3000);
  BEGIN
  IF p_query_str IS NOT NULL THEN
    p_query_str_new := p_query_str || ' and entity_id='||p_lease_id;

  ELSE
      p_query_str_new :='select null from dual';
  END IF;

     OPEN l_ref_cursor for p_query_str_new;
    return l_ref_cursor;
  END get_customized_data;

 PROCEDURE set_busrting_header_status (p_client_id    NUMBER)

   AS
   BEGIN

    update  tmcs.tmcs_bip_bursting_hdr set status='COMPLETED'   where   client_id = p_client_id and status='RFB';
    COMMIT;

   EXCEPTION
      WHEN OTHERS
      THEN
         NULL;
   END set_busrting_header_status;
PROCEDURE set_landlord_sales_data(p_error_code OUT  NUMBER,
                                  p_error_msg  OUT   VARCHAR2,
                                  p_query_str VARCHAR2
   )
IS
l_refcursor    SYS_REFCURSOR;
l_xmltype      XMLTYPE;
   l_xml          CLOB := EMPTY_CLOB ();
   l_xml_data  CLOB := EMPTY_CLOB ();
BEGIN

  DBMS_OUTPUT.PUT_LINE('Inside standarad Sales Data');
OPEN l_refcursor FOR
WITH pct_rent_tab
     AS (SELECT *
           FROM (  SELECT ROW_NUMBER ()
                          OVER (
                             PARTITION BY a.lease_id
                             ORDER BY
                                a.lease_id,
                                DECODE (breakpoint_type,
                                        'NATURAL', 1,
                                        'ARTIFICIAL', 2,
                                        'NONE', 3))
                             test,
                          a.*
                     FROM TMCS_LEASE_PCT_RENT a, (select * from tmcs_leases where lease_id IN
                                 (SELECT entity_id
                                    FROM tmcs_bip_bursting_hdr hdr,
                                         tmcs_bip_bursting_chd bchd
                                   WHERE  hdr.HDR_ID = bchd.HDR_ID
                                         AND bchd.client_id = tmcs_sec_ctx.get_client_id
                                         AND bchd.country = tmcs_sec_ctx.get_country_code
                                         AND hdr.STATUS = 'PENDING')) lease
                    WHERE     lease.lease_status = 'ACTIVE'
                          AND a.lease_id = lease.lease_id
                          AND a.pct_rent_status = 'ACTIVE'
                 ORDER BY a.lease_id,
                          DECODE (breakpoint_type,
                                  'NATURAL', 1,
                                  'ARTIFICIAL', 2,
                                  'NONE', 3))
          WHERE test = 1),
     pct_rent_tab_fre as (
            SELECT * FROM pct_rent_tab a, (SELECT bchd.*
                                    FROM tmcs_bip_bursting_hdr hdr,
                                         tmcs_bip_bursting_chd bchd
                                   WHERE  hdr.HDR_ID = bchd.HDR_ID
                                         AND bchd.client_id = tmcs_sec_ctx.get_client_id
                                         AND bchd.country = tmcs_sec_ctx.get_country_code
                                         AND hdr.STATUS = 'PENDING') BCHD
                                    where a.lease_id = bchd.entity_id
                                        AND BCHD.client_id = tmcs_sec_ctx.get_client_id
                                        AND BCHD.country = tmcs_sec_ctx.get_country_code ) ,
     sales_calc_tab
     AS (
   SELECT SALES_CALC.*, NVL(REPORTING_FREQUENCY_PERIOD , 'NET') REPORTING_FREQUENCY_PERIOD
           FROM TMCS_LEASE_SALES_CALC SALES_CALC,  pct_rent_tab
          WHERE   SALES_CALC.lease_id = pct_rent_tab.lease_id
          AND  SALES_CALC.LEASE_PCT_RENT_ID = pct_rent_id
                AND TO_DATE (calendar_month_num || '-' || calendar_year,
                             'MM-YYYY') BETWEEN ADD_MONTHS (sysdate, -13)
                                            AND ADD_MONTHS (sysdate, -1)),
     fiscal_year_data_tab
     AS (SELECT lease_id,
                CASE
                   WHEN TO_NUMBER (TO_CHAR (ADD_MONTHS (sysdate, -1), 'MM')) >=
                           start_month
                   THEN
                      TO_NUMBER (TO_CHAR (ADD_MONTHS (sysdate, -1), 'YYYY'))
                   WHEN TO_NUMBER (TO_CHAR (ADD_MONTHS (sysdate, -1), 'MM')) <
                           start_month
                   THEN
                        TO_NUMBER (
                           TO_CHAR (ADD_MONTHS (sysdate, -1), 'YYYY'))
                      - 1
                END
                   fiscal_year,
                CASE
                   WHEN TO_NUMBER (TO_CHAR (ADD_MONTHS (sysdate, -1), 'MM')) >
                           start_month
                   THEN
                        (  TO_NUMBER (
                              TO_CHAR (ADD_MONTHS (sysdate, -1), 'MM'))
                         - start_month)
                      + 1
                   WHEN TO_NUMBER (TO_CHAR (ADD_MONTHS (sysdate, -1), 'MM')) <
                           start_month
                   THEN
                        ( (12 - start_month) + 1)
                      + TO_NUMBER (TO_CHAR (ADD_MONTHS (sysdate, -1), 'MM'))
                   WHEN TO_NUMBER (TO_CHAR (ADD_MONTHS (sysdate, -1), 'MM')) =
                           start_month
                   THEN
                      1
                END
                   month_number,
                TO_NUMBER (TO_CHAR (ADD_MONTHS (sysdate, -1), 'MM'))
                   calendar_month_num,
                TO_NUMBER (TO_CHAR (ADD_MONTHS (sysdate, -1), 'YYYY'))
                   calendar_year
           FROM pct_rent_tab),
     fiscal_year_data_tab
     AS (
   SELECT DISTINCT lease_id,
                         fiscal_year,
                         month_number,
                         calendar_month_num,
                         calendar_year,
                         REPORTING_FREQUENCY_PERIOD
           FROM sales_calc_tab
          WHERE     calendar_year =
                       TO_CHAR (ADD_MONTHS (sysdate, -1), 'YYYY')
                AND calendar_month_num IN
                       (TO_CHAR (ADD_MONTHS (sysdate, -1), 'MM'),
                        TO_CHAR (ADD_MONTHS (sysdate, -2), 'MM'),
                        TO_CHAR (ADD_MONTHS (sysdate, -3), 'MM'))),
     sales_data
     AS (SELECT fre.key,fre.frequency,sales.*,
                fiscal.month_number test1,
                CASE
                   WHEN     frequency = 'QUA'
                        AND fiscal.month_number IN (3, 6, 9, 12)
                   THEN
                         'for the period '
                      || ADD_MONTHS (
                            (MAX (
                                TO_DATE (
                                      sales.calendar_month_num
                                   || '-'
                                   || sales.calendar_year,
                                   'MM-YYYY'))
                             OVER (PARTITION BY sales.lease_id
                                   ORDER BY sales.lease_id)),
                            -3)
                      || ' and '
                      || MAX (
                            TO_DATE (
                                  sales.calendar_month_num
                               || '-'
                               || sales.calendar_year,
                               'MM-YYYY'))
                         OVER (PARTITION BY sales.lease_id
                               ORDER BY sales.lease_id)
                      || ' '
                      || ' ('
                      || CASE
                            WHEN fiscal.month_number IN (1, 2, 3)
                            THEN
                               'Quarter1'
                            WHEN fiscal.month_number IN (4, 5, 6)
                            THEN
                               'Quarter2'
                            WHEN fiscal.month_number IN (7, 8, 9)
                            THEN
                               'Quarter3'
                            WHEN fiscal.month_number IN (10, 11, 12)
                            THEN
                               'Quarter4'
                         END
                      || ')'
                   WHEN     frequency = 'SEM'
                        AND fiscal.month_number IN (6 , 12)
                   THEN
                         'for the period '
                      || ADD_MONTHS (
                            (MAX (
                                TO_DATE (
                                      sales.calendar_month_num
                                   || '-'
                                   || sales.calendar_year,
                                   'MM-YYYY'))
                             OVER (PARTITION BY sales.lease_id
                                   ORDER BY sales.lease_id)),
                            -3)
                      || ' and '
                      || MAX (
                            TO_DATE (
                                  sales.calendar_month_num
                               || '-'
                               || sales.calendar_year,
                               'MM-YYYY'))
                         OVER (PARTITION BY sales.lease_id
                               ORDER BY sales.lease_id)
                      || ' '
                      || ' ('
                      || CASE
                            WHEN fiscal.month_number IN (1, 2, 3,4, 5, 6)
                            THEN
                               'Semiannual1'
                            WHEN fiscal.month_number IN (7, 8, 9,10, 11, 12)
                            THEN
                               'Semiannual2'
                         END
                      || ')'
                   WHEN frequency = 'ANN'
                   THEN
                         'for the period of: '
                      || 'for the period '
                      || ADD_MONTHS (
                            (MAX (
                                TO_DATE (
                                      sales.calendar_month_num
                                   || '-'
                                   || sales.calendar_year,
                                   'MM-YYYY'))
                             OVER (PARTITION BY sales.lease_id
                                   ORDER BY sales.lease_id)),
                            -3)
                      || ' and '
                      || MAX (
                            TO_DATE (
                                  sales.calendar_month_num
                               || '-'
                               || sales.calendar_year,
                               'MM-YYYY'))
                         OVER (PARTITION BY sales.lease_id
                               ORDER BY sales.lease_id)
                   WHEN frequency = 'MON'
                   THEN
                         'for the month of: '
                      || MAX (
                            TO_DATE (
                                  sales.calendar_month_num
                               || '-'
                               || sales.calendar_year,
                               'MM-YYYY'))
                         OVER (PARTITION BY sales.lease_id
                               ORDER BY sales.lease_id)
                END
                   MESSAGE,
               (TO_CHAR (TO_DATE (TO_NUMBER (sales.CALENDAR_MONTH_NUM), 'MM'), 'Month'))
            month_name
           FROM sales_calc_tab sales, fiscal_year_data_tab fiscal,pct_rent_tab_fre fre
          WHERE     sales.lease_id = fiscal.lease_id
                AND sales.fiscal_year = fiscal.fiscal_year
                AND sales.lease_id = fre.lease_id
                AND CASE
                       WHEN     frequency = 'QUA'
                            AND fiscal.month_number IN (3, 6, 9, 12)
                       THEN
                          1
                       WHEN     frequency = 'ANN'
                            AND fiscal.month_number IN (12)
                       THEN
                          1
                       WHEN     frequency = 'SEM'
                            AND fiscal.month_number IN (6, 12)
                       THEN
                          1
                       WHEN     frequency = 'MON'
                            AND fiscal.calendar_month_num IN
                                   (TO_CHAR (ADD_MONTHS (sysdate, -1), 'MM'))
                       THEN
                          1
                    END = 1
               ORDER BY  TO_DATE (sales.calendar_month_num || '-' || sales.calendar_year, 'MM-YYYY') ASC   )
  SELECT  TO_CHAR(SYSDATE,'MM/DD/YYYY') CURR_DATE,
          'KK' || SUBSTR (store.s_store_number, -4) l_store_4_digit,
          lease.*,
          store.*,
          tss.*,
          tss.address1 || tss.address2 || tss.ADDRESS3 COMPANY_ADDRESS,
          nvl(supplier_contacts.role,tls.SUPPLIER_SITE_TYPE) role,
          fre.key,
          CURSOR(select * from sales_data where lease_id = fre.lease_id and frequency = fre.frequency) sales_data ,
          get_customized_data(p_query_str,fre.lease_id) PARAM10_DATA

    FROM pct_rent_tab_fre fre,
         TMCS_LEASE_SUPPLIER_CONTACTS supplier_contacts,
               TMCS_LEASE_SUPPLIERS tls,
               TMCS_SUPPLIER_SITES tss,
               tmcs_leases_rv lease,
               tmcs_lease_loc loc,
               tmcs_all_stores_rv store
    where fre.lease_id = lease.l_lease_id
          AND lease.l_lease_id = tls.lease_id
               AND tls.LEASE_ID = supplier_contacts.LEASE_ID(+)
               AND tls.SUPPLIER_SITE_ID =
                      supplier_contacts.SUPPLIER_SITE_ID(+)
               AND tss.SUPPLIER_SITE_ID(+) = tls.Supplier_Site_Id
               AND CASE WHEN supplier_contacts.role = 'SALESRPT' THEN 1
                                WHEN tls.SUPPLIER_SITE_TYPE = 'SALESRPT' THEN 1
                               END =1
               AND lease.l_lease_id = loc.lease_id
               AND loc.location_id = store.s_store_id--where lease_id=3167838
ORDER BY fre.lease_id, frequency;

        l_xmltype := XMLTYPE (l_refcursor);
         l_xml := l_xmltype.getClobVal;

         l_xml := REPLACE(REPLACE(l_xml,'<?xml version=1.0?>
<ROWSET>'),'</ROWSET>');

BEGIN

   SELECT XML_DATA INTO l_xml_data FROM ( SELECT hdr.*,RANK() OVER (PARTITION BY hdr.CLIENT_ID
                       ORDER BY CREATION_DATE DESC) Rank  from  tmcs_bip_bursting_hdr hdr where hdr.CLIENT_ID = tmcs_sec_ctx.get_client_id
                    and hdr.STATUS='PENDING' ) WHERE RANK = 1 ;

 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 p_error_code := -99;
        p_error_msg := 'No BI Bursting Header entry found';
        RETURN;
 END;

  IF (l_xml_data IS NOT NULL) THEN
        l_xml := l_xml_data||l_xml;
  END IF;

    UPDATE tmcs_bip_bursting_hdr hdr set XML_DATA=l_xml--, status='Ready for Bursting'
                where hdr.CLIENT_ID=tmcs_sec_ctx.get_client_id
                    and hdr.STATUS='PENDING';

   --DELETE FROM TEST_XML;
  INSERT INTO TEST_XML(CXML) VALUES (l_xml);
  COMMIT;
      p_error_code := 0;
      p_error_msg := NULL;

EXCEPTION
   WHEN OTHERS
   THEN

    p_error_code := -99;
      p_error_msg := 'Error occured while gathering Landlord sales data';
   TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG ('set_landlord_sales_data',
                                            -99,
                                            SQLERRM,
                                            NULL,
                                            tmcs_sec_ctx.get_user,
                                            SYSDATE,
                                            SYSDATE,
                                            tmcs_sec_ctx.get_client_id,
                                            'set_landlord_sales_data',
                                            NULL,
                                            NULL,
                                            dbms_utility.format_error_backtrace);
END   set_landlord_sales_data;


PROCEDURE set_standard_burst_table_child_data(p_error_code OUT  NUMBER,
                                              p_error_msg  OUT   VARCHAR2,
                                              p_hdr_id IN NUMBER,
                                              PARAMETER5 CLOB)

AS
   l_client_pkg                  VARCHAR2 (200);
   l_plsql                       VARCHAR2 (4000);
   l_param3    VARCHAR2 (4000);
   l_param6   VARCHAR2 (4000);
   l_param7   VARCHAR2 (4000);
   l_param5 CLOB;
   l_CURR_SEQ   NUMBER;
   l_client_code  VARCHAR2 (4000);
CURSOR c2 (
      p_client_pkg VARCHAR2)
   IS
      SELECT 1
        FROM DUAL
       WHERE EXISTS
                (SELECT 1
                   FROM all_procedures proc, all_objects allo
                  WHERE     allo.object_name = proc.object_name
                        AND proc.object_name = p_client_pkg
                        AND proc.procedure_name = 'SET_BURST_TABLE_CHILD_DATA'
                        AND allo.object_type LIKE 'PACKAGE%');


BEGIN



SELECT tmc.client_code
           INTO l_client_code
           FROM TMCS_CLIENTS TMC where client_id = tmcs_sec_ctx.get_client_id;

 BEGIN
 select PARAMETER3,PARAMETER6,PARAMETER7 INTO l_param3,l_param6,l_param7
       from tmcs_rpt_bursting_data_hdr where client_id=tmcs_sec_ctx.get_client_id and country_code= tmcs_sec_ctx.get_country_code;

   EXCEPTION
   WHEN NO_DATA_FOUND THEN
       NULL;
   END;

l_client_pkg :=
         'TMCS_REPORTS_'
      || tmcs_general_pkg.get_client_code (tmcs_sec_ctx.get_client_id)
      || '_AUTOMATION';

           DBMS_OUTPUT.put_line ('l_client_pkg: ' || l_client_pkg);

FOR c IN c2 (l_client_pkg)
   LOOP
      l_plsql :=
         'BEGIN ' || l_client_pkg || '.set_burst_table_child_data(:1,:2,:3,:4,:5,:6,:7);   END;';
      DBMS_OUTPUT.put_line (l_plsql);

      BEGIN
         EXECUTE IMMEDIATE l_plsql USING OUT p_error_code,
                                         OUT p_error_msg,
                                         p_hdr_id,
                                         l_param3,
                                         l_param6,
                                         l_param7,
                                         PARAMETER5;

          DBMS_OUTPUT.put_line ('COMPLETED');
            COMMIT;
--          UPDATE tmcs_bip_bursting_hdr hdr set status='RFB'
--                where hdr.CLIENT_ID=tmcs_sec_ctx.get_client_id
--                    and hdr.STATUS='PENDING';
-- DBMS_OUTPUT.PUT_LINE('Updated status to Ready for Bursting  ' || tmcs_sec_ctx.get_client_id);
         return;
      EXCEPTION
         WHEN OTHERS
         THEN
            TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG (
               'set_burst_table_child_data',
               -99,
               SQLERRM,
               'Something is wrong in client sales report package',
               tmcs_sec_ctx.get_user,
               SYSDATE,
               SYSDATE,
               tmcs_sec_ctx.get_client_id,
               'set_burst_table_child_data',
               tmcs_sec_ctx.get_client_id,
               NULL,
               NULL);
      END;
   END LOOP;

 DBMS_OUTPUT.put_line ('NOT COMPLETED');
   FOR lr IN (WITH run_lease_tab_old
     AS (SELECT *
           FROM (  SELECT ROW_NUMBER ()
                          OVER (
                             PARTITION BY a.lease_id
                             ORDER BY
                                a.lease_id,
                                DECODE (breakpoint_type,
                                        'NATURAL', 1,
                                        'ARTIFICIAL', 2,
                                        'NONE', 3))
                             test,
                           'MON' PCT_FREQUENCY,
                          a.*

                     FROM TMCS_LEASE_PCT_RENT a, tmcs_leases lease
                    WHERE     lease.lease_status = 'ACTIVE'
                          AND a.lease_id = lease.lease_id
                          AND a.pct_rent_status = 'ACTIVE'
                          AND  case when   to_char(last_day(sysdate),'DD')<SALES_REPORT_DUE_MONTHLY and trunc(last_day(sysdate))=trunc(sysdate) then 1
                                      when   SALES_REPORT_DUE_MONTHLY <=to_char(last_day(sysdate),'DD') and SALES_REPORT_DUE_MONTHLY =
                                             TO_CHAR (SYSDATE, 'DD') then 1 end = 1
                 ORDER BY a.lease_id,
                          DECODE (breakpoint_type,
                                  'NATURAL', 1,
                                  'ARTIFICIAL', 2,
                                  'NONE', 3))
          WHERE test = 1
          UNION

          SELECT *
           FROM (  SELECT ROW_NUMBER ()
                          OVER (
                             PARTITION BY a.lease_id
                             ORDER BY
                                a.lease_id,
                                DECODE (breakpoint_type,
                                        'NATURAL', 1,
                                        'ARTIFICIAL', 2,
                                        'NONE', 3))
                             test,
                          'QUA' PCT_FREQUENCY,
                          a.*
               FROM TMCS_LEASE_PCT_RENT a, tmcs_leases lease
                    WHERE     lease.lease_status = 'ACTIVE'
                          AND a.lease_id = lease.lease_id
                          AND a.pct_rent_status = 'ACTIVE'
                          AND   case  when   to_char(last_day(sysdate),'DD')<SALES_REPORT_DUE_QUARTERLY and trunc(last_day(sysdate))=trunc(sysdate) then 1
                                      when      SALES_REPORT_DUE_QUARTERLY <=to_char(last_day(sysdate),'DD') and  SALES_REPORT_DUE_QUARTERLY =
                                             TO_CHAR (SYSDATE, 'DD') then 1 end = 1
                 ORDER BY a.lease_id,
                          DECODE (breakpoint_type,
                                  'NATURAL', 1,
                                  'ARTIFICIAL', 2,
                                  'NONE', 3))
          WHERE test = 1

          UNION

          SELECT *
           FROM (  SELECT ROW_NUMBER ()
                          OVER (
                             PARTITION BY a.lease_id
                             ORDER BY
                                a.lease_id,
                                DECODE (breakpoint_type,
                                        'NATURAL', 1,
                                        'ARTIFICIAL', 2,
                                        'NONE', 3))
                             test,
                          'SEM' PCT_FREQUENCY,
                          a.*
                     FROM TMCS_LEASE_PCT_RENT a, tmcs_leases lease
                    WHERE     lease.lease_status = 'ACTIVE'
                          AND a.lease_id = lease.lease_id
                          AND a.pct_rent_status = 'ACTIVE'
                          AND   case  when   to_char(last_day(sysdate),'DD')<SALES_REPORT_DUE_SEMIANN and trunc(last_day(sysdate))=trunc(sysdate) then 1
                                      when      SALES_REPORT_DUE_SEMIANN <=to_char(last_day(sysdate),'DD') and  SALES_REPORT_DUE_SEMIANN =
                                             TO_CHAR (SYSDATE, 'DD') then 1 end = 1
                 ORDER BY a.lease_id,
                          DECODE (breakpoint_type,
                                  'NATURAL', 1,
                                  'ARTIFICIAL', 2,
                                  'NONE', 3))
          WHERE test = 1
          UNION

          SELECT *
           FROM (  SELECT ROW_NUMBER ()
                          OVER (
                             PARTITION BY a.lease_id
                             ORDER BY
                                a.lease_id,
                                DECODE (breakpoint_type,
                                        'NATURAL', 1,
                                        'ARTIFICIAL', 2,
                                        'NONE', 3))
                             test,
                          'ANN' PCT_FREQUENCY,
                          a.*
                     FROM TMCS_LEASE_PCT_RENT a, tmcs_leases lease
                    WHERE     lease.lease_status = 'ACTIVE'
                          AND a.lease_id = lease.lease_id
                          AND a.pct_rent_status = 'ACTIVE'
                          AND   case  when   to_char(last_day(sysdate),'DD')<SALES_REPORT_DUE_ANNUALLY and trunc(last_day(sysdate))=trunc(sysdate) then 1
                                      when      SALES_REPORT_DUE_ANNUALLY <=to_char(last_day(sysdate),'DD') and  SALES_REPORT_DUE_ANNUALLY =
                                             TO_CHAR (SYSDATE, 'DD') then 1 end = 1
                 ORDER BY a.lease_id,
                          DECODE (breakpoint_type,
                                  'NATURAL', 1,
                                  'ARTIFICIAL', 2,
                                  'NONE', 3))
          WHERE test = 1),
   fiscal_year_data_tab
     AS (
     SELECT lease_id,PCT_FREQUENCY,
                CASE
                   WHEN TO_NUMBER (TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MM')) >=
                           start_month
                   THEN
                      TO_NUMBER (TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'YYYY'))
                   WHEN TO_NUMBER (TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MM')) <
                           start_month
                   THEN
                        TO_NUMBER (
                           TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'YYYY'))
                      - 1
                END
                   fiscal_year,
                CASE
                   WHEN TO_NUMBER (TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MM')) >
                           start_month
                   THEN
                        (  TO_NUMBER (
                              TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MM'))
                         - start_month)
                      + 1
                   WHEN TO_NUMBER (TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MM')) <
                           start_month
                   THEN
                        ( (12 - start_month) + 1)
                      + TO_NUMBER (TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MM'))
                   WHEN TO_NUMBER (TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MM')) =
                           start_month
                   THEN
                      1
                END
                   month_number,
                TO_NUMBER (TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MM'))
                   calendar_month_num,
                TO_NUMBER (TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'YYYY'))
                   calendar_year
           FROM run_lease_tab_old),
 run_lease_tab as(
 select a.*, fiscal.month_number, CASE
                       WHEN a.PCT_FREQUENCY='QUA' AND  fiscal.month_number IN (3, 6, 9, 12)
                       THEN
                          'QUA'
                       WHEN a.PCT_FREQUENCY='SEM' AND fiscal.month_number IN (6, 12)
                       THEN
                          'SEM'
                       WHEN   a.PCT_FREQUENCY='ANN' AND  fiscal.month_number IN (12)
                       THEN
                          'ANN'
                       WHEN  a.PCT_FREQUENCY='MON' AND  fiscal.calendar_month_num IN
                                   (TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MM'))
                       THEN
                          'MON' END FREQUENCY

                          from run_lease_tab_old a, fiscal_year_data_tab fiscal
where a.lease_id=fiscal.lease_id and a.PCT_FREQUENCY = fiscal.PCT_FREQUENCY
)
  SELECT lease_id,
         role,
         first_name,
         last_name,
         lease_number,
         lease_name,
         FREQUENCY,
         LISTAGG (sales_report_to_email, ',') WITHIN GROUP (ORDER BY sales_report_to_email) email,
         store_number,
                 store_name,ADDRESS,ADDRESS2,ADDRESS3
    FROM (SELECT to_email_data.lease_id,
                 role,
                 to_email_data.supplier_site_name first_name,
                 NULL last_name,
                sales_report_to_email,
                 lease.lease_num LEASE_NUMBER,
                 lease.name LEASE_NAME,
                 to_email_data.FREQUENCY,
                 store_number,
                 store_name,
                 ADDRESS,ADDRESS2,ADDRESS3
            FROM (SELECT lease.lease_id,
                         NVL (supplier_contacts.role, tls.SUPPLIER_SITE_TYPE)
                            role,
                          nvl(site_contact.email,tss.email) sales_report_to_email,
                         tss.supplier_site_name,
                          lease.FREQUENCY,
                          store.store_number,
                          store.store_name,
                          store.ADDRESS,store.ADDRESS2,store.ADDRESS3
                    FROM TMCS_LEASE_SUPPLIER_CONTACTS supplier_contacts,
                         TMCS_LEASE_SUPPLIERS tls,
                         TMCS_SUPPLIER_SITES tss,
                         (SELECT lease.*,lease_tab.FREQUENCY
                            FROM tmcs_leases lease,
                                 run_lease_tab lease_tab
                           WHERE lease.lease_id = lease_tab.lease_id and FREQUENCY IS NOT NULL) lease,
                         TMCS_SUPPLIER_SITE_CONTACTS site_contact,
                         tmcs_lease_loc loc,
                         tmcs_all_stores store
                   WHERE     lease.lease_id = tls.lease_id
                         AND tls.lease_id = supplier_contacts.lease_id(+)
                         AND tls.supplier_site_id =
                                supplier_contacts.SUPPLIER_SITE_ID(+)
                         AND CASE WHEN supplier_contacts.role = 'SALESRPT' THEN 1
                                WHEN tls.SUPPLIER_SITE_TYPE = 'SALESRPT' THEN 1
                               END =1
                         AND tss.SUPPLIER_SITE_ID(+) = tls.Supplier_Site_Id
                         AND supplier_contacts.contact_id= site_contact.contact_id(+)
                        AND nvl(site_contact.email,tss.email) IS NOT NULL
                        AND  lease.lease_id = loc.lease_id
                        AND loc.location_id = store.store_id) to_email_data,
                 tmcs_leases lease
           WHERE to_email_data.lease_id = lease.lease_id)
GROUP BY lease_id,
         role,
         first_name,
         last_name,
         lease_number,
         lease_name,
         FREQUENCY,
         store_number,
         store_name,ADDRESS,ADDRESS2,ADDRESS3)
   LOOP
      INSERT INTO tmcs_bip_bursting_chd (HDR_ID,
                                            KEY ,
                                            ENTITY_ID,
                                            FREQUENCY,
                                            TEMPLATE,
                                            LOCALE,
                                            OUTPUT_FORMAT,
                                            DEL_CHANNEL,--6
                                            PARAMETER1 ,
                                            PARAMETER2 ,
                                            PARAMETER3,
                                            PARAMETER4,
                                            PARAMETER5,
                                            PARAMETER6 ,
                                            PARAMETER7,
                                            PARAMETER8,
                                            PARAMETER9 ,
                                            PARAMETER10 , --16
                                            OUTPUT_NAME ,
                                            CREATED_BY ,
                                            CREATION_DATE ,
                                            CLIENT_ID,
                                            BRAND_ID ,
                                            COUNTRY,
                                            BU_ID ,
                                            STATUS,
                                            LEASE_NUMBER,
                                            LEASE_NAME,
                                            STORE_NUMBER,
                                            STORE_NAME,
                                            STORE_ADDRESS,
                                            STORE_ADDRESS2,
                                            STORE_ADDRESS3,
                                            RECIPIENT_FNAME ,
                                            RECIPIENT_LNAME )
           VALUES (
                     p_hdr_id,
                     lr.lease_id||'_'||lr.FREQUENCY,
                     lr.lease_id,
                     lr.FREQUENCY,
                     'SALES_REPORTING_' || l_client_code,
                     'en-US',
                     'PDF',
                     'EMAIL', --6
                     lr.email, --p1
                     NULL, --p2
                     l_param3, --p3
                        'Sales Report for '
                     || DECODE (
                           lr.FREQUENCY,
                           'MON', TO_CHAR (ADD_MONTHS (SYSDATE, -1),
                                               'fmMonth YYYY'),
                           'ANN',  'Yearly (' || TO_CHAR (ADD_MONTHS (SYSDATE, -12),
                                                 'fmMonth YYYY')
                                     || ' to '
                                     || TO_CHAR (ADD_MONTHS (SYSDATE, -1),
                                                 'fmMonth YYYY')||')',
                           'SEM', 'Semi-annual ('||TO_CHAR (ADD_MONTHS (SYSDATE, -6),
                                                 'fmMonth YYYY')
                                     || ' to '
                                     || TO_CHAR (ADD_MONTHS (SYSDATE, -1),
                                                 'fmMonth YYYY')||')',
                           'QUA', 'Quarter ('||TO_CHAR (ADD_MONTHS (SYSDATE, -3),
                                                 'fmMonth YYYY')
                                     || ' to '
                                     || TO_CHAR (ADD_MONTHS (SYSDATE, -1),
                                                 'fmMonth YYYY')||')')
                     || ' Lease Id '
                     || lr.lease_number
                     || '('
                     || lr.lease_name
                     || ')', --p4
                      '<p>Attached are the '||case
                                when lr.FREQUENCY='MON' then 'monthly sales'
                                when lr.FREQUENCY='QUA' then 'quarterly sales'
                                when lr.FREQUENCY='ANN' then 'yearly sales'
                                when lr.FREQUENCY='SEM' then 'semiannual sales' end
                                ||' for the above referenced location.</p>
                                    <p>If you have any questions on the attached report, please contact your GNC Lease Administrator.</p>
                                    <p style=background: white;><strong><span style=color: red;>Important Information</span></strong></p>
                                    <p style=background: white;><span style=color: red;>Please do not reply to this message.  Replies to this message are routed to an unmonitored mailbox.  If you have questions, please contact your Lease Administrator.</span></p>
                                    <p>&nbsp;</p>',--p5
                     l_param6,--p6
                     l_param7, --p7
                     NULL,--p8
                     NULL,--p9
                     NULL,--p10
                     TRIM (
                           'Lease_'
                        || lr.lease_number
                        || TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'fmMonth YYYY')),
                     tmcs_sec_ctx.get_user,
                     SYSDATE,
                     tmcs_sec_ctx.get_client_id,
                     tmcs_sec_ctx.get_brand_id,
                     tmcs_sec_ctx.get_country_code,
                     tmcs_sec_ctx.get_bu_id,
                     'PENDING',
                     lr.LEASE_NUMBER,
                     lr.LEASE_NAME,
                     lr.STORE_NUMBER,
                     lr.STORE_NAME,
                     lr.ADDRESS,
                     lr.ADDRESS2,
                     lr.ADDRESS3,
                     lr.FIRST_NAME ,
                     lr.LAST_NAME);
 DBMS_OUTPUT.PUT_LINE('KEY: ' || lr.lease_id||'_'||lr.FREQUENCY);
 l_curr_seq :=tmcs_bip_bursting_chd_s.CURRVAL;
 l_param5 := TMCS_LANDLORD_SALE_AUTOMATION.GET_EMAIL_BODY_CONTENT(PARAMETER5,l_curr_seq,lr.FREQUENCY);

 UPDATE tmcs_bip_bursting_chd SET PARAMETER5 = l_param5 WHERE CHD_ID=l_curr_seq;

  DBMS_OUTPUT.PUT_LINE('l_param5: ' || l_param5);

   END LOOP;
   COMMIT;
EXCEPTION
WHEN OTHERS THEN
  p_error_code := -99;
      p_error_msg := 'Error occured while gathering bursting Child table data';
 TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG ('set_standard_burst_table_child_data',
                                            -99,
                                            SQLERRM,
                                            NULL,
                                            tmcs_sec_ctx.get_user,
                                            SYSDATE,
                                            SYSDATE,
                                            tmcs_sec_ctx.get_client_id,
                                            'set_standard_burst_table_child_data',
                                            NULL,
                                            NULL,
                                            dbms_utility.format_error_backtrace);

END set_standard_burst_table_child_data;

procedure set_standard_landlord_sales_data(p_error_code OUT  NUMBER,
   p_error_msg  OUT   VARCHAR2,p_query_str VARCHAR2)

AS
l_client_pkg VARCHAR2 (200);
l_plsql VARCHAR2 (200);
CURSOR c2 (
      p_client_pkg VARCHAR2)
   IS
      SELECT 1
        FROM DUAL
       WHERE EXISTS
                (SELECT 1
                   FROM all_procedures proc, all_objects allo
                  WHERE     allo.object_name = proc.object_name
                        AND proc.object_name = p_client_pkg
                        AND proc.procedure_name = 'SET_LANDLORD_SALES_DATA'
                        AND allo.object_type LIKE 'PACKAGE%');

begin

l_client_pkg :=
         'TMCS_REPORTS_'
      || tmcs_general_pkg.get_client_code (tmcs_sec_ctx.get_client_id)
      || '_AUTOMATION';

           DBMS_OUTPUT.put_line ('l_client_pkg: ' || l_client_pkg);

FOR c IN c2 (l_client_pkg)
   LOOP
      l_plsql :=
         'BEGIN ' || l_client_pkg || '.SET_LANDLORD_SALES_DATA(:1,:2);   END;';
      DBMS_OUTPUT.put_line (l_plsql);

      BEGIN
         EXECUTE IMMEDIATE l_plsql USING OUT p_error_code,
                                         OUT p_error_msg ;

          DBMS_OUTPUT.put_line ('COMPLETED');
            COMMIT;
--          UPDATE tmcs_bip_bursting_hdr hdr set status='RFB'
--                where hdr.CLIENT_ID=tmcs_sec_ctx.get_client_id
--                    and hdr.STATUS='PENDING';
-- DBMS_OUTPUT.PUT_LINE('Updated status to Ready for Bursting  ' || tmcs_sec_ctx.get_client_id);
         return;
      EXCEPTION
         WHEN OTHERS
         THEN
            TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG (
               'set_burst_table_child_data',
               -99,
               SQLERRM,
               'Something is wrong in client sales report package',
               tmcs_sec_ctx.get_user,
               SYSDATE,
               SYSDATE,
               tmcs_sec_ctx.get_client_id,
               'set_burst_table_child_data',
               tmcs_sec_ctx.get_client_id,
               NULL,
               NULL);
      END;
   END LOOP;

set_landlord_sales_data(p_error_code ,p_error_msg,p_query_str ) ;

COMMIT;

EXCEPTION
WHEN OTHERS THEN
  p_error_code := -99;
      p_error_msg := 'Error occured while gathering bursting Child table data';
 TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG ('set_standard_landlord_sales_data',
                                            -99,
                                            SQLERRM,
                                            NULL,
                                            tmcs_sec_ctx.get_user,
                                            SYSDATE,
                                            SYSDATE,
                                            tmcs_sec_ctx.get_client_id,
                                            'set_standard_landlord_sales_data',
                                            NULL,
                                            NULL,
                                            dbms_utility.format_error_backtrace);
end set_standard_landlord_sales_data;



PROCEDURE set_burst_table_child_data(p_error_code OUT  NUMBER,
   p_error_msg  OUT   VARCHAR2,p_client_id IN NUMBER)

IS
p_hdr_id NUMBER;
l_refcursor    SYS_REFCURSOR;
l_xmltype      XMLTYPE;
   l_xml          CLOB := EMPTY_CLOB ();
   l_xml_data  CLOB := EMPTY_CLOB ();
   l_client_pkg                  VARCHAR2 (200);
   l_plsql                       VARCHAR2 (4000);

 CURSOR C1 IS
   select * from tmcs_rpt_bursting_data_hdr
            where client_id =p_client_id
                  and  SELECTED='Y'  order by COUNTRY_CODE desc;

BEGIN


 FOR rec_c2 IN C1 LOOP
 DBMS_OUTPUT.PUT_LINE('Client ID: ');
  DBMS_OUTPUT.PUT_LINE(rec_c2.CLIENT_ID);

  BEGIN
  SELECT HDR_ID INTO p_hdr_id FROM ( SELECT hdr.*,RANK() OVER (PARTITION BY hdr.CLIENT_ID
                       ORDER BY CREATION_DATE DESC) Rank  from  tmcs_bip_bursting_hdr hdr where hdr.CLIENT_ID = rec_c2.CLIENT_ID
                    and hdr.STATUS='PENDING' ) WHERE RANK = 1 ;
   EXCEPTION
   WHEN NO_DATA_FOUND THEN
        p_error_code := -99;
        p_error_msg := 'No BI Bursting Header entry found';
        RETURN;
   END;

 tmcs_Sec_ctx.set_context('reportuser',rec_c2.COUNTRY_CODE,rec_c2.CLIENT_ID);
 DBMS_OUTPUT.PUT_LINE('COUNTRY CODE: ' || tmcs_sec_ctx.get_COUNTRY_CODE);
  DBMS_OUTPUT.PUT_LINE('USER: ' || tmcs_sec_ctx.get_user);
   DBMS_OUTPUT.PUT_LINE('Client ID: ' || tmcs_sec_ctx.get_client_id);



    set_standard_burst_table_child_data(p_error_code ,
                                              p_error_msg  ,
                                              p_hdr_id,
                                              rec_c2.PARAMETER5);

     DBMS_OUTPUT.PUT_LINE('Inside burst Sales proc call');
  set_standard_landlord_sales_data(p_error_code ,p_error_msg,rec_c2.PARAMETER10) ;
END LOOP;

 UPDATE tmcs_bip_bursting_hdr hdr set status='RFB'
                where hdr.CLIENT_ID=tmcs_sec_ctx.get_client_id
                    and hdr.STATUS='PENDING';
 DBMS_OUTPUT.PUT_LINE('Updated status to Ready for Bursting  ' || tmcs_sec_ctx.get_client_id);



EXCEPTION
WHEN OTHERS THEN
  p_error_code := -99;
      p_error_msg := 'Error occured while gathering bursting Child table data';
 TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG ('set_burst_table_child_data',
                                            -99,
                                            SQLERRM,
                                            NULL,
                                            tmcs_sec_ctx.get_user,
                                            SYSDATE,
                                            SYSDATE,
                                            tmcs_sec_ctx.get_client_id,
                                            'set_burst_table_child_data',
                                            NULL,
                                            NULL,
                                            dbms_utility.format_error_backtrace);
END set_burst_table_child_data;

PROCEDURE get_landlord_sales_data (

   p_error_code OUT  NUMBER,
   p_error_msg  OUT   VARCHAR2,
   p_client_id IN NUMBER)
IS
p_sequence NUMBER;
p_hdr_id NUMBER;
 p_user         VARCHAR2(200);
   p_country      VARCHAR2(200);
   p_bu_id        NUMBER;
   p_brand_id     NUMBER;



BEGIN
   -- Set Context for Sales Report Data

   --TMCS_SEC_CTX.SET_CONTEXT (p_user, p_country, p_client_id,p_brand_id,p_bu_id); -- User, Country, Client Id
  DBMS_OUTPUT.PUT_LINE ('HEADER: ');

INSERT INTO tmcs_bip_bursting_hdr (CREATED_BY,
                                            CREATION_DATE ,
                                            CLIENT_ID,
                                            BRAND_ID ,
                                            COUNTRY,
                                            BU_ID ,
                                            STATUS ,
                                            XML_DATA,
                                            ERR_CODE,
                                            ERR_MSG,
                                            BURSTING_FUNCTIONALITY)
                             VALUES (NULL,
                                     SYSDATE,
                                     p_client_id,
                                     NULL,
                                     NULL,
                                     NULL,
                                     'PENDING',
                                     NULL,
                                     NULL,
                                     NULL,
                                     'Sales Reporting') ;

 DBMS_OUTPUT.PUT_LINE('INSERTED');
-- Populate the Burst Table with Email Ids for the Report recepients
        set_burst_table_child_data(p_error_code,p_error_msg,p_client_id  );

   COMMIT;




p_error_code := 0;
      p_error_msg := null;

EXCEPTION
   WHEN OTHERS
   THEN
    p_error_code := -99;
      p_error_msg := 'Error occured while gathering bursting Header table data';

   TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG ('set_bursting_table_data',
                                            -99,
                                            SQLERRM,
                                            NULL,
                                            tmcs_sec_ctx.get_user,
                                            SYSDATE,
                                            SYSDATE,
                                            tmcs_sec_ctx.get_client_id,
                                            'set_bursting_table_data',
                                            NULL,
                                            NULL,
                                            dbms_utility.format_error_backtrace);



END get_landlord_sales_data;

PROCEDURE get_bursting_reports_data (p_error_code OUT  NUMBER,
   p_error_msg  OUT   VARCHAR2)
 AS
 l_client_id NUMBER;

  CURSOR C1 IS
   select CLIENT_ID,FUNCTIONALITY from tmcs_rpt_bursting_data_hdr
            where  SELECTED='Y'
   GROUP BY CLIENT_ID,FUNCTIONALITY order by CLIENT_ID;

 BEGIN



  FOR rec_c1 IN C1 LOOP
  l_client_id := rec_c1.client_id;
  IF(rec_c1.FUNCTIONALITY='SALES_REPORTING') THEN
  set_busrting_header_status(l_client_id);
  get_landlord_sales_data(p_error_code,p_error_msg,l_client_id);
  END IF;

  END LOOP;


 EXCEPTION
   WHEN OTHERS
   THEN
    p_error_code := -99;
      p_error_msg := 'Error occured while gathering bursting Header table data';

   TMCS_DUKB_SERVICE_LOG_PKG.INSERT_LOG ('get_bursting_reports_data',
                                            -99,
                                            SQLERRM,
                                            NULL,
                                            tmcs_sec_ctx.get_user,
                                            SYSDATE,
                                            SYSDATE,
                                            tmcs_sec_ctx.get_client_id,
                                            'get_bursting_reports_data',
                                            NULL,
                                            NULL,
                                            dbms_utility.format_error_backtrace);

 END   get_bursting_reports_data;

FUNCTION GET_EMAIL_BODY_CONTENT(p_mail_content CLOB,p_chd_id NUMBER,p_frequency varchar2) return clob as
   l_text1       VARCHAR2 (2000);
   l_replace1   VARCHAR2 (2000);
   l_output     VARCHAR2 (2000);
BEGIN


IF p_mail_content IS NOT NULL THEN
   l_text1:=p_mail_content||' where chd_id='||p_chd_id;

ELSE
l_text1 := 'select ''<p>Attached are the ''||case
                                when p_frequency=''MON'' then ''monthly sales''
                                when p_frequency=''QUA'' then ''quarterly sales''
                                when p_frequency=''ANN'' then ''yearly sales''
                                when p_frequency=''SEM'' then ''semiannual sales'' end
                                ||'' for the above referenced location.</p>'' from dual';
  END IF;


   DBMS_OUTPUT.put_line ('l_text1 :'||l_text1);
    EXECUTE IMMEDIATE l_text1 INTO l_output;
    DBMS_OUTPUT.put_line ('l_output :'||l_output);
   return l_output;
  EXCEPTION
  WHEN OTHERS THEN
        NULL;
  END GET_EMAIL_BODY_CONTENT;



END TMCS_LANDLORD_SALE_AUTOMATION;
/

