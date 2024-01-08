CREATE TABLE TMCS_RELATIONSHIPS
   (	RELATIONSHIP_ID NUMBER DEFAULT TMCS_RELATIONSHIPS_S.NEXTVAL,
	RELATIONSHIP_NAME VARCHAR2(500),
	RELATIONSHIP_NUMBER VARCHAR2(500),
	DESCTIPTION VARCHAR2(100),
	RELATIONSHIP_TYPE VARCHAR2(100),
	REQUIRED_FLAG VARCHAR2(100),
	CARDINALITY VARCHAR2(100),
	LEFT_ENTITY VARCHAR2(100),
	LEFT_ROLE VARCHAR2(100),
	RIGHT_ENTITY VARCHAR2(100),
	RIGHT_ROLE VARCHAR2(100),
	ORG_ID NUMBER(*,0),
	CLIENT_ID NUMBER(*,0),
	BRAND_ID NUMBER(*,0),
	CREATION_DATE TIMESTAMP (6) DEFAULT sysdate,
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0) DEFAULT 1
   ) ;
  CREATE UNIQUE INDEX TMCS_RELATIONSHIPS_PK ON TMCS_RELATIONSHIPS (RELATIONSHIP_ID)
  ;
ALTER TABLE TMCS_RELATIONSHIPS ADD CONSTRAINT TMCS_RELATIONSHIPS_PK PRIMARY KEY (RELATIONSHIP_ID)
  USING INDEX TMCS_RELATIONSHIPS_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_RELATIONSHIPS_PK ON TMCS_RELATIONSHIPS (RELATIONSHIP_ID)
  ;

