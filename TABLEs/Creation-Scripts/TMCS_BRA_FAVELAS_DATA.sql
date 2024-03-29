CREATE TABLE TMCS_BRA_FAVELAS_DATA
   (	RECORDID VARCHAR2(450),
	NAME VARCHAR2(450),
	GEOMETRY MDSYS.SDO_GEOMETRY
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX TMCS_BRA_FAVELAS_DATA_GIDX ON TMCS_BRA_FAVELAS_DATA (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');

