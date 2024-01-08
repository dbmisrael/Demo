CREATE TABLE TMCS_CTY_STI_DATA
   (	GEO_ID VARCHAR2(5) NOT NULL ENABLE,
	COUNTY_NAME VARCHAR2(64),
	GEOMETRY MDSYS.SDO_GEOMETRY
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;

