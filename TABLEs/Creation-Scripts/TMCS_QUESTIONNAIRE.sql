CREATE TABLE TMCS_QUESTIONNAIRE
   (	QUESTION_ID NUMBER,
	ENTITY_ID NUMBER,
	DESCRIPTION VARCHAR2(50),
	N_EXT_ATTR1 NUMBER,
	N_EXT_ATTR2 NUMBER,
	N_EXT_ATTR3 NUMBER,
	N_EXT_ATTR4 NUMBER,
	N_EXT_ATTR5 NUMBER,
	N_EXT_ATTR6 NUMBER,
	N_EXT_ATTR7 NUMBER,
	N_EXT_ATTR8 NUMBER,
	N_EXT_ATTR9 NUMBER,
	N_EXT_ATTR10 NUMBER,
	N_EXT_ATTR11 NUMBER,
	N_EXT_ATTR12 NUMBER,
	N_EXT_ATTR13 NUMBER,
	N_EXT_ATTR14 NUMBER,
	N_EXT_ATTR15 NUMBER,
	N_EXT_ATTR16 NUMBER,
	N_EXT_ATTR17 NUMBER,
	N_EXT_ATTR18 NUMBER,
	N_EXT_ATTR19 NUMBER,
	N_EXT_ATTR20 NUMBER,
	C_EXT_ATTR1 VARCHAR2(150),
	C_EXT_ATTR2 VARCHAR2(150),
	C_EXT_ATTR3 VARCHAR2(150),
	C_EXT_ATTR4 VARCHAR2(150),
	C_EXT_ATTR5 VARCHAR2(150),
	C_EXT_ATTR6 VARCHAR2(150),
	C_EXT_ATTR7 VARCHAR2(150),
	C_EXT_ATTR8 VARCHAR2(150),
	C_EXT_ATTR9 VARCHAR2(150),
	C_EXT_ATTR10 VARCHAR2(150),
	C_EXT_ATTR11 VARCHAR2(150),
	C_EXT_ATTR12 VARCHAR2(150),
	C_EXT_ATTR13 VARCHAR2(150),
	C_EXT_ATTR14 VARCHAR2(150),
	C_EXT_ATTR15 VARCHAR2(150),
	C_EXT_ATTR16 VARCHAR2(150),
	C_EXT_ATTR17 VARCHAR2(150),
	C_EXT_ATTR18 VARCHAR2(150),
	C_EXT_ATTR19 VARCHAR2(150),
	C_EXT_ATTR20 VARCHAR2(150),
	D_EXT_ATTR1 DATE,
	D_EXT_ATTR2 DATE,
	D_EXT_ATTR3 DATE,
	D_EXT_ATTR4 DATE,
	D_EXT_ATTR5 DATE,
	D_EXT_ATTR6 DATE,
	D_EXT_ATTR7 DATE,
	D_EXT_ATTR8 DATE,
	D_EXT_ATTR9 DATE,
	D_EXT_ATTR10 DATE,
	D_EXT_ATTR11 DATE,
	D_EXT_ATTR12 DATE,
	D_EXT_ATTR13 DATE,
	D_EXT_ATTR14 DATE,
	D_EXT_ATTR15 DATE,
	SITE_PICTURE BLOB,
	VOICE_RECORD BLOB,
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0)
   ) ;
  CREATE UNIQUE INDEX TMCS_QUESTIONNAIRE_ID ON TMCS_QUESTIONNAIRE (QUESTION_ID)
  ;
ALTER TABLE TMCS_QUESTIONNAIRE ADD CONSTRAINT TMCS_QUESTIONNAIRE_PK PRIMARY KEY (QUESTION_ID)
  USING INDEX TMCS_QUESTIONNAIRE_ID  ENABLE;
CREATE UNIQUE INDEX TMCS_QUESTIONNAIRE_ID ON TMCS_QUESTIONNAIRE (QUESTION_ID)
  ;

