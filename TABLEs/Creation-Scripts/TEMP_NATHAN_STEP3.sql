CREATE TABLE TEMP_NATHAN_STEP3
   (	STORE_ID NUMBER(*,0),
	STORE_NUMBER NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	GEOMETRY SDO_GEOMETRY
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;

