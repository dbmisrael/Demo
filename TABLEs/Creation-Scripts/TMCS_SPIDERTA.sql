CREATE TABLE TMCS_SPIDERTA
   (	STORE_ID VARCHAR2(11),
	GRID_SAL_1 NUMBER,
	TYPE1 VARCHAR2(5),
	LATITUDE NUMBER,
	LONGITUDE NUMBER,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	GEOMETRY MDSYS.SDO_GEOMETRY
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
  CREATE UNIQUE INDEX TMCS_SPIDERTA_PK ON TMCS_SPIDERTA (STORE_ID)
  ;
ALTER TABLE TMCS_SPIDERTA ADD CONSTRAINT TMCS_SPIDERTA_PK PRIMARY KEY (STORE_ID)
  USING INDEX TMCS_SPIDERTA_PK  ENABLE;
CREATE INDEX TMCS_SPIDERTA_GIDX ON TMCS_SPIDERTA (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');
CREATE UNIQUE INDEX TMCS_SPIDERTA_PK ON TMCS_SPIDERTA (STORE_ID)
  ;

