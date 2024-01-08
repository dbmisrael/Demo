CREATE TABLE TMCS_BRA_MUNICIPALITIES_DATA
   (	MUNICIPALITY_ID NUMBER(10,0),
	MUNICIPALITY_NAME VARCHAR2(4000),
	MICROREGION_ID NUMBER(10,0),
	MICROREGION_NAME VARCHAR2(4000),
	MESOREGION_ID NUMBER(10,0),
	MESOREGION_NAME VARCHAR2(4000),
	STATE_ID NUMBER(10,0),
	STATE_ABBR VARCHAR2(255),
	STATE_NAME VARCHAR2(255),
	REGION VARCHAR2(4000),
	GEOMETRY MDSYS.SDO_GEOMETRY
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX TMCS_BRA_MUNCI_DATA_GIDX ON TMCS_BRA_MUNICIPALITIES_DATA (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');

