CREATE TABLE TMCS_RESO_BOUD_DTL_APPR_LIMITS
   (	APPR_LIMIT_ID NUMBER DEFAULT TMCS_RESO_BOUD_APPR_LIMITS_S.NEXTVAL,
	BOUNDRY_DTL_ID NUMBER,
	RESOURCE_BOUNDRY_ID NUMBER,
	ENTITY_TYPE VARCHAR2(100),
	MODULE VARCHAR2(100),
	APPROVAL_LIMIT NUMBER,
	ORG_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	BRAND_ID NUMBER(38,0),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER,
	 PRIMARY KEY (APPR_LIMIT_ID)
  USING INDEX  ENABLE
   ) ;
