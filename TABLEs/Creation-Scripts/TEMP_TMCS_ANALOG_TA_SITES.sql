CREATE TABLE TEMP_TMCS_ANALOG_TA_SITES
   (	SITE_ID NUMBER,
	BRAND VARCHAR2(5),
	RADIUS NUMBER,
	GEOMETRY MDSYS.SDO_GEOMETRY
   )
  COLUMN GEOMETRY NOT SUBSTITUTABLE AT ALL LEVELS ;
CREATE INDEX TEMP_TMCS_ANALOG_TA_SITES_GIDX ON TEMP_TMCS_ANALOG_TA_SITES (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');
