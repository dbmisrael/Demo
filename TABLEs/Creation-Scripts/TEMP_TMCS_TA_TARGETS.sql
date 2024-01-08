CREATE TABLE TEMP_TMCS_TA_TARGETS
   (	TARGET_ID NUMBER(22,0),
	BRAND VARCHAR2(5),
	GEOMETRY MDSYS.SDO_GEOMETRY
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX TEMP_TMCS_TA_TARGETS_GIDX ON TEMP_TMCS_TA_TARGETS (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');

