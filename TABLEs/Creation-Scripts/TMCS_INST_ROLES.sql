CREATE TABLE TMCS_INST_ROLES
   (	INST_ROLE_ID NUMBER DEFAULT TMCS_INST_ROLES_S.NEXTVAL,
	ROLE_ID NUMBER,
	ENTITY_TYPE VARCHAR2(100),
	ENTITY_ID NUMBER,
	ROLE_CODE VARCHAR2(100),
	EFF_START_DATE DATE,
	EFF_END_DATE DATE,
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
  CREATE UNIQUE INDEX TMCS_INST_ROLES_PK ON TMCS_INST_ROLES (INST_ROLE_ID)
  ;
ALTER TABLE TMCS_INST_ROLES ADD CONSTRAINT TMCS_INST_ROLES_PK PRIMARY KEY (INST_ROLE_ID)
  USING INDEX TMCS_INST_ROLES_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_INST_ROLES_PK ON TMCS_INST_ROLES (INST_ROLE_ID)
  ;

