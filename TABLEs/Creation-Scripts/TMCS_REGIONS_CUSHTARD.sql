CREATE TABLE TMCS_REGIONS_CUSHTARD
   (	REGION_ID NUMBER(19,0),
	REGION_NUMBER VARCHAR2(256) NOT NULL ENABLE,
	REGION_NAME VARCHAR2(256),
	COUNTRY VARCHAR2(50),
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	C_EXT_ATTR1 VARCHAR2(250),
	C_EXT_ATTR2 VARCHAR2(250),
	C_EXT_ATTR3 VARCHAR2(250),
	C_EXT_ATTR4 VARCHAR2(250),
	C_EXT_ATTR5 VARCHAR2(250),
	N_EXT_ATTR1 NUMBER,
	N_EXT_ATTR2 NUMBER,
	N_EXT_ATTR3 NUMBER,
	N_EXT_ATTR4 NUMBER,
	N_EXT_ATTR5 NUMBER,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	CREATION_DATE DATE,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE DATE,
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0)
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;

