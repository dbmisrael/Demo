CREATE TABLE TMCS_SEC_ENTITY_GROUPS
   (	GROUP_ID NUMBER DEFAULT TMCS_SEC_ENTITY_GROUPS_S.NEXTVAL,
	GROUP_NAME VARCHAR2(50) NOT NULL ENABLE,
	GROUP_DESC VARCHAR2(200),
	CLIENT_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER,
	OBJECT_VERSION_NUMBER NUMBER
   ) ;
  CREATE UNIQUE INDEX TMCS_SEC_ENTITY_GROUPS_PK ON TMCS_SEC_ENTITY_GROUPS (GROUP_ID)
  ;
ALTER TABLE TMCS_SEC_ENTITY_GROUPS ADD CONSTRAINT TMCS_SEC_ENTITY_GROUPS_PK PRIMARY KEY (GROUP_ID)
  USING INDEX TMCS_SEC_ENTITY_GROUPS_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_SEC_ENTITY_GROUPS_PK ON TMCS_SEC_ENTITY_GROUPS (GROUP_ID)
  ;

