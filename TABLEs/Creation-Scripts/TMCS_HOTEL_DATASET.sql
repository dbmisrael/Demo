CREATE TABLE TMCS_HOTEL_DATASET
   (	OBJECTID NUMBER,
	NAME VARCHAR2(30),
	ADDRESS VARCHAR2(30),
	CITY VARCHAR2(16),
	STATE VARCHAR2(20),
	ZIP VARCHAR2(5),
	SIC VARCHAR2(6),
	NAICS_EXT VARCHAR2(8),
	SALES_VOL NUMBER,
	NUMBER_EMP NUMBER,
	EMPSIZ VARCHAR2(1),
	SQFT VARCHAR2(1),
	LOCNUM VARCHAR2(9),
	GEOMETRY MDSYS.SDO_GEOMETRY
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
  CREATE UNIQUE INDEX TMCS_HOTEL_DATASET_PK ON TMCS_HOTEL_DATASET (OBJECTID)
  ;
ALTER TABLE TMCS_HOTEL_DATASET ADD CONSTRAINT TMCS_HOTEL_DATASET_PK PRIMARY KEY (OBJECTID)
  USING INDEX TMCS_HOTEL_DATASET_PK  ENABLE;
CREATE INDEX TMCS_HOTEL_DATASET_GIDX ON TMCS_HOTEL_DATASET (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('SDO_RTR_PCTFREE=0 WORK_TABLESPACE=SPTL_TS_INDX');
CREATE UNIQUE INDEX TMCS_HOTEL_DATASET_PK ON TMCS_HOTEL_DATASET (OBJECTID)
  ;

