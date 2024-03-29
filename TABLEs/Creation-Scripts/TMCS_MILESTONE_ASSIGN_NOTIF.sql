CREATE TABLE TMCS_MILESTONE_ASSIGN_NOTIF
   (	ASSIGN_NOTIF_ID NUMBER DEFAULT TMCS_MILESTONE_ASSIGN_NOTIF_S.NEXTVAL,
	EMAIL VARCHAR2(100),
	SUBJECT VARCHAR2(500),
	MESSAGE VARCHAR2(4000),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	PROCESSED_FLAG VARCHAR2(10),
	ENTITY_TYPE VARCHAR2(50),
	ENTITY_ID NUMBER,
	 PRIMARY KEY (ASSIGN_NOTIF_ID)
  USING INDEX  ENABLE
   ) ;

