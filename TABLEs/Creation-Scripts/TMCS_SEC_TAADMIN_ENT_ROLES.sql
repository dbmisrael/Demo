CREATE TABLE TMCS_SEC_TAADMIN_ENT_ROLES
   (	ENT_ROLE_ID NUMBER DEFAULT TMCS_SEC_TAADMIN_ENT_ROLES_S.NEXTVAL,
	ENT_ROLE_NAME VARCHAR2(50) NOT NULL ENABLE,
	ENT_ROLE_DESC VARCHAR2(200),
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	COUNTRY_CODE VARCHAR2(10),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0) DEFAULT 1,
	BU_ID NUMBER,
	USER_TYPE VARCHAR2(20) DEFAULT 'CORPORATE'
   ) ;
  CREATE UNIQUE INDEX TMCS_SEC_TAADMIN_ENT_ROLES_PK ON TMCS_SEC_TAADMIN_ENT_ROLES (ENT_ROLE_ID)
  ;
ALTER TABLE TMCS_SEC_TAADMIN_ENT_ROLES ADD PRIMARY KEY (ENT_ROLE_ID)
  USING INDEX TMCS_SEC_TAADMIN_ENT_ROLES_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_SEC_TAADMIN_ENT_ROLES_PK ON TMCS_SEC_TAADMIN_ENT_ROLES (ENT_ROLE_ID)
  ;

