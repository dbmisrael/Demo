CREATE OR REPLACE EDITIONABLE PACKAGE TMCS_GIS_SLM_PKG_VN
AS
  ----------------------------------------------------------
  -- 1.0  22-Feb-2012 Vamsi Nagavalli Initial creation.
  ----------------------------------------------------------
  ----------------------------------------------------------
  -- General procedure to retrieve an URL.gdf
  ----------------------------------------------------------
TYPE l_array IS TABLE OF VARCHAR2(32767) INDEX BY BINARY_INTEGER;

PROCEDURE TMC_VERSION_TRADEAREA
                                (p_message OUT NUMBER
                                ,p_site_id IN NUMBER
                                ,p_new_current_trade_area_id IN NUMBER
                                ,p_brand in VARCHAR2
                                );
PROCEDURE TMC_MAINTAIN_SITES
                                (p_message OUT VARCHAR2
                                ,p_dma IN VARCHAR2
                                ,p_target_id IN NUMBER
                                ,p_site_name IN NVARCHAR2
                                ,p_longitude IN NUMBER
                                ,p_latitude IN NUMBER
                                ,p_address IN NVARCHAR2
                                ,p_city IN NVARCHAR2
                                ,p_state IN NVARCHAR2
                                ,p_country IN NVARCHAR2
                                ,p_zip_code IN VARCHAR2
                                ,p_trade_area_type IN VARCHAR2
                                ,p_ring_miles IN NUMBER
                                ,p_description IN VARCHAR2
                                ,p_StoreType IN VARCHAR2
                                ,p_drive_thru IN VARCHAR2
                                ,p_brand IN VARCHAR2
                                ,p_user_name IN VARCHAR2
                                ,p_geometry IN MDSYS.SDO_GEOMETRY
                                ,p_drive_time_coordinates IN MDSYS.SDO_GEOMETRY DEFAULT NULL
                                ,p_scID IN VARCHAR2 DEFAULT NULL
                                );
 PROCEDURE TMC_CREATE_SITES(p_message OUT VARCHAR2
                                ,p_dma IN VARCHAR2
                                ,p_target_id IN NUMBER
                                ,p_site_name IN NVARCHAR2
                                ,p_longitude IN NUMBER
                                ,p_latitude IN NUMBER
                                ,p_address IN NVARCHAR2
                                ,p_city IN NVARCHAR2
                                ,p_state IN NVARCHAR2
                                ,p_country IN NVARCHAR2
                                ,p_zip_code IN VARCHAR2
                                ,p_trade_area_type IN VARCHAR2
                                ,p_ring_miles IN NUMBER
                                ,p_description IN VARCHAR2
                                ,p_StoreType IN VARCHAR2
                                ,p_drive_thru IN VARCHAR2
                                ,p_brand IN VARCHAR2
                                ,p_user_name IN VARCHAR2
--                                ,p_geometry IN MDSYS.SDO_GEOMETRY
--                                ,p_drive_time_coordinates IN MDSYS.SDO_GEOMETRY DEFAULT NULL
                                ,p_siteID out NUMBER
                                ,p_scID IN VARCHAR2 DEFAULT NULL
                                ,p_BatchID NUMBER Default NULL
                                ,p_BatchDetailID NUMBER Default NULL
                                ,p_CustomJson VARCHAR2 Default NULL
                                );
 PROCEDURE TMCS_GIS_TRADEAREA_EJOB(
                                p_siteID IN NUMBER ,
                                p_BRAND  IN VARCHAR2 ,
                                p_user_name VARCHAR2 ,
                                p_trade_area_type IN VARCHAR2 ,
                                p_description     IN VARCHAR2 ,
                                p_ring_miles      IN NUMBER ,
                                CLIENT_ID NUMBER,
                                COUNTRY VARCHAR2
                                );
