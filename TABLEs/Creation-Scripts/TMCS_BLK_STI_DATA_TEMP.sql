CREATE TABLE TMCS_BLK_STI_DATA_TEMP
   (	GEO_ID VARCHAR2(15),
	GEOMETRY SDO_GEOMETRY_CHAR
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO_CHAR STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES_CHAR STORE AS SECUREFILE LOB ;

