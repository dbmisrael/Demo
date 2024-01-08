CREATE TABLE TMCS_TA_DISAGG_SF
   (	GUID VARCHAR2(320),
	ENTITY_ID NUMBER,
	CLIENT_ID NUMBER,
	GEO_ID VARCHAR2(320),
	GEO_CENTROID MDSYS.SDO_GEOMETRY ,
	SUBJ_CENTROID MDSYS.SDO_GEOMETRY ,
	CBSA_CLASS NUMBER,
	STORE_CLASS NUMBER,
	SL_DISTANCE NUMBER,
	DRIVE_DISTANCE NUMBER,
	DRIVE_MINUTES NUMBER,
	REGION VARCHAR2(320),
	CENSUS_DIVISION VARCHAR2(320),
	LONGITUDE NUMBER,
	LATITUDE NUMBER,
	STATE VARCHAR2(10),
	DMA NUMBER,
	HHCY NUMBER,
	POPCY NUMBER,
	EFF_HH NUMBER,
	PRED1 NUMBER,
	SIS_STORE_NUMBER VARCHAR2(100),
	SIS_CENTROID MDSYS.SDO_GEOMETRY ,
	DIST_SUBJ_SIS NUMBER,
	DIST_SIS_GEOID NUMBER,
	DIST_GEOID_SUB NUMBER,
	DIST_CENTROIDNUM NUMBER,
	DIST_CENTROIDDEN NUMBER,
	RATIO NUMBER,
	IMPACT NUMBER,
	ID_DUMMY NUMBER,
	CA_DUMMY NUMBER,
	IN_DUMMY NUMBER,
	NM_DUMMY NUMBER,
	STORECALASS_2_3_DUMMY NUMBER,
	MONTHS_OPEN NUMBER,
	SISTRANRAT NUMBER,
	PRED2 NUMBER,
	SQFT NUMBER,
	BDI NUMBER,
	OPS_SCORE NUMBER,
	BDI_RATIO NUMBER,
	EFFHH_ATTR1 NUMBER,
	PRED1_ATTR1 NUMBER,
	EFFHH_ATTR2 NUMBER,
	PRED1_ATTR2 NUMBER,
	EFFHH_ATTR3 NUMBER,
	PRED1_ATTR3 NUMBER,
	EFFHH_ATTR4 NUMBER,
	PRED1_ATTR4 NUMBER,
	EFFHH_ATTR5 NUMBER,
	PRED1_ATTR5 NUMBER,
	EFFHH_ATTR6 NUMBER,
	PRED1_ATTR6 NUMBER,
	EFFHH_ATTR7 NUMBER,
	PRED1_ATTR7 NUMBER,
	EFFHH_ATTR8 NUMBER,
	PRED1_ATTR8 NUMBER,
	PRED1_ATTR9 NUMBER,
	EFFHH_ATTR9 NUMBER,
	EFFHH_ATTR10 NUMBER,
	PRED1_ATTR10 NUMBER,
	EFFHH_ATTR11 NUMBER,
	PRED1_ATTR11 NUMBER,
	PRED2_ATTR11 NUMBER,
	PRED2_ATTR1 NUMBER,
	PRED2_ATTR2 NUMBER,
	PRED2_ATTR3 NUMBER,
	PRED2_ATTR4 NUMBER,
	PRED2_ATTR5 NUMBER,
	PRED2_ATTR6 NUMBER,
	PRED2_ATTR7 NUMBER,
	PRED2_ATTR8 NUMBER,
	PRED2_ATTR9 NUMBER,
	PRED2_ATTR10 NUMBER,
	PRED3_ATTR10 NUMBER,
	PRED3_ATTR6 NUMBER,
	PRED3_ATTR5 NUMBER,
	PRED3_ATTR9 NUMBER,
	PRED3 NUMBER,
	PRED4_ATTR1 NUMBER,
	PRED4_ATTR2 NUMBER,
	PRED4_ATTR3 NUMBER,
	PRED4_ATTR4 NUMBER,
	PRED4_ATTR5 NUMBER,
	PRED4_ATTR6 NUMBER,
	PRED4_ATTR7 NUMBER,
	PRED4_ATTR8 NUMBER,
	PRED4_ATTR9 NUMBER,
	PRED4_ATTR10 NUMBER,
	PRED4_ATTR11 NUMBER,
	PRED4 NUMBER,
	PRED5_ATTR1 NUMBER,
	PRED5_ATTR2 NUMBER,
	PRED5_ATTR3 NUMBER,
	PRED5_ATTR4 NUMBER,
	PRED5_ATTR5 NUMBER,
	PRED5_ATTR6 NUMBER,
	PRED5_ATTR7 NUMBER,
	PRED5_ATTR8 NUMBER,
	PRED5_ATTR9 NUMBER,
	PRED5_ATTR10 NUMBER,
	PRED5_ATTR11 NUMBER,
	PRED5 NUMBER,
	N_EXT_ATTR1 NUMBER,
	SCENARIO_ID NUMBER,
	C_EXT_ATTR1 VARCHAR2(320),
	C_EXT_ATTR2 VARCHAR2(320),
	C_EXT_ATTR3 VARCHAR2(320),
	C_EXT_ATTR4 VARCHAR2(320),
	C_EXT_ATTR5 VARCHAR2(320),
	STATUS VARCHAR2(320),
	SELECT_FLAG VARCHAR2(320),
	 CONSTRAINT TMCS_TA_DISAGG_SF_PK PRIMARY KEY (GUID, SCENARIO_ID, ENTITY_ID, CLIENT_ID, GEO_ID, SIS_STORE_NUMBER)
  USING INDEX  ENABLE
   )
 VARRAY GEO_CENTROID.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEO_CENTROID.SDO_ORDINATES STORE AS SECUREFILE LOB
 VARRAY SUBJ_CENTROID.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY SUBJ_CENTROID.SDO_ORDINATES STORE AS SECUREFILE LOB
 VARRAY SIS_CENTROID.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY SIS_CENTROID.SDO_ORDINATES STORE AS SECUREFILE LOB ;
