CREATE TABLE TMCS_MAP_TABLE_PRIMARY_KEYS
   (	ID NUMBER DEFAULT TMCS_MAP_TABLE_PRIMARY_KEYS_S.NEXTVAL,
	TABLE_NAME VARCHAR2(30),
	COLUMN_NAME VARCHAR2(30),
	ADD_CLAUSES VARCHAR2(300),
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0)
   ) ;
