CREATE TABLE TMCS_GEOFENCE_TA_DATA
   (	GFENCE_ID NUMBER,
	TA_TYPE VARCHAR2(500),
	GEOMETRY SDO_GEOMETRY,
	CREATION_DATE TIMESTAMP (6),
	CREATED_BY VARCHAR2(50),
	LAST_UPDATE_DATE TIMESTAMP (6),
	LAST_UPDATED_BY VARCHAR2(50),
	LAST_UPDATE_LOGIN NUMBER(*,0),
	OBJECT_VERSION_NUMBER NUMBER(*,0)
   )
 VARRAY GEOMETRY.SDO_ELEM_INFO STORE AS SECUREFILE LOB
 VARRAY GEOMETRY.SDO_ORDINATES STORE AS SECUREFILE LOB ;
  CREATE UNIQUE INDEX TMCS_GEOFENCE_TA_DATA_PK ON TMCS_GEOFENCE_TA_DATA (GFENCE_ID, TA_TYPE)
  ;
ALTER TABLE TMCS_GEOFENCE_TA_DATA ADD CONSTRAINT TMCS_GEOFENCE_TA_DATA_PK PRIMARY KEY (GFENCE_ID, TA_TYPE)
  USING INDEX TMCS_GEOFENCE_TA_DATA_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_GEOFENCE_TA_DATA_PK ON TMCS_GEOFENCE_TA_DATA (GFENCE_ID, TA_TYPE)
  ;
CREATE INDEX TMCS_GEOFENCE_TA_DATA_GIDX ON TMCS_GEOFENCE_TA_DATA (GEOMETRY)
   INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2  PARAMETERS ('WORK_TABLESPACE=SPTL_TS_INDX');
-- COMMENT --

   COMMENT ON COLUMN TMCS_GEOFENCE_TA_DATA.TA_TYPE IS '#HOME/GENERATOR';