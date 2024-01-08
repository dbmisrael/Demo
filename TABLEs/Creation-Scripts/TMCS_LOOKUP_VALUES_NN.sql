CREATE TABLE TMCS_LOOKUP_VALUES_NN
   (	LOOKUP_ID NUMBER(*,0) NOT NULL ENABLE,
	LOOKUP_CODE VARCHAR2(300) NOT NULL ENABLE,
	LANGUAGE_CODE VARCHAR2(300) NOT NULL ENABLE,
	SEQUENCE NUMBER,
	ENABLED_FLAG VARCHAR2(1) NOT NULL ENABLE,
	START_DATE_ACTIVE DATE NOT NULL ENABLE,
	EXTATTRIBUTE_CATEGORY VARCHAR2(30),
	EXTATTRIBUTE1 VARCHAR2(4000),
	EXTATTRIBUTE2 VARCHAR2(4000),
	EXTATTRIBUTE3 VARCHAR2(4000),
	EXTATTRIBUTE4 VARCHAR2(4000),
	EXTATTRIBUTE5 VARCHAR2(4000),
	EXTATTRIBUTE6 VARCHAR2(4000),
	EXTATTRIBUTE7 VARCHAR2(4000),
	EXTATTRIBUTE8 VARCHAR2(4000),
	EXTATTRIBUTE9 VARCHAR2(4000),
	EXTATTRIBUTE10 VARCHAR2(4000),
	EXTATTRIBUTE11 VARCHAR2(4000),
	EXTATTRIBUTE12 VARCHAR2(4000),
	EXTATTRIBUTE13 VARCHAR2(4000),
	EXTATTRIBUTE14 VARCHAR2(4000),
	EXTATTRIBUTE15 VARCHAR2(4000),
	TAG VARCHAR2(150),
	LOOKUP_VALUE_ID NUMBER(*,0) DEFAULT TMCS_LOOKUP_VALUES_ID.nextval NOT NULL ENABLE,
	END_DATE_ACTIVE DATE,
	CLIENT_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0) DEFAULT 1,
	FORMULAE VARCHAR2(4000),
	REPORT_SEQUENCE NUMBER,
	BRAND_ID NUMBER,
	EXTATTRIBUTE16 VARCHAR2(4000),
	EXTATTRIBUTE17 VARCHAR2(4000),
	COLUMN_NAME VARCHAR2(150),
	TABLE_NAME VARCHAR2(150),
	EXTATTRIBUTE18 VARCHAR2(4000),
	EXTATTRIBUTE19 VARCHAR2(4000),
	EXTATTRIBUTE20 VARCHAR2(4000),
	EXTATTRIBUTE21 VARCHAR2(4000),
	EXTATTRIBUTE22 VARCHAR2(4000),
	EXTATTRIBUTE23 VARCHAR2(4000),
	EXTATTRIBUTE24 VARCHAR2(4000),
	EXTATTRIBUTE25 VARCHAR2(4000),
	EXTATTRIBUTE26 VARCHAR2(4000),
	EXTATTRIBUTE27 VARCHAR2(4000),
	EXTATTRIBUTE28 VARCHAR2(4000),
	EXTATTRIBUTE29 VARCHAR2(4000),
	EXTATTRIBUTE30 VARCHAR2(4000),
	EXTATTRIBUTE31 VARCHAR2(4000),
	EXTATTRIBUTE32 VARCHAR2(4000),
	EXTATTRIBUTE33 VARCHAR2(4000),
	EXTATTRIBUTE34 VARCHAR2(4000),
	EXTATTRIBUTE35 VARCHAR2(4000),
	EXTATTRIBUTE36 VARCHAR2(4000),
	EXTATTRIBUTE37 VARCHAR2(4000),
	EXTATTRIBUTE38 VARCHAR2(4000),
	EXTATTRIBUTE39 VARCHAR2(4000),
	EXTATTRIBUTE40 VARCHAR2(4000),
	EXTATTRIBUTE41 VARCHAR2(4000),
	EXTATTRIBUTE42 VARCHAR2(4000),
	EXTATTRIBUTE43 VARCHAR2(4000),
	EXTATTRIBUTE44 VARCHAR2(4000),
	EXTATTRIBUTE45 VARCHAR2(4000),
	EXTATTRIBUTE46 VARCHAR2(4000),
	EXTATTRIBUTE47 VARCHAR2(4000),
	EXTATTRIBUTE48 VARCHAR2(4000),
	EXTATTRIBUTE49 VARCHAR2(4000),
	EXTATTRIBUTE50 VARCHAR2(4000),
	EXTATTRIBUTE51 VARCHAR2(4000),
	EXTATTRIBUTE52 VARCHAR2(4000),
	EXTATTRIBUTE53 VARCHAR2(4000),
	EXTATTRIBUTE54 VARCHAR2(4000),
	EXTATTRIBUTE55 VARCHAR2(4000),
	EXTATTRIBUTE56 VARCHAR2(4000),
	EXTATTRIBUTE57 VARCHAR2(4000),
	EXTATTRIBUTE58 VARCHAR2(4000),
	EXTATTRIBUTE59 VARCHAR2(4000),
	EXTATTRIBUTE60 VARCHAR2(4000),
	DESCRIPTION VARCHAR2(240),
	MULTIPLIER NUMBER
   )  ENABLE ROW MOVEMENT ;
CREATE INDEX TMCS_LOOKUP_VALUES_NN_INDX02 ON TMCS_LOOKUP_VALUES_NN (LOOKUP_CODE)
  ;
CREATE UNIQUE INDEX TMCS_LOOKUP_VALUES_NN_INDX03 ON TMCS_LOOKUP_VALUES_NN (LOOKUP_ID, LOOKUP_VALUE_ID, LOOKUP_CODE, LANGUAGE_CODE)
  ;
CREATE INDEX TMCS_LOOKUP_VALUES_NN_INDX01 ON TMCS_LOOKUP_VALUES_NN (LOOKUP_ID)
  ;

