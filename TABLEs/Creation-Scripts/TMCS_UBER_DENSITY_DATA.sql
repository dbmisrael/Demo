CREATE TABLE TMCS_UBER_DENSITY_DATA
   (	BG_ID VARCHAR2(19),
	HRS_00 NUMBER(18,6),
	HRS_01 NUMBER(18,6),
	HRS_02 NUMBER(18,6),
	HRS_03 NUMBER(18,6),
	HRS_04 NUMBER(18,6),
	HRS_05 NUMBER(18,6),
	HRS_06 NUMBER(18,6),
	HRS_07 NUMBER(18,6),
	HRS_08 NUMBER(18,6),
	HRS_09 NUMBER(18,6),
	HRS_10 NUMBER(18,6),
	HRS_11 NUMBER(18,6),
	HRS_12 NUMBER(18,6),
	HRS_13 NUMBER(18,6),
	HRS_14 NUMBER(18,6),
	HRS_15 NUMBER(18,6),
	HRS_16 NUMBER(18,6),
	HRS_17 NUMBER(18,6),
	HRS_18 NUMBER(18,6),
	HRS_19 NUMBER(18,6),
	HRS_20 NUMBER(18,6),
	HRS_21 NUMBER(18,6),
	HRS_22 NUMBER(18,6),
	HRS_23 NUMBER(18,6),
	GEOMETRY MDSYS.SDO_GEOMETRY
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
CREATE INDEX TMCS_UBER_DENSITY_DATA_PK ON TMCS_UBER_DENSITY_DATA (BG_ID)
  ;