PROCEDURE TMC_MAINTAIN_TRADEAREAS
                                (p_message OUT VARCHAR2
                                ,p_site_id IN NUMBER
                                ,p_user_name varchar2
                                ,p_trade_area_type IN VARCHAR2
                                ,p_description IN VARCHAR2
                                ,p_brand in VARCHAR2
                                ,p_geom IN MDSYS.SDO_GEOMETRY
                                ,p_TA_TYPE IN VARCHAR2 DEFAULT 'RETAIL'
                                ,p_TA_STATUS IN VARCHAR2 DEFAULT 'TRUE'
                                );
PROCEDURE TMC_TA_DEMO_REPORT (P_SITEID  IN NUMBER
                              ,P_Type    IN VARCHAR2
                              ,P_BRAND   IN VARCHAR2
                              ,p_user_name in VARCHAR2
                              ,P_CorelationID VARCHAR2
                              ,p_result OUT STYLE);
function TMC_setgeometry(tbl varchar2
                        , column varchar2
                        , whereClause varchar2)
                        return MDSYS.sdo_geometry_array deterministic;
PROCEDURE TMC_3_RING_REPORT
                             (P_result OUT style
                             ,P_LAT  IN NUMBER
                             ,P_LONG IN NUMBER
                             ,P_RING1 IN NUMBER
                             ,P_RING2 IN NUMBER
                             ,P_RING3 IN NUMBER
                             ,p_type  IN VARCHAR2
                             ,p_ID    IN NUMBER
                             ,p_clientID IN VARCHAR2
                             ,p_template   IN VARCHAR2
                             ,P_CorelationID IN VARCHAR2
                            );
PROCEDURE TMC_3_RING_REPORT
                             (P_result OUT style
                             ,P_LAT  IN NUMBER
                             ,P_LONG IN NUMBER
                             ,P_RING1 IN NUMBER
                             ,P_RING2 IN NUMBER
                             ,P_RING3 IN NUMBER
                             ,p_type  IN VARCHAR2
                             ,p_ID    IN NUMBER
                             ,p_brand IN VARCHAR2
                             ,p_template   IN VARCHAR2
                            );
 Procedure TMC_GETSF( p_message out VARCHAR2
                     ,p_brand   IN   VARCHAR2
                     ,p_SITEID    in  NUMBER
                     ,p_user_name in VARCHAR2
                     ,p_SF_ID IN NUMBER
                    );
 Procedure TMC_GETANALOG( p_message out VARCHAR2
                     ,p_brand   IN   VARCHAR2
                     ,p_SITEID    in  NUMBER
                      ,p_user_name IN VARCHAR2
                            );
Procedure TMC_MOD_TA_DISAGG(  p_Site_ID IN NUMBER
                             ,p_brand   IN VARCHAR2
                             ,p_user_name IN VARCHAR2);

--Function tmc_get_group_code(p_brand varchar2) return char;
Function TMC_CALLWEBSERVICE( p_wsdl    varchar2,
                              p_servicename varchar2,
                              p_portType    varchar2,
                              p_operationName   varchar2,
                              p_soapURI     VARCHAR2,
                              p_encordingURI    VARCHAR2,
                              p_responseTag varchar2,
                              p_param1    VARCHAR2,
                              p_param2    varchar2
                            ) return VARCHAR2;
PROCEDURE TMC_MAINTAIN_Targets
                                (p_message OUT VARCHAR2
                                ,p_dma IN VARCHAR2
                                ,p_target_name IN VARCHAR2
                                ,p_longitude IN NUMBER
                                ,p_latitude IN NUMBER
                                ,p_address IN VARCHAR2
                                ,p_city IN VARCHAR2
                                ,p_state IN VARCHAR2
                                ,p_country IN VARCHAR2
                                ,p_zip_code IN VARCHAR2
                                ,p_ring_miles IN NUMBER
                                ,p_description IN VARCHAR2
                                ,p_brand IN VARCHAR2
                                ,p_user_name IN VARCHAR2
                                ,p_seedID IN VARCHAR2 DEFAULT NULL
                                );
