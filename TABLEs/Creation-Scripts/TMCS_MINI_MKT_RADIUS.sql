CREATE TABLE TMCS_MINI_MKT_RADIUS
   (	ID NUMBER,
	MM_ID VARCHAR2(6),
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	P_RADIUS NUMBER,
	P_UNITS VARCHAR2(150),
	P_MESSAGE VARCHAR2(150)
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;

