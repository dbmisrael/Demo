CREATE TABLE TMCS_ENTITY_INTF_MAPINGS
   (	INTF_MAPING_ID NUMBER,
	INTF_MAP_HEADER_ID NUMBER,
	SOURCE_COLUMN_ID NUMBER,
	SOURCE_FORMULAE VARCHAR2(4000),
	TARGET_COLUMN_ID NUMBER,
	CLIENT_ID NUMBER,
	BRAND_ID NUMBER,
	COUNTRY VARCHAR2(100),
	BU_ID NUMBER,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(200),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(200),
	LAST_UPDATE_LOGIN NUMBER(38,0),
	OBJECT_VERSION_NUMBER NUMBER(38,0),
	 CONSTRAINT INTF_MAPPINGS_PK PRIMARY KEY (INTF_MAPING_ID)
  USING INDEX  ENABLE,
	 CONSTRAINT INTF_MAPPING_FK FOREIGN KEY (INTF_MAP_HEADER_ID)
	  REFERENCES TMCS_ENTITY_INTF_MAP_HEADER (INTF_MAP_HEADER_ID) ENABLE,
	 CONSTRAINT INTF_SOURCE_COL_FK FOREIGN KEY (SOURCE_COLUMN_ID)
	  REFERENCES TMCS_ENTITY_INTF_MAP_COLUMNS (INTF_MAP_COLUMNS_ID) ENABLE,
	 CONSTRAINT INTF_TARGET_COL_FK FOREIGN KEY (TARGET_COLUMN_ID)
	  REFERENCES TMCS_ENTITY_INTF_MAP_COLUMNS (INTF_MAP_COLUMNS_ID) ENABLE
   ) ;

