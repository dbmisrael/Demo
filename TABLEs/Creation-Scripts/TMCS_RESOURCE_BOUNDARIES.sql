CREATE TABLE TMCS_RESOURCE_BOUNDARIES
   (	RESOURCE_BOUNDRY_ID NUMBER,
	ENTITY_TYPE VARCHAR2(50),
	ENTITY_ID VARCHAR2(100),
	COUNTRY VARCHAR2(100),
	GEOMETRY SDO_GEOMETRY,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	N_EXT_ATTR1 NUMBER,
	C_EXT_ATTR1 VARCHAR2(500),
	C_EXT_ATTR2 VARCHAR2(500),
	 PRIMARY KEY (RESOURCE_BOUNDRY_ID)
  USING INDEX  ENABLE
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX TMCS_RESOURCE_BOUNDARIES_GIDX ON TMCS_RESOURCE_BOUNDARIES (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');
CREATE INDEX TMCS_RESOURCE_BOUNDARIES_IDX01 ON TMCS_RESOURCE_BOUNDARIES (CLIENT_ID, RESOURCE_BOUNDRY_ID, ORG_ID)
  ;
