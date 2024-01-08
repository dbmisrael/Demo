CREATE OR REPLACE EDITIONABLE PACKAGE BODY MIGRATE_CLIENT_MAP_MENU_PROD
AS

-- multiprd.TANGOANALYTICS.COM     MULTI PROD
-- DNKNPRD.TANGOANALYTICS.COM      DUKB  PROD
-- yumprd.TANGOANALYTICS.COM       YUMB  PROD
-- CUSHPRD                         CUSH  PROD

-- General DBLINK for all TEST instances
-- PROD   ALL ENVIRONMENTS
PROCEDURE MIGRATE_MAP_CONFIG(p_CLIENT_ID NUMBER
                            ,P_FUNCTIONALITY VARCHAR2 DEFAULT 'N') AS
l_start number default dbms_utility.get_time;
BEGIN
    Begin

        delete TMCS_GIS_CLIENT_SETUP@PROD
        where TMC_BRAND = p_CLIENT_ID;

        delete TMCS_GIS_CLIENT_COUNTRY_SETUP@PROD
        where CLIENT_ID = p_CLIENT_ID;

        If P_FUNCTIONALITY = 'Y' then

            delete TMCS_GIS_FUNCTIONALITY_SETUP@PROD
            where client_id = p_CLIENT_ID and NVL(profiles,'#') = 'MAP';

            insert into TMCS_GIS_FUNCTIONALITY_SETUP@PROD
            select * from TMCS_GIS_FUNCTIONALITY_SETUP
            where client_id = p_CLIENT_ID
             and NVL(profiles,'#') = 'MAP';

        END if;

        delete TMCS_CLIENT_TA_CONFIG@PROD
        where client_id = p_CLIENT_ID;

        delete TMCS_TA_P2P_DT_RULES@PROD
        where client_id = p_CLIENT_ID;

        delete TMCS_TA_SIS_STORE_TRUC_RULES@PROD
        where client_id = p_CLIENT_ID;

        delete TMCS_SF_DECAY_CURVES@PROD
        where client_id = p_CLIENT_ID;

        delete tmcs_client_key_metrics@PROD
        where client_ID = p_CLIENT_ID;

        delete TMCS_MODEL_CALC_TEMPLATES@PROD
        where TEMPLATE_ID in (Select TEMPLATE_ID from TMCS_MODEL_TEMPLATES@PROD           Where client_ID = p_CLIENT_ID);

        delete TMCS_MODEL_DEMOG_TEMPLATES@PROD
        where TEMPLATE_ID in (Select TEMPLATE_ID from TMCS_MODEL_TEMPLATES@PROD           Where client_ID = p_CLIENT_ID);

        delete TMCS_MODEL_TEMPLATES@PROD
        where client_id = p_CLIENT_ID;

        delete TMCS_MAP_FORMS_CONFIG@PROD
        where CLIENT_ID = p_CLIENT_ID;

        DELETE FROM TMCS_DEMO_RPT_VINTAGE@PROD
        WHERE client_id = p_CLIENT_ID ;

        delete TMCS_GIS_ERROR_CODES@PROD
        where client_id = p_CLIENT_ID;

        insert into TMCS_GIS_CLIENT_SETUP@PROD
        select * from TMCS_GIS_CLIENT_SETUP
        where TMC_BRAND = p_CLIENT_ID;

        insert into TMCS_GIS_CLIENT_COUNTRY_SETUP@PROD
        select * from TMCS_GIS_CLIENT_COUNTRY_SETUP
        where client_id = p_CLIENT_ID;

        insert into TMCS_CLIENT_TA_CONFIG@PROD
        select * from TMCS_CLIENT_TA_CONFIG
        where client_id = p_CLIENT_ID;

        insert into TMCS_TA_P2P_DT_RULES@PROD
        select * from TMCS_TA_P2P_DT_RULES
        where client_id = p_CLIENT_ID;

        insert into TMCS_TA_SIS_STORE_TRUC_RULES@PROD
        select * from TMCS_TA_SIS_STORE_TRUC_RULES
        where client_id = p_CLIENT_ID;

        insert into TMCS_SF_DECAY_CURVES@PROD
        select * from TMCS_SF_DECAY_CURVES
        where client_id = p_CLIENT_ID;

        insert into tmcs_client_key_metrics@PROD
        select * from tmcs_client_key_metrics
        where client_id = p_CLIENT_ID;

        insert into TMCS_MODEL_TEMPLATES@PROD
        select * from TMCS_MODEL_TEMPLATES
        where client_id = p_CLIENT_ID;

        insert into TMCS_MODEL_DEMOG_TEMPLATES@PROD
        select * from TMCS_MODEL_DEMOG_TEMPLATES
        where TEMPLATE_ID in (Select TEMPLATE_ID from TMCS_MODEL_TEMPLATES@PROD Where client_ID = p_CLIENT_ID);

        insert into TMCS_MODEL_CALC_TEMPLATES@PROD
        select * from TMCS_MODEL_CALC_TEMPLATES
        where TEMPLATE_ID in (Select TEMPLATE_ID from TMCS_MODEL_TEMPLATES@PROD Where client_ID = p_CLIENT_ID);

        insert into TMCS_MAP_FORMS_CONFIG@PROD
        select * from TMCS_MAP_FORMS_CONFIG
        where CLIENT_ID = p_CLIENT_ID;

        INSERT INTO TMCS_DEMO_RPT_VINTAGE@PROD
        SELECT * FROM tmcs.TMCS_DEMO_RPT_VINTAGE
        WHERE client_id = p_CLIENT_ID;


        insert into TMCS_GIS_ERROR_CODES@PROD
        select * from TMCS_GIS_ERROR_CODES
        where client_id = p_CLIENT_ID;
        Commit;
        dbms_output.put_line ('Client ' || p_CLIENT_ID ||' Finished  migration in  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );
--        TMCS_GIS_SLM_PKG.TMCS_INSERT_ERROR_LOG('Migrate Config'
--                                            , 'MIGRATE_MAP_CONFIG_MULTITEST'
--                                            , '1'
--                                            , 'Client ' || p_CLIENT_ID
--                                            , 'Client ' || p_CLIENT_ID ||' Finished  migration in  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...'
--                                            , p_CLIENT_ID
--                                            , ''
--                                            );

    Exception
        When Others then
        dbms_output.put_line('Client ' || p_CLIENT_ID || ' - ' || sqlerrm );
--        TMCS_GIS_SLM_PKG.TMCS_INSERT_ERROR_LOG('Migrate Config'
--                                                , 'MIGRATE_MAP_CONFIG_MULTITEST'
--                                                , '99'
--                                                , 'Client ' || p_CLIENT_ID
--                                                , sqlerrm
--                                                , p_CLIENT_ID
--                                                , ''
--                                                );
        rollback;
    End;

EXCEPTION
    When others then
    dbms_output.put_line('Client ' || p_CLIENT_ID || ' - ' || sqlerrm );
--    TMCS_GIS_SLM_PKG.TMCS_INSERT_ERROR_LOG('Migrate Config'
--                                            , 'MIGRATE_MAP_CONFIG_MULTITEST'
--                                            , '99'
--                                            , 'Client ' || p_CLIENT_ID
--                                            , sqlerrm
--                                            , p_CLIENT_ID
--                                            , ''
--                                            );
End MIGRATE_MAP_CONFIG;
PROCEDURE MIGRATE_MAP_MENU(p_CLIENT_ID NUMBER) AS
l_start number default dbms_utility.get_time;
BEGIN
    Begin

        Delete from TMCS_MAP_MENU_HEADERS@PROD where CLIENT_ID = p_CLIENT_ID
        and MENU_HEADER_ID not in (Select MENU_HEADER_ID from TMCS_MAP_MENU_HEADERS where CLIENT_ID = p_CLIENT_ID);

        dbms_output.put_line('Client ' || p_CLIENT_ID|| ' - ' || sql%rowcount || ' rows affected...' );

        dbms_output.put_line ('Client ' || p_CLIENT_ID ||' Finished  Delete in  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

--        TMCS_GIS_SLM_PKG.TMCS_INSERT_ERROR_LOG('Migrate Menu'
--                                            , 'MIGRATE_MAP_MENU_MULTIPROD'
--                                            , '1'
--                                            , 'Client ' || p_CLIENT_ID|| ' - ' || sql%rowcount || ' rows affected...'
--                                            , 'Client ' || p_CLIENT_ID ||' Fnished  Delete in  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...'
--                                            , p_CLIENT_ID
--                                            , ''
--                                            );
        Commit;

        MERGE INTO TMCS_MAP_MENU_HEADERS@PROD  DEST
         USING (SELECT MENU_HEADER_ID,
                       MENU_NAME,
                       PARENT_ID,
                       ORG_ID,
                       CLIENT_ID,
                       BRAND_ID,
                       CREATION_DATE,
                       CREATED_BY,
                       LAST_UPDATE_DATE,
                       LAST_UPDATED_BY,
                       LAST_UPDATE_LOGIN,
                       OBJECT_VERSION_NUMBER,
                       APP_ROLE_NAME,
                       MENU_DESCRIPTION,
                       MENU_ID,
                       MENU_CATEGORY,
                       JSON_STRING,
                       BU_ID,
                       MENU_SEQUENCE,
                       RIGHTCLICK,
                       COUNTRY,
                       ENABLED,
                       TEMP_PARENT_ID
                  FROM TMCS_MAP_MENU_HEADERS
                 WHERE CLIENT_ID  in (p_CLIENT_ID)
                 order by 1 ) SRC
        ON (DEST.MENU_HEADER_ID = SRC.MENU_HEADER_ID)
        WHEN MATCHED
        THEN
           UPDATE SET
                      DEST.MENU_NAME                           = SRC.MENU_NAME,
                      DEST.PARENT_ID                            = SRC.PARENT_ID,
                      DEST.ORG_ID                                 = SRC.ORG_ID,
                      DEST.CLIENT_ID                             = SRC.CLIENT_ID,
                      DEST.BRAND_ID                             = SRC.BRAND_ID,
                      DEST.CREATION_DATE                    = SRC.CREATION_DATE,
                      DEST.CREATED_BY                         = SRC.CREATED_BY,
                      DEST.LAST_UPDATE_DATE               = SRC.LAST_UPDATE_DATE,
                      DEST.LAST_UPDATED_BY                = SRC.LAST_UPDATED_BY,
                      DEST.LAST_UPDATE_LOGIN             = SRC.LAST_UPDATE_LOGIN,
                      DEST.OBJECT_VERSION_NUMBER     = SRC.OBJECT_VERSION_NUMBER,
                      DEST.APP_ROLE_NAME                    = SRC.APP_ROLE_NAME,
                      DEST.MENU_DESCRIPTION               = SRC.MENU_DESCRIPTION,
                      DEST.MENU_ID                                = SRC.MENU_ID,
                      DEST.MENU_CATEGORY                    = SRC.MENU_CATEGORY,
                      DEST.JSON_STRING                         = SRC.JSON_STRING,
                      DEST.BU_ID                                    = SRC.BU_ID,
                      DEST.MENU_SEQUENCE                    = SRC.MENU_SEQUENCE,
                      DEST.RIGHTCLICK                           = SRC.RIGHTCLICK,
                      DEST.COUNTRY                                = SRC.COUNTRY,
                      DEST.ENABLED                                 = SRC.ENABLED,
                      DEST.TEMP_PARENT_ID                     = SRC.TEMP_PARENT_ID
        WHEN NOT MATCHED
        THEN
           INSERT
               (DEST.MENU_HEADER_ID ,DEST.MENU_NAME ,DEST.PARENT_ID ,DEST.ORG_ID ,DEST.CLIENT_ID ,DEST.BRAND_ID ,DEST.CREATION_DATE ,DEST.CREATED_BY
                ,DEST.LAST_UPDATE_DATE ,DEST.LAST_UPDATED_BY ,DEST.LAST_UPDATE_LOGIN ,DEST.OBJECT_VERSION_NUMBER ,DEST.APP_ROLE_NAME ,DEST.MENU_DESCRIPTION
                ,DEST.MENU_ID ,DEST.MENU_CATEGORY ,DEST.JSON_STRING ,DEST.BU_ID ,DEST.MENU_SEQUENCE ,DEST.RIGHTCLICK ,DEST.COUNTRY ,DEST.ENABLED ,DEST.TEMP_PARENT_ID)
            VALUES
               (SRC.MENU_HEADER_ID ,SRC.MENU_NAME ,SRC.PARENT_ID ,SRC.ORG_ID ,SRC.CLIENT_ID ,SRC.BRAND_ID ,SRC.CREATION_DATE ,SRC.CREATED_BY
               ,SRC.LAST_UPDATE_DATE ,SRC.LAST_UPDATED_BY ,SRC.LAST_UPDATE_LOGIN ,SRC.OBJECT_VERSION_NUMBER ,SRC.APP_ROLE_NAME ,SRC.MENU_DESCRIPTION
               ,SRC.MENU_ID ,SRC.MENU_CATEGORY ,SRC.JSON_STRING ,SRC.BU_ID ,SRC.MENU_SEQUENCE ,SRC.RIGHTCLICK ,SRC.COUNTRY ,SRC.ENABLED ,SRC.TEMP_PARENT_ID);


             dbms_output.put_line('Client ' || p_CLIENT_ID|| ' - ' || sql%rowcount || ' rows affected...' );

            dbms_output.put_line ('Client ' || p_CLIENT_ID ||' Finished  migration in  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

--             TMCS_GIS_SLM_PKG.TMCS_INSERT_ERROR_LOG('Migrate Menu'
--                                                    , 'MIGRATE_MAP_MENU_MULTIPROD'
--                                                    , '1'
--                                                    , 'Client ' || p_CLIENT_ID|| ' - ' || sql%rowcount || ' rows affected...'
--                                                    , 'Client ' || p_CLIENT_ID ||' Finished  migration in  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...'
--                                                    , p_CLIENT_ID
--                                                    , ''
--                                                    );
        Commit;
    Exception
        When Others then
        dbms_output.put_line('Client ' || p_CLIENT_ID || ' - ' || sqlerrm );
--        TMCS_GIS_SLM_PKG.TMCS_INSERT_ERROR_LOG('Migrate Menu'
--                                                    , 'MIGRATE_MAP_MENU_MULTIPROD'
--                                                    , '99'
--                                                    , 'Client ' || p_CLIENT_ID|| ' - ' || sql%rowcount || ' rows affected...'
--                                                    , sqlerrm
--                                                    , p_CLIENT_ID
--                                                    , ''
--                                                    );
    End;

EXCEPTION
    When others then
    dbms_output.put_line('Client ' || p_CLIENT_ID || ' - ' || sqlerrm );
--    TMCS_GIS_SLM_PKG.TMCS_INSERT_ERROR_LOG('Migrate Menu'
--                                                        , 'MIGRATE_MAP_MENU_MULTIPROD'
--                                                        , '99'
--                                                        , 'Client ' || p_CLIENT_ID
--                                                        , sqlerrm
--                                                        , p_CLIENT_ID
--                                                        , ''
--                                                        );
End MIGRATE_MAP_MENU;
Procedure MIGRATE_COMP_CONFIG(p_CLIENT_ID NUMBER)
AS
l_start number default dbms_utility.get_time;
p_clients style  := style();
Begin

    p_clients      := style(p_CLIENT_ID); -- Provide all Client IDs that needs to be migrated.

        Begin
            Delete from TMCS_ALL_COMPETITORS_CONFIG@PROD where CLIENT_ID = p_CLIENT_ID
            and CONFIG_ID not in (Select CONFIG_ID from TMCS_ALL_COMPETITORS_CONFIG where CLIENT_ID = p_CLIENT_ID);

            dbms_output.put_line('Client ' || p_CLIENT_ID|| ' - ' || sql%rowcount || ' rows affected...' );

            dbms_output.put_line ('Client ' || p_CLIENT_ID ||' Finished  Delete in  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

            MERGE INTO TMCS_ALL_COMPETITORS_CONFIG@PROD  DEST
             USING (SELECT CONFIG_ID
                           ,CLIENT_ID
                           ,BRAND_ID
                           ,COUNTRY
                           ,IS_ENABLE
                           ,CHAIN_ID
                           ,GROUP1_CODE
                           ,GROUP2_CODE
                           ,GROUP3_CODE
                           ,GROUP4_CODE
                           ,CREATION_DATE
                           ,CREATED_BY
                           ,LAST_UPDATE_DATE
                           ,LAST_UPDATED_BY
                           ,LAST_UPDATE_LOGIN
                           ,OBJECT_VERSION_NUMBER
                      FROM TMCS_ALL_COMPETITORS_CONFIG
                     WHERE CLIENT_ID  in (p_CLIENT_ID)
                     order by 1 ) SRC
            ON (DEST.CONFIG_ID = SRC.CONFIG_ID)
            WHEN MATCHED
            THEN
               UPDATE SET
                         DEST.CLIENT_ID              =  SRC.CLIENT_ID
                        ,DEST.BRAND_ID               =  SRC.BRAND_ID
                        ,DEST.COUNTRY                =  SRC.COUNTRY
                        ,DEST.IS_ENABLE              =  SRC.IS_ENABLE
                        ,DEST.CHAIN_ID               =  SRC.CHAIN_ID
                        ,DEST.GROUP1_CODE            =  SRC.GROUP1_CODE
                        ,DEST.GROUP2_CODE            =  SRC.GROUP2_CODE
                        ,DEST.GROUP3_CODE            =  SRC.GROUP3_CODE
                        ,DEST.GROUP4_CODE            =  SRC.GROUP4_CODE
                        ,DEST.CREATION_DATE          =  SRC.CREATION_DATE
                        ,DEST.CREATED_BY             =  SRC.CREATED_BY
                        ,DEST.LAST_UPDATE_DATE       =  SRC.LAST_UPDATE_DATE
                        ,DEST.LAST_UPDATED_BY        =  SRC.LAST_UPDATED_BY
                        ,DEST.LAST_UPDATE_LOGIN      =  SRC.LAST_UPDATE_LOGIN
                        ,DEST.OBJECT_VERSION_NUMBER  =  SRC.OBJECT_VERSION_NUMBER
            WHEN NOT MATCHED
            THEN
               INSERT
                   (DEST.CONFIG_ID ,DEST.CLIENT_ID ,DEST.BRAND_ID ,DEST.COUNTRY ,DEST.IS_ENABLE ,DEST.CHAIN_ID ,DEST.GROUP1_CODE ,DEST.GROUP2_CODE ,DEST.GROUP3_CODE ,DEST.GROUP4_CODE ,DEST.CREATION_DATE
                   ,DEST.CREATED_BY ,DEST.LAST_UPDATE_DATE ,DEST.LAST_UPDATED_BY ,DEST.LAST_UPDATE_LOGIN ,DEST.OBJECT_VERSION_NUMBER)
                VALUES
                   (SRC.CONFIG_ID ,SRC.CLIENT_ID ,SRC.BRAND_ID ,SRC.COUNTRY ,SRC.IS_ENABLE ,SRC.CHAIN_ID ,SRC.GROUP1_CODE ,SRC.GROUP2_CODE ,SRC.GROUP3_CODE ,SRC.GROUP4_CODE ,SRC.CREATION_DATE ,SRC.CREATED_BY
                   ,SRC.LAST_UPDATE_DATE ,SRC.LAST_UPDATED_BY ,SRC.LAST_UPDATE_LOGIN ,SRC.OBJECT_VERSION_NUMBER);


                 dbms_output.put_line('Client ' || p_CLIENT_ID|| ' - ' || sql%rowcount || ' rows affected...' );

                dbms_output.put_line ('Client ' || p_CLIENT_ID ||' Finished  migration in  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

                Commit;
        Exception
            When Others then
            dbms_output.put_line('Client ' || p_CLIENT_ID || ' - ' || sqlerrm );
        End;


Exception
    When others then
    TMCS_GIS_SLM_PKG.TMCS_INSERT_ERROR_LOG('Migrate Config'
                                        , 'MIGRATE_COMP_CONFIG'
                                        , '99'
                                        , 'CLIENT_ID '|| TMCS_SEC_CTX.GET_CLIENT_ID || ' -- ' || 'BU_ID ' || TMCS_SEC_CTX.get_default_bu_id
                                        , sqlerrm
                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                        , TMCS_SEC_CTX.GET_USER
                                            );

End;
END MIGRATE_CLIENT_MAP_MENU_PROD;
/

