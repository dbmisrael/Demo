CREATE TABLE TMCS_STORE_CUSTOMERS
   (	CUSTOMER_ID VARCHAR2(11),
	STORE_NUMBER NUMBER(19,0),
	GEO_ID VARCHAR2(15),
	PRIZM_CLUSTER VARCHAR2(3),
	TOT_SALES NUMBER(17,2),
	GEOMETRY MDSYS.SDO_GEOMETRY ,
	NO_OF_TRANS NUMBER(5,0),
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX TMCS_STORE_CUSTOMERS_GIDX ON TMCS_STORE_CUSTOMERS (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');

