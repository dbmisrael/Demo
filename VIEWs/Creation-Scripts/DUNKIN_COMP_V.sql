CREATE OR REPLACE FORCE EDITIONABLE VIEW DUNKIN_COMP_V (ANALOG_ID, ATTRIBUTE_NAME, ATTRIBUTE_VALUE, COMMENTS, CREATED_BY, CREATION_DATE, DISPLAY_ORDER, ENTITY_TYPE, LAST_UPDATE_DATE, LAST_UPDATE_LOGIN, LAST_UPDATED_BY, OBJECT_VERSION_NUMBER, ID, SECTION_NAME, STORE_ID, STORE_NUMBER, SUB_SECTION, VIEW_COMMENTS, AVERAGE) AS
  SELECT TmcsAnalogResultsPivotEO.ANALOG_ID,
            TmcsAnalogResultsPivotEO.ATTRIBUTE_NAME,
            TmcsAnalogResultsPivotEO.ATTRIBUTE_VALUE,
            TmcsAnalogResultsPivotEO.COMMENTS,
            TmcsAnalogResultsPivotEO.CREATED_BY,
            TmcsAnalogResultsPivotEO.CREATION_DATE,
            TmcsAnalogResultsPivotEO.DISPLAY_ORDER,
            TmcsAnalogResultsPivotEO.ENTITY_TYPE,
            TmcsAnalogResultsPivotEO.LAST_UPDATE_DATE,
            TmcsAnalogResultsPivotEO.LAST_UPDATE_LOGIN,
            TmcsAnalogResultsPivotEO.LAST_UPDATED_BY,
            TmcsAnalogResultsPivotEO.OBJECT_VERSION_NUMBER,
            TmcsAnalogResultsPivotEO.ROWID ID,
            TmcsAnalogResultsPivotEO.SECTION_NAME,
            TmcsAnalogResultsPivotEO.STORE_ID,
            TmcsAnalogResultsPivotEO.STORE_NUMBER,
            TmcsAnalogResultsPivotEO.SUB_SECTION,
            (SELECT NVL (
                       DECODE (section_name,
                               'Trade Area Characteristics', TARC.TA_COMMENTS,
                               'Main', TARC.MAIN_COMMENTS,
                               'Site Characteristics', TARC.SC_COMMENTS,
                               'Sales', TARC.SALES_COMMENTS,
                               'Competition', TARC.COMP_COMMENTS,
                               TARC.MISC_COMMENTS),
                       '')
               FROM TMCS_ANALOG_RESULTS_COMMENTS TARC
              WHERE TARC.ANALOG_ID = TmcsAnalogResultsPivotEO.analog_id)
               AS VIEW_COMMENTS,
            1 AS Average
       FROM TMCS_ANALOG_RESULTS_PIVOT TmcsAnalogResultsPivotEO
   ORDER BY STORE_ID, DISPLAY_ORDER;