PROCEDURE TMC_CREATE_Targets
                                (p_message OUT VARCHAR2
                                ,p_dma IN VARCHAR2
                                ,p_target_name IN VARCHAR2
                                ,p_longitude IN NUMBER
                                ,p_latitude IN NUMBER
                                ,p_address IN VARCHAR2
                                ,p_city IN VARCHAR2
                                ,p_state IN VARCHAR2
                                ,p_country IN VARCHAR2
                                ,p_zip_code IN VARCHAR2
                                ,p_ring_miles IN NUMBER
                                ,p_description IN VARCHAR2
                                ,p_brand IN VARCHAR2
                                ,p_user_name IN VARCHAR2
                                ,p_seedID IN VARCHAR2 DEFAULT NULL
                                ,p_targetID OUT NUMBER
                                ,p_CustomJson IN VARCHAR2 DEFAULT NULL
                                );
PROCEDURE TMC_MAINTAIN_TARGETS_TA
                                    (p_message OUT VARCHAR2
                                     ,p_target_id IN NUMBER
                                     ,p_brand in VARCHAR2
                                     ,p_user_name IN VARCHAR2
                                     ,p_radius IN NUMBER
                                     ,p_description IN VARCHAR2
                                     ,p_geom IN MDSYS.SDO_GEOMETRY
                                     ,p_TA_TYPE IN VARCHAR2 DEFAULT NULL
                                     ,p_TA_STATUS IN VARCHAR2 DEFAULT 'TRUE'
                                     );
PROCEDURE TMC_MARKET_REPORT
                             (P_result OUT style
                             ,p_ID    IN VARCHAR2
                             ,p_type  IN VARCHAR2
                             ,p_brand IN VARCHAR2
                             ,p_template   IN VARCHAR2
                            );
PROCEDURE  TMC_DRAW_ENTITY_TA( p_ENTITYID IN NUMBER
                                                        , P_ENTITYTYPE in VARCHAR2 DEFAULT 'SITE'
                                                        , P_TA_TYPE in VARCHAR2 DEFAULT 'RETAIL'
                                                        , P_DESCRIPTION in VARCHAR2 DEFAULT NULL
                                                        , P_GEOMETRY IN MDSYS.SDO_GEOMETRY
                                                        , P_BRAND_ID IN NUMBER
                                                        , P_MESSAGE out VARCHAR2
                                                        );
PROCEDURE  tmc_DT_SiteTA( p_SiteID IN NUMBER
                        ,p_user_name IN Varchar2
                        , p_DTmin  IN NUMBER
                        ,p_type IN VARCHAR2
                        , p_message out VARCHAR2
                        , p_ta_TYPE in VARCHAR2 DEFAULT 'RETAIL'
                        , p_entityType in VARCHAR2 DEFAULT 'SITE');
PROCEDURE TMC_MAINTAIN_PROSPECTS(
                                p_message OUT VARCHAR2
                                ,p_prospect_name  VARCHAR2
                                ,p_longitude  NUMBER
                                ,p_latitude  NUMBER
                                ,p_address  VARCHAR2
                                ,p_city          VARCHAR2
                                ,p_state          VARCHAR2
                                ,p_zip_code      VARCHAR2
                                ,p_StoreType      VARCHAR2
                                ,p_drive_thru      VARCHAR2
                                ,p_trade_area_type VARCHAR2
                                ,p_ring_miles  NUMBER
                                ,p_description  VARCHAR2
                                ,p_brand  VARCHAR2
                                ,p_user_name  VARCHAR2
                                ,p_insert VARCHAR2
                                ,p_prospectID NUMBER DEFAULT NULL
                                ,p_drive_time_coordinates IN MDSYS.SDO_GEOMETRY DEFAULT NULL
                                ,p_CustomJson IN VARCHAR2 DEFAULT NULL
                                );
