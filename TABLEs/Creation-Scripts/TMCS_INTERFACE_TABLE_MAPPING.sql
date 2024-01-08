CREATE TABLE TMCS_INTERFACE_TABLE_MAPPING
   (	INTERFACE_ID NUMBER,
	SOURCE_TABLE_NAME VARCHAR2(50),
	TARGET_TABLE_NAME VARCHAR2(50),
	SELECT_QUERY VARCHAR2(1000),
	FROM_QUERY VARCHAR2(1000),
	WHERE_PRIMARY_QUERY VARCHAR2(1000),
	WHERE_SECONDARY_QUERY VARCHAR2(1000),
	DATA_TYPE VARCHAR2(100),
	MAPPED_PRIMARY_FIELD_NAME VARCHAR2(50),
	RECORD_ACTIVE_YN VARCHAR2(1),
	DATE_CREATED DATE,
	CREATED_BY VARCHAR2(100),
	ID NUMBER,
	ADDITIONAL_VAL VARCHAR2(1000)
   ) ;
  CREATE UNIQUE INDEX TMCS_INTF_TABLE_MAPPING_PK ON TMCS_INTERFACE_TABLE_MAPPING (ID)
  ;
ALTER TABLE TMCS_INTERFACE_TABLE_MAPPING ADD CONSTRAINT TMCS_INTF_TABLE_MAPPING_PK PRIMARY KEY (ID)
  USING INDEX TMCS_INTF_TABLE_MAPPING_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_INTF_TABLE_MAPPING_PK ON TMCS_INTERFACE_TABLE_MAPPING (ID)
  ;

