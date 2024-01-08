CREATE TABLE TMCS_SITE_SF_SNR_BKP
   (	GEOMETRY MDSYS.SDO_GEOMETRY ,
	TA_GEOMETRY MDSYS.SDO_GEOMETRY ,
	SALES_FORECAST NUMBER,
	N_EXT_ATTR1 NUMBER,
	N_EXT_ATTR2 NUMBER,
	N_EXT_ATTR7 NUMBER,
	N_EXT_ATTR9 NUMBER,
	N_EXT_ATTR10 NUMBER,
	N_EXT_ATTR11 NUMBER,
	N_EXT_ATTR12 NUMBER,
	N_EXT_ATTR13 NUMBER,
	SITE_ID NUMBER(*,0),
	SF_ID NUMBER(*,0),
	N_EXT_ATTR8 NUMBER(*,0)
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB
 VARRAY TA_GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY TA_GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