PROCEDURE TMC_MAINTAIN_PROSPECTS_TA
                                    (p_message OUT VARCHAR2
                                     ,p_prospectID IN NUMBER
                                     ,p_description IN VARCHAR2
                                     ,p_brand in VARCHAR2
                                     ,p_user_name IN VARCHAR2
                                     ,p_geom IN MDSYS.SDO_GEOMETRY
                                     );
FUNCTION SPLIT_STRING (p_in_string VARCHAR2, p_delim VARCHAR2) RETURN l_array;
Procedure TMCS_ANALOG_SAVE_RESULTS(
                                        p_AnalogID  IN NUMBER
                                        ,P_SITE_ID   IN NUMBER
                                        ,P_STORE_IDs IN VARCHAR2
                                        ,p_user_name IN VARCHAR2
                                        ,p_tatype    IN NUMBER
                                        ,p_brand IN NUMBER
                                        ,p_message OUT VARCHAR2
                                        );
Procedure TMCS_GET_OPTMIZATION(p_scenario_ID IN NUMBER
                                                        , p_user_name IN VARCHAR2
                                                        ,p_message OUT VARCHAR2
                                                        );
PROCEDURE TMCS_OSM_DT_ENGINE(p_longitude IN NUMBER
                                                      ,p_latitude IN NUMBER
                                                      ,p_DT_Min IN VARCHAR2
                                                      ,p_threshold IN Number
                                                      ,p_country IN VARCHAR2
                                                      ,p_output_table IN VARCHAR2
                                                      ,P_ID IN VARCHAR2
                                                      ,p_columnID IN VARCHAR2
                                                      ,p_brand_ID IN VARCHAR2 Default NULL
                                                      ,p_message OUT VARCHAR2);
Procedure  TMCS_CALL_KETTLE_SERVICE(p_transformation VARCHAR2
                                                              , P_SEND_REQUEST VARCHAR2
                                                              , P_json  OUT JSON -- Out Parameters
                                                              , P_MESSAGE  OUT VARCHAR2 -- Out Parameters
                                                              );
Function TMCS_RECTIFY_POLY(p_Poly MDSYS.SDO_GEOMETRY) Return MDSYS.SDO_GEOMETRY;
Function TMCS_SIMPLIFY_POLY(p_Poly MDSYS.SDO_GEOMETRY) Return MDSYS.SDO_GEOMETRY;
 procedure TMCS_call_POST_rest_webservice(p_send_request VARCHAR2
                                                       ,p_URL VARCHAR2
                                                       ,p_response OUT VARCHAR2
                                                       ,p_GUID OUT VARCHAR2
                                                       );
 procedure TMCS_call_POST_rest_webservice(p_send_request CLOB
                                                       ,p_URL VARCHAR2
                                                       ,p_response OUT CLOB
                                                       );
procedure TMCS_call_GET_rest_webservice(p_URL VARCHAR2
                                                       ,p_response OUT CLOB
                                                       );
 procedure TMCS_call_GET_rest_webservice(p_send_request VARCHAR2
                                                       ,p_URL VARCHAR2
                                                       ,p_response OUT VARCHAR2
                                                       );
Procedure TMCS_GET_REST_W_HEADERS(p_URL VARCHAR2
                                 ,p_response  OUT CLOB);
Procedure TMC_GET_SALESTRANSFER( p_message out VARCHAR2
                     ,p_brand   IN   VARCHAR2
                     ,p_STOREID    in  NUMBER
                      ,p_user_name in VARCHAR2);
PROCEDURE TMCS_DELETE_DATA_COMMIT(p_table_name VARCHAR2
                                                                ,p_whereClause VARCHAR2);
