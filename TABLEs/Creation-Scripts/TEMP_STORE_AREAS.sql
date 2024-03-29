CREATE TABLE TEMP_STORE_AREAS
   (	STORE_ID NUMBER(*,0),
	STORE_NUMBER NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	GEOMETRY SDO_GEOMETRY
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX EMP_STORE_AREAS_GIDX ON TEMP_STORE_AREAS (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');

