CREATE TABLE TEMP_TMCS_TA_PROSPECTS
   (	PROSPECT_ID NUMBER(22,0),
	BRAND VARCHAR2(5),
	GEOMETRY MDSYS.SDO_GEOMETRY
   )
  COLUMN GEOMETRY NOT SUBSTITUTABLE AT ALL LEVELS ;
CREATE INDEX TEMP_TMCS_TA_PROSPECTS_GIDX ON TEMP_TMCS_TA_PROSPECTS (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');