PROCEDURE  TMCS_INSERT_ERROR_LOG(p_ENTITY_TYPE             IN VARCHAR2
                                                            , p_FUNCTIONALITY             IN VARCHAR2
                                                            , p_ERROR_CODE             IN VARCHAR2
                                                            , p_TMC_MESSAGE            IN VARCHAR2
                                                            , p_ERROR_MESSAGE     IN VARCHAR2
                                                            , p_CLIENT_ID                 in NUMBER
                                                            , p_USER_Name                 IN VARCHAR2
                                                            );
Function tmc_get_demo_table(Client_ID NUMBER) return VARCHAR2;
PROCEDURE TMC_MAINTAIN_MARKETS
                             (p_message OUT VARCHAR2,
                            p_status OUT VARCHAR2,
                            p_geom  IN MDSYS.SDO_GEOMETRY,
                            p_json IN VARCHAR2);
 PROCEDURE TMC_MAINTAIN_COMPETITORS
                                (p_message OUT VARCHAR2
                                ,p_Comp_name IN VARCHAR2
                                ,p_longitude IN NUMBER
                                ,p_latitude IN NUMBER
                                ,p_address IN VARCHAR2
                                ,p_city IN VARCHAR2
                                ,p_state IN VARCHAR2
                                ,p_country IN VARCHAR2
                                ,p_zip_code IN VARCHAR2
                                ,p_attr1 IN VARCHAR2 DEFAULT NULL
                                ,p_attr2 IN VARCHAR2 DEFAULT NULL
                                ,p_attr3 IN VARCHAR2 DEFAULT NULL
                                ,p_user_name IN VARCHAR2
                                ,p_level1 IN VARCHAR2  DEFAULT NULL
                                ,p_level2 IN VARCHAR2  DEFAULT NULL
                                );
Procedure TMCS_MAINTAIN_COMP_EVENTS(P_MESSAGE OUT VARCHAR2
                                    ,P_JSON IN VARCHAR2) ;
Procedure GEOM_STRING_TO_SDOPOLY(p_geomString IN CLOB
                                ,p_geomStringType IN VARCHAR2
                                ,p_aggPoly OUT SDO_GEOMETRY
                                ,p_stitch IN VARCHAR2 DEFAULT 'TRUE');
PROCEDURE TMC_MAINTAIN_ENTITIES
                             (p_message OUT VARCHAR2,
                            p_status OUT VARCHAR2,
                            p_geom  IN MDSYS.SDO_GEOMETRY,
                            p_json IN VARCHAR2) ;
Function TMCS_GET_DEFAULT_STATUS(p_entityType varchar2) Return VARCHAR2;
Function TMCS_GET_DEFAULT_STATUS(P_STATUS_TYPE VARCHAR2
                                                           ,P_ENTITY_TYPE VARCHAR2
                                                         ) Return VARCHAR2;
FUNCTION TMCS_GET_GEOMETRY(p_tableName VARCHAR2,
                                                    p_geomName VARCHAR2,
                                                    p_IDName VARCHAR2,
                                                    p_ID  VARCHAR2,
                                                    p_longitude NUMBER,
                                                    p_latitude NUMBER,
                                                    p_srid NUMBER) Return MDSYS.SDO_GEOMETRY;
FUNCTION TMCS_GET_GEOMETRY(p_JSON VARCHAR2)  Return MDSYS.SDO_GEOMETRY;
Procedure TMCS_Query_geometry(p_ID IN VARCHAR2
                                                     ,p_point IN MDSYS.SDO_GEOMETRY
                                                   , p_geometry OUT MDSYS.SDO_GEOMETRY
                                                   ,p_elementIDX OUT NUMBER
                                                   ,p_ringIDX OUT NUMBER
                                                   ,p_message OUT VARCHAR2 );
FUNCTION TMCS_Update_Direction(STR_LONG    NUMBER,
                              STR_LAT     NUMBER,
                              BG_GEOM     MDSYS.SDO_GEOMETRY)RETURN VARCHAR2;
