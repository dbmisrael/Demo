CREATE OR REPLACE FORCE EDITIONABLE VIEW DUNKIN_ANALOG_V (ANALOG_ID, STORE_ID, SECTION_NAME_1, SECTION_NAME, ENTITY_TYPE_1, ENTITY_TYPE, DISPLAY_ORDER, SUB_SECTION, ATTRIBUTE_NAME, ATTRIBUTE_VALUE, STORE_NUMBER, COMMENTS, SUB_SECTION1) AS
  SELECT analog_id,
            store_id,
            DECODE (
               section_name,
               'Main', '1.Main',
               'Site Characteristics', '2.Site Characteristics',
               'Trade Area Characteristics', '3.Trade Area Characteristics',
               'Competition', '4.Competition',
               'Sales', '5.Sales')
               section_name_1,
            section_name,

            DECODE (entity_type,
                    'SITE', '1.SITE',
                    'STORE', '2.STORE',
                    'Average', '3.Average')
               entity_type_1,
            entity_type,
            TO_CHAR (
               DECODE (LENGTH (display_order),
                       1, display_order,
                       '9' || display_order))
               display_order,
            DECODE (sub_section,
                    '', DECODE (section_name, 'Sales', '1'),
                    'Sales by Daypart', '2.Sales by Daypart',
                    'Sales by Menu Category', '3.Sales by Menu Category',
                    'Calculate', '4.Calculate')
               sub_section,
            attribute_name,
            attribute_value,
            store_number,
            (SELECT NVL (
                       DECODE (section_name,
                               'Trade Area Characteristics', TARC.TA_COMMENTS,
                               'Main', TARC.MAIN_COMMENTS,
                               'Site Characteristics', TARC.SC_COMMENTS,
                               'Sales', TARC.SALES_COMMENTS,
                               'Competition', TARC.COMP_COMMENTS,
                               TARC.MISC_COMMENTS),
                       '')
               FROM tmcs.TMCS_ANALOG_RESULTS_COMMENTS TARC
              WHERE TARC.ANALOG_ID = TmcsAnalogResultsPivotEO.analog_id)
               AS COMMENTS,
            sub_section sub_section1
       FROM TMCS_ANALOG_RESULTS_PIVOT TmcsAnalogResultsPivotEO
   ORDER BY TO_NUMBER (TO_CHAR (display_order)),
            DECODE (entity_type,
                    'SITE', '1',
                    'STORE', '2',
                    'Average', '3');