Procedure TMCS_CUSTOM_POLY_DEMO_RPT (P_result OUT style
                                    ,p_template   IN VARCHAR2
                                    ,p_geometry  IN MDSYS.SDO_GEOMETRY
                                    ,p_CorelationID IN VARCHAR2 DEFAULT NULL
                                    );
Function TMC_GET_P2P( p_geom1 MDSYS.SDO_GEOMETRY,
                  p_geom2 MDSYS.SDO_GEOMETRY)return VARCHAR2;
FUNCTION TMCS_BATCH_P2P(p_longitude Number,
                                            p_latitude NUMBER,
                                            p_json JSON) return json;
FUNCTION TMCS_BATCH_P2P_SF(p_longitude Number,
                    p_latitude NUMBER,
                    p_json JSON,
                    p_version VARCHAR2 DEFAULT null) return json;
FUNCTION TMCS_BATCH_P2P_SF(p_longitude Number,
                                            p_latitude NUMBER,
                                            p_clob CLOB,
                                            p_version VARCHAR2 DEFAULT null) return json;
PROCEDURE TMCS_INTERNAL_SERVICE_GET(p_params VARCHAR2 Default NULL
                                                                  ,p_process VARCHAR2 Default NULL
                                                                  ,p_message OUT VARCHAR2) ;
PROCEDURE TMC_CREATE_SC(p_message OUT VARCHAR2
                        ,p_sc_name IN VARCHAR2
                        ,p_mallCode IN VARCHAR2
                        ,p_longitude IN NUMBER
                        ,p_latitude IN NUMBER
                        ,p_address IN VARCHAR2
                        ,p_city IN VARCHAR2
                        ,p_state IN VARCHAR2
                        ,p_zipcode IN VARCHAR2
                        ,p_userName IN VARCHAR2
                        ,p_gla IN NUMBER
                        ,p_attr1 IN VARCHAR2 DEFAULT NULL
                        ,p_attr2 IN VARCHAR2 DEFAULT NULL
                        ,p_attr3 IN VARCHAR2 DEFAULT NULL
                        );
PROCEDURE TMCS_STD_ATTRIBUTES_US(P_TYPE     IN  VARCHAR2
                                                            ,P_ID         IN    NUMBER
                                                            ,P_ENTITY_GEOM  IN MDSYS.SDO_GEOMETRY
                                                            ,P_MESSAGE  OUT VARCHAR2);
Function TMCS_P2P_JSON (p_sql VARCHAR2,
                        p_siteID NUMBER,
                        p_GEOMETRY MDSYS.SDO_GEOMETRY) RETURN json;
Function TMCS_GET_P2P_CLOB(p_longitude Number
                                            ,p_latitude NUMBER
                                            ,P_RADIUS number
                                            ,p_censusType VARCHAR2
                                            ,P_geomtype varchar2
                                            ,p_id number ) return CLOB;
Function TMCS_REMOVE_ISLAND_AND_HOLE(p_siteID NUMBER
                            ,p_srid NUMBER
                            ,p_geom SDO_GEOMETRY
                            ,p_subject SDO_GEOMETRY)  Return MDSYS.SDO_GEOMETRY;
PROCEDURE TMCS_CREATEJOB(p_jobName VARCHAR2,
                                                p_jobAction VARCHAR2,
                                                p_autoDrop BOOLEAN,
                                                p_params VARCHAR2,
                                                p_message OUT VARCHAR2 );
Procedure TMCS_UPDATE_DEMOGRAPHICS(p_siteID        IN     NUMBER
                                                         ,p_coordinates   IN     MDSYS.SDO_GEOMETRY
                                                         ,p_update        IN     VARCHAR2 DEFAULT NULL
                                                         ,p_entityType  IN VARCHAR2 DEFAULT NULL
                                                         ,p_brand IN NUMBER
                                                         ,p_output        OUT    VARCHAR2
                                                         ) ;
 PROCEDURE TMCS_MAINTAIN_STORE_TRADEAREAS
                                    (p_message OUT VARCHAR2
                                     ,p_site_id IN NUMBER
                                     ,p_user_name varchar2
                                     ,p_trade_area_type IN VARCHAR2
                                     ,p_description IN VARCHAR2
                                     ,p_brand in VARCHAR2
                                     ,p_geom IN MDSYS.SDO_GEOMETRY
                                     ,p_TA_TYPE IN VARCHAR2 DEFAULT 'RETAIL'
                                     ,p_TA_STATUS IN VARCHAR2 DEFAULT 'TRUE'
                                     );
PROCEDURE TMCS_UPDATE_MARKETS
                                    (p_message OUT VARCHAR2
                                     ,p_site_id IN NUMBER
                                     ,p_user_name varchar2
                                     ,p_trade_area_type IN VARCHAR2
                                     ,p_description IN VARCHAR2
                                     ,p_brand in VARCHAR2
                                     ,p_geom IN MDSYS.SDO_GEOMETRY
                                     ,p_type IN VARCHAR2
                                     ) ;
function TMCS_GET_MODEL_RAT(P_VAL NUMBER
                                                        ,P_STRING VARCHAR2)
RETURN NUMBER;
Procedure TMCS_SITE_SCORE(p_message OUT VARCHAR2
                                           ,p_SiteScore out NUMBER
                                           ,p_SiteForecast out NUMBER
                                           ,p_entityID IN NUMBER
                                           ,p_demoScore IN NUMBER
                                           ,p_user_name IN VARCHAR2
                                           ,P_ENTITY_TYPE IN VARCHAR2
                                           );
Procedure TMCS_UPDATE_STD_ATTRIBUTES(p_message OUT VARCHAR2
                                                                   ,p_entity_type in  VARCHAR2
                                                                   ,p_entityID IN NUMBER
                                                                   ,p_geometry MDSYS.SDO_GEOMETRY);
Procedure TMCS_SET_ENTITY_DEFAULTS(p_message OUT VARCHAR2
                                                                   ,p_entity_type in  VARCHAR2
                                                                   ,p_entityID IN NUMBER
                                                                  );
Procedure TMCS_UPDATE_CUST_ATTR(p_message OUT VARCHAR2
                                                                   ,p_entity_type in  VARCHAR2
                                                                   ,p_entityID IN NUMBER
                                                                   ,p_Json in VARCHAR2
                                                                  );
Procedure TMCS_CREATE_SITE_TA(p_site_id  IN NUMBER
                                                   ,p_brand IN VARCHAR2
                                                   ,p_user_name IN VARCHAR2
                                                   ,p_trade_area_type IN VARCHAR2
                                                   ,p_description IN VARCHAR2
                                                   ,p_ring_miles IN VARCHAR2
                                                   ,p_message OUT VARCHAR2);
Procedure TMCS_CREATE_TARGET_TA(p_target_id  IN NUMBER
                                                   ,p_brand IN VARCHAR2
                                                   ,p_ring_miles IN VARCHAR2
                                                   ,p_user_name IN VARCHAR2
                                                   ,p_message OUT VARCHAR2) ;
Procedure TMCS_GET_SET_CLASS(p_geometry IN MDSYS.SDO_GEOMETRY
                                                   ,p_entity_type in  VARCHAR2
                                                   ,p_entityID IN NUMBER
                                                   ,P_UPDATE IN VARCHAR2
                                                   ,P_STORE OUT NUMBER
                                                   ,P_CBSA OUT NUMBER) ;
Procedure TMCS_UPDATE_ENCROACHMENT(p_message OUT VARCHAR2
                                                                ,p_status OUT VARCHAR2
                                                                ,p_entity_type in  VARCHAR2
                                                                ,p_entityID IN NUMBER);
PROCEDURE TMC_VERSION_TARGET_TRADEAREA(p_message OUT NUMBER
                                                                        ,p_json IN VARCHAR2);
 PROCEDURE TMC_VERSION_STORE_TRADEAREA(p_message OUT NUMBER
                                                                        ,p_json IN VARCHAR2);
PROCEDURE TMCS_UNION_GEOMETRY_ARRAY(p_ID IN NUMBER
                                                            ,p_geoemtry IN MDSYS.SDO_GEOMETRY
                                                            ,p_finalPoly OUT  MDSYS.SDO_GEOMETRY );
Procedure TMCS_UPDATE_IDX_RPT_DEMOGS(p_TAID      IN NUMBER ,
                                                            p_update      IN VARCHAR2 DEFAULT NULL ,
                                                            p_entityType  IN VARCHAR2 DEFAULT NULL ,
                                                            p_output OUT VARCHAR2
                                                         );
FUNCTION TMC_Move_Entity_Email( p_batchID NUMBER, p_BATCH_STATUS VARCHAR2 ) RETURN VARCHAR2;
--Procedure TMC_Move_Entity(p_entityType VARCHAR2,
--                                        p_entityID VARCHAR2,
--                                        p_newLong NUMBER,
--                                        p_newLat NUMBER,
--                                        p_message OUT VARCHAR2
--                                        );
Procedure TMC_Approved_Move_Entity ( p_batchID NUMBER );
Procedure TMCS_Approved_Move_Entity_EJOB ( p_batchID NUMBER) ;
PROCEDURE TMCS_TRUNCATE_TRADEAREAS(p_message OUT VARCHAR2
                                     ,p_geom  IN MDSYS.SDO_GEOMETRY
                                     ,p_json IN VARCHAR2
                                     );
Procedure TMCS_TRUNCATE_TA( p_entity_id VARCHAR2
                        ,p_entityTYPE VARCHAR2
                        ,p_truncateAgainst VARCHAR2
                        ,p_truncateEntity VARCHAR2
                        ,p_entity_TA MDSYS.SDO_GEOMETRY
                        ,p_entityTAType VARCHAR2
                        ,p_primaryTA VARCHAR2
                        ,p_description VARCHAR2
                        ,p_message OUT VARCHAR2);
PROCEDURE TMC_MAINTAIN_STORES(p_message OUT VARCHAR2
                            ,p_store_name IN VARCHAR2
                            ,p_longitude IN NUMBER
                            ,p_latitude IN NUMBER
                            ,p_address IN VARCHAR2
                            ,p_city IN VARCHAR2
                            ,p_state IN VARCHAR2
                            ,p_country IN VARCHAR2
                            ,p_zip_code IN VARCHAR2
                            ,p_brand IN VARCHAR2
                            );
PROCEDURE TMC_CREATE_STORES(p_message OUT VARCHAR2
                        ,p_Store_name IN VARCHAR2
                        ,p_longitude IN NUMBER
                        ,p_latitude IN NUMBER
                        ,p_address  IN VARCHAR2
                        ,p_city  IN VARCHAR2
                        ,p_state  IN VARCHAR2
                        ,p_country  IN VARCHAR2
                        ,p_zip_code  IN VARCHAR2
                        ,p_brand IN NUMBER
                        ,p_storeID OUT NUMBER
                        ,p_CustomJson IN VARCHAR2 DEFAULT NULL
                        );
Procedure TMCS_CREATE_STORE_TA(p_STORE_id  IN NUMBER
                               ,p_brand IN VARCHAR2
                               ,p_user_name IN VARCHAR2
                               ,p_trade_area_type IN VARCHAR2
                               ,p_description IN VARCHAR2
                               ,p_ring_miles IN VARCHAR2
                               ,p_message OUT VARCHAR2);
Procedure TMCS_CALL_OPTIMIZATION(P_SEND_REQUEST VARCHAR2,
                                 p_message out VARCHAR2);
END;
/

