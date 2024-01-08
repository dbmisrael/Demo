CREATE OR REPLACE EDITIONABLE PACKAGE BODY TMCS_GIS_SLM_PKG_VN
AS
 PROCEDURE TMC_VERSION_TRADEAREA
                                (p_message OUT NUMBER
                                ,p_site_id IN NUMBER
                                ,p_new_current_trade_area_id IN NUMBER
                                ,p_brand in VARCHAR2
                                )AS
l_tatype VARCHAR2(320);
 BEGIN

        Select TA_TYPE
        into l_tatype
        from tmcs_tradeareas_sites
        where tradearea_id = p_new_current_trade_area_id;


       UPDATE  tmcs_tradeareas_sites
       SET current_status='FALSE'
       , Last_Update_Date = sysdate
       , Last_Updated_By = -1--fnd_global.user_id
       , PRIMARY_FLAG = 'N'
       WHERE site_id = p_site_id
       AND current_status = 'TRUE'
       and TA_TYPE = l_tatype;

       UPDATE  tmcs_tradeareas_sites
       SET current_status='TRUE'
       , Last_Update_Date = sysdate
       , Last_Updated_By = -1--fnd_global.user_id
       , PRIMARY_FLAG = 'Y'
       WHERE tradearea_id = p_new_current_trade_area_id;

       COMMIT;
       p_message := 1;

 EXCEPTION
     WHEN OTHERS THEN
        p_message := 99;
        rollback;
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                            , 'TMC_MAINTAIN_SITES'
                                                            , '99'
                                                            ,  'General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
 END;
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
                                ) AS
l_siteID NUMBER;
Begin

    TMC_CREATE_SITES
                                (p_message
                                ,p_dma
                                ,p_target_id
                                ,p_site_name
                                ,p_longitude
                                ,p_latitude
                                ,p_address
                                ,p_city
                                ,p_state
                                ,p_country
                                ,p_zip_code
                                ,p_trade_area_type
                                ,p_ring_miles
                                ,p_description
                                ,p_StoreType
                                ,p_drive_thru
                                ,p_brand
                                ,p_user_name
--                                ,p_geometry
--                                ,p_drive_time_coordinates
                                ,l_siteID
                                ,p_scID
                                ,null
                                ,null
                                );

    dbms_output.put_line('Site is created with SiteID ' || l_siteID);
    dbms_output.put_line('p_message output ' || p_message);

Exception
    When others then
       p_message := 99;   -- General ERROR
        rollback;
     dbms_output.put_line('SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                            , 'TMC_MAINTAIN_SITES'
                                                            , '99'
                                                            ,  'General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
End;
 PROCEDURE TMC_CREATE_SITES
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
--                                ,p_geometry IN MDSYS.SDO_GEOMETRY
--                                ,p_drive_time_coordinates IN MDSYS.SDO_GEOMETRY DEFAULT NULL
                                ,p_siteID out NUMBER
                                ,p_scID IN VARCHAR2 DEFAULT NULL
                                ,p_BatchID NUMBER Default NULL
                                ,p_BatchDetailID NUMBER Default NULL
                                ,p_CustomJson VARCHAR2 Default NULL
                                ) AS
l_error VARCHAR2(32000);
 l_site_id NUMBER;
 l_CBSA NUMBER ;
 l_STORE  NUMBER;
 plsql_block   VARCHAR2(500);
 l_package     VARCHAR2(500);
 l_StoreType   VARCHAR2(55);
 l_TMCbrand    VARCHAR2(10);
 l_Client_ID  NUMBER;
 l_params   varchar2(4000);
 l_distance NUMBER;
 l_tempRegionID NUMBER;
 l_regionID NUMBER;
l_message VARCHAR2(320);
p_geometry MDSYS.SDO_GEOMETRY ;
p_drive_time_coordinates  MDSYS.SDO_GEOMETRY ;
l_siteNumberUpdate VARCHAR2(320);
  BEGIN

--       l_params := 'p_dma : '||p_dma ||
--                                '   p_target_id : '||p_target_id ||
--                                '   p_site_name : '||p_site_name ||
--                                '   p_longitude : '||p_longitude ||
--                                '   p_latitude : '||p_latitude ||
--                                '   p_address : '||p_address ||
--                                '   p_city : '||p_city ||
--                                '   p_state : '||p_state ||
--                                '   p_country : '||p_country ||
--                                '   p_zip_code : '||p_zip_code ||
--                                '   p_trade_area_type : '||p_trade_area_type ||
--                                '   p_ring_miles : '||p_ring_miles ||
--                                '   p_description : '||p_description ||
--                                '   p_StoreType : '||p_StoreType ||
--                                '   p_brand : '||p_brand ||
--                                '   p_user_name : '||p_user_name;

--   insert into tmcs_proc_log (procedure_name, params)
--   values ('TMC_MAINTAIN_SITES', l_params);
--   commit;
   p_geometry := TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(SDO_GEOMETRY(2001,8307,SDO_POINT_TYPE(p_longitude,p_latitude,null),null,null));
   p_drive_time_coordinates := null;

  l_site_id :=TMCS_SITE_S.nextval;
  p_siteID := l_site_id;
  dbms_output.put_line('l_SITE_ID: '||l_site_id);

--  tmcs_sec_ctx. set_context(p_user_name);
   BEGIN

        Select G_Client_ID
        into l_Client_ID
        from tmcs_glob_brand_access_tmp
        where G_Brand_ID = p_brand;

    EXCEPTION

        When no_data_found then
         p_message := 15; --User Brand Security Not Set
         l_error := sqlerrm;
         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                            , 'TMC_MAINTAIN_SITES'
                                                            , '15'
                                                            , 'Security Not Set Properly'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
    END;

  dbms_output.put_line('l_TMCbrand: '||l_Client_ID);
    If p_message is null then

       dbms_OUTPUT.Put_line('PMESSAGE IS NULL');

        BEGIN

           Select TMC_PACKAGE
           into l_package
           from TMCS_GIS_CLIENT_SETUP
           where UPPER(TMC_Brand) =  l_Client_ID
           and UPPER(TMC_Functionality) = 'GET_CLASS';

           IF l_package is not null then
                plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';
                EXECUTE IMMEDIATE plsql_block using p_geometry,OUT l_CBSA,OUT l_STORE;
           End if;

           --dbms_output.put_line(l_package||'l_text  --> ' || plsql_block);



        EXCEPTION
           when others then null;
           dbms_output.put_line('GET_CLASS SQL ERROR  --> '|| sqlerrm);
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                            , 'TMC_MAINTAIN_SITES'
                                                            , '6'
                                                            ,  'GET_CLASS  ' || ' Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
        END;

        Begin
              Select REGION_ID
              into l_regionID
              from TMCS_REGIONS a
              where SDO_CONTAINS(a.geometry, p_geometry) = 'TRUE'
              and UPPER(COUNTRY) = UPPER(TMCS_SEC_CTX.GET_COUNTRY_CODE) ;
        Exception
            When others then

                Begin
                    Select SDO_NN_DISTANCE(1), REGION_ID
                    into l_distance,l_tempRegionID
                    from TMCS_REGIONS
                    where SDO_NN(geometry,p_geometry,'distance = 10 unit = mile',1) = 'TRUE'
                    and UPPER(COUNTRY) = UPPER(TMCS_SEC_CTX.GET_COUNTRY_CODE);

                    if l_distance <= 10 then
                        l_regionID := l_tempRegionID;

                    Else
                        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                                , 'TMC_MAINTAIN_SITES'
                                                                , '7'
                                                                , 'Region not Found even within 10 miles'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
                    End if;

                Exception

                  When others then
                  dbms_OUTPUT.Put_line('Get Region Error : -->  '||sqlerrm);
                  l_error := sqlerrm;

                 TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                                , 'TMC_MAINTAIN_SITES'
                                                                , '7'
                                                                ,  'Region ID not Found'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
                End;

        End;

        dbms_OUTPUT.Put_line(l_regionID);

        if l_regionID is not null then

               Begin

                       INSERT INTO TMCS_SITES_B (site_id
                                              ,dma
                                              ,target_id
                                              ,site_name
                                              ,longitude
                                              ,latitude
                                              ,address
                                              ,city
                                              ,state
                                              ,country
                                              ,zip_code
                                              ,creation_date
                                              ,created_by
                                              ,last_update_date
                                              ,last_updated_by
                                              ,status
                                              ,CBSA_CLASS
                                              ,STORE_CLASS
                                              ,SITE_TYPE
                                              ,C_EXT_ATTR27 -- Drivethru
                                              ,BRAND_ID
                                              ,Client_ID
                                              ,geometry
                                              ,ORG_ID
--                                              ,SITE_NUMBER
                                              ,SC_ID
                                              ,BATCH_ID
                                              ,BATCH_DETAIL_ID
                                              )
                                        VALUES (l_site_id
                                              ,p_dma
                                              ,p_target_id
                                              ,p_site_name
                                              ,p_longitude
                                              ,p_latitude
                                              ,p_address
                                              ,p_city
                                              ,p_state
                                              ,TMCS_SEC_CTX.GET_COUNTRY_CODE()
                                              ,p_zip_code
                                              , sysdate
                                              , p_user_name
                       --                      ,-1
                                              , sysdate
                     --                       ,-1
                                             , p_user_name
                                              , TMCS_GET_DEFAULT_STATUS('SITE')
                                              ,l_CBSA
                                              ,l_STORE
                                              ,p_StoreType
                                              ,p_drive_thru
                                              ,p_brand
                                              ,l_Client_ID
                                              , p_geometry
                                              ,l_regionID
--                                              ,l_site_id
                                              ,p_scID
                                              ,p_BatchID
                                              ,p_BatchDetailID
                                                );

--                             INSERT INTO TMCS_SITES_B_DETAIL (site_id
--                                              ,creation_date
--                                              ,created_by
--                                              ,last_update_date
--                                              ,last_updated_by
--                                              ,BRAND_ID
--                                              ,Client_ID
--                                              ,ORG_ID
--                                              )
--                                        VALUES (l_site_id
--                                              , sysdate
--                                              , p_user_name
--                       --                      ,-1
--                                              , sysdate
--                     --                       ,-1
--                                             , p_user_name
--                                              ,p_brand
--                                              ,l_Client_ID
--                                              ,l_regionID);


               EXCEPTION
                    when others then null;
                    dbms_output.put_line('SQL ERROR ' || sqlerrm);
                    p_message := 8; -- Duplicate SiteName
                    l_error := sqlerrm; -- Error Code
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                                , 'TMC_MAINTAIN_SITES'
                                                                , '8'
                                                                ,  'Duplicate SiteName  '
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
               END;

               If p_message is null then

                    BEGIN
                           TMCS_UPDATE_STD_ATTRIBUTES(p_message
                                                                   ,'SITE'
                                                                   ,l_site_id
                                                                   , p_geometry);

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 14; --Error while updating Standard Attributes
                            l_error := sqlerrm;
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                            , 'TMC_MAINTAIN_SITES'
                                                            , '14'
                                                            ,  'STANDARD_ATTR_UPDATE ' || ' Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
                    END;

                    BEGIN
                           TMCS_SET_ENTITY_DEFAULTS(p_message
                                                                   ,'SITE'
                                                                   ,l_site_id);

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 14; --Error while updating Standard Attributes
                            l_error := sqlerrm;
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                            , 'TMC_MAINTAIN_SITES'
                                                            , '14'
                                                            ,  'Set Entity Defaults ' || ' Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
                    END;

                    BEGIN
                           TMCS_UPDATE_CUST_ATTR(p_message
                                                                   ,'SITE'
                                                                   ,l_site_id
                                                                   ,p_CustomJson);

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 13; --Error while updating Standard Attributes
                            l_error := sqlerrm;
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                            , 'TMC_MAINTAIN_SITES'
                                                            , '13'
                                                            ,  'CUSTOM_ATTR_UPDATE ' || ' Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
                    END;

                    If p_trade_area_type = 'PREDEFINED_RING'  and p_message is  null then

--                        Select TMC_PACKAGE
--                        into l_package
--                        from TMCS_GIS_CLIENT_SETUP
--                        where UPPER(TMC_Brand) = l_Client_ID
--                        and UPPER(TMC_Functionality) = 'GET_SITE_TRADEAREA';
--                        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f, :g); END;';
--
--                        dbms_output.put_line('l_text  --> ' || plsql_block);
--
--                        EXECUTE IMMEDIATE plsql_block using l_site_id,p_brand, p_user_name, p_trade_area_type,p_description,p_ring_miles,OUT p_message;

                                 TMCS_CREATE_SITE_TA(l_site_id
                                                   ,p_brand
                                                   ,p_user_name
                                                   ,p_trade_area_type
                                                   ,p_description
                                                   ,p_ring_miles
                                                   ,p_message );


                    ELSIF p_trade_area_type != 'PREDEFINED_RING'  and p_message is  null then

                               TMC_MAINTAIN_TRADEAREAS (p_message
                                                       ,l_site_id
                                                       ,p_user_name
                                                       ,p_trade_area_type
                                                       ,p_description
                                                       ,''
                                                       ,p_drive_time_coordinates
                                     );
                    END IF;

                     dbms_output.put_line('p_message before SITE_ENCROACHMENT' || p_message);
                    If p_message in (1,60)  then
--                        Select TMC_PACKAGE
--                        into l_package
--                        from TMCS_GIS_CLIENT_SETUP
--                        where UPPER(TMC_Brand) =  l_Client_ID
--                        and UPPER(TMC_Functionality) = 'SITE_ENCROACHMENT';
--                        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c ); END;';
--
--                          dbms_output.put_line('plsql_block  --> ' || plsql_block);
--                        if l_package is not null then
--                              EXECUTE IMMEDIATE plsql_block using l_site_id,'SITE',OUT p_message;
--                        Else
--                          p_message := 1;
--                        End if;
                        l_message := p_message;
                        TMCS_UPDATE_ENCROACHMENT(p_message ,l_error ,'SITE',l_site_id);

                        If p_message = 1 then
                            p_message := l_message;
                        End if;

                    else
                        rollback;
                    end if;

               Else
                   p_message := 8;
                   TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                            , 'TMC_MAINTAIN_SITES'
                                                            , '8'
                                                            ,  'Duplicate SiteName  '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
               End if;

        Else
            p_message := 15;
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                                        , 'TMC_MAINTAIN_SITES'
                                                                        , '15'
                                                                        , 'Security Not Set Properly'
                                                                        , SQLERRM
                                                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                        , p_user_name
                                                                        );
         End if;
    END IF;

  dbms_output.put_line('p_message' || p_message);



     If p_message in (1,60) then
         COMMIT;
         /*Asynchronous call so doing it after commit*/



         BEGIN
            Select TMC_PACKAGE,GET_STATUS
            into l_package,l_siteNumberUpdate
            from TMCS_GIS_CLIENT_SETUP
            where UPPER(TMC_Brand) = l_Client_ID
            and UPPER(TMC_Functionality) = 'GET_SITE_NUMBER';


            plsql_block := 'BEGIN '||l_package||'(:a); END;';

         EXCEPTION
            when no_data_found then null;
            l_package:=null;
            plsql_block := NULL;
            l_siteNumberUpdate := NULL;
            when too_many_rows then null;
            l_package := null;
            plsql_block := NULL;
            l_siteNumberUpdate := NULL;
         END;

         dbms_output.put_line('l_text  --> ' || plsql_block);

         if l_package is not null then

            EXECUTE IMMEDIATE plsql_block using l_site_id;

         Else
                  /*
                  GET_STATUS(l_siteNumberUpdate) column is being used to decide if the siteID needs to be populated to SITE Number. If Get_STATUS is  equal to 'Y' or NULL it will update
                */

                if NVL(l_siteNumberUpdate,'Y') = 'Y' then

                    Begin
                       update tmcs_sites_b
                       set    SITE_NUMBER = l_site_id
                       where  SITE_ID = l_site_id;
                    End;

                Else
                 Null;

                End if;



            commit;
--            p_message := 1;
         End if;

     else
        rollback;
        --null;
     end if;

 EXCEPTION
     WHEN OTHERS THEN
        p_message := 99;   -- General ERROR
        rollback;
     dbms_output.put_line('SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                            , 'TMC_MAINTAIN_SITES'
                                                            , '99'
                                                            ,  'General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
 END;
 PROCEDURE TMCS_GIS_TRADEAREA_EJOB(
                                p_siteID IN NUMBER ,
                                p_BRAND  IN VARCHAR2 ,
                                p_user_name VARCHAR2 ,
                                p_trade_area_type IN VARCHAR2 ,
                                p_description     IN VARCHAR2 ,
                                p_ring_miles      IN NUMBER ,
                                CLIENT_ID NUMBER,
                                COUNTRY VARCHAR2
                                )AS
l_package VARCHAR2(320);
p_message  VARCHAR2(320);
plsql_block  VARCHAR2(320);
l_brandID NUMBER;
BEGIN

    Select BRAND_ID
    into l_brandID
    from TMCS_SITES_B
    where SITE_ID = p_siteID;

--       tmcs_general_pkg. TMCS_SEC_CTX_DYNAMIC(P_USER_NAME,COUNTRY,CLIENT_ID,l_brandID);

      Begin

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) = CLIENT_ID
        and UPPER(TMC_Functionality) = 'EXECUTE_SITE_JOB_TA';

          IF l_package is not null then
             plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f, :g); END;';
             dbms_output.put_line('l_text  --> ' || plsql_block);
              EXECUTE IMMEDIATE plsql_block using p_siteID,p_brand, p_user_name, p_trade_area_type,p_description,p_ring_miles,OUT p_message;
          End if;

      Exception
          when others then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                p_message := 17; --Error while updating Standard Attributes
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                , 'TMCS_GIS_TRADEAREA_EJOB'
                                                ,p_message
                                                ,  'Setup not complete for running the Site TA job'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
      End;

      if P_MESSAGE in (1,60)  then

        update TMCS_SITES_B
        set
        C_EXT_ATTR19 = TMCS_GIS_SLM_PKG_VN.TMCS_GET_DEFAULT_STATUS('SITE')
        where SITE_ID = P_SITEID;

        Commit;
      Else
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                , 'TMCS_GIS_TRADEAREA_EJOB'
                                                , '49'
                                                , 'Error While running a TA from a job'
                                                , p_message
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER );

      End if;

Exception
    WHEN OTHERS THEN
        p_message := 99;   -- General ERROR
        rollback;
     dbms_output.put_line('SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                            , 'TMCS_GIS_TRADEAREA_EJOB'
                                                            , '99'
                                                            ,  'General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
END;
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
                                     ) AS
   l_trade_area_exists VARCHAR2(10);
   l_site_exists VARCHAR2(10);
   l_tradearea_id  NUMBER;
   l_site_name VARCHAR2(256);
   l_forcast_model NUMBER;
   p_coordinates1 MDSYS.SDO_GEOMETRY;
   p_coordinates MDSYS.SDO_GEOMETRY;
   l_TMCbrand   VARCHAR2(10);
   plsql_block  VARCHAR2(500);
   l_package     VARCHAR2(500);
   l_Client_ID   varchar2(50);
   l_regionID NUMBER;
   l_error VARCHAR2(32000);
   l_count NUMBER;
   l_sql VARCHAR2(3200);
 BEGIN
-- dbms_output.put_line('l_SITE_ID: '||p_site_id);

--     tmcs_sec_ctx.set_context(p_user_name);
 dbms_output.put_line('p_user_name:'|| p_user_name);

     Begin
        Select G_Client_ID
        into l_Client_ID
        from tmcs_glob_brand_access_tmp
        where G_Brand_ID = p_brand;

        l_TMCbrand := l_Client_ID;
        dbms_output.put_line('l_TMCbrand:'|| l_TMCbrand);
     Exception
        when others then
        p_message := 15;  -- USER Brand Security is not set
        l_error := sqlerrm;
        dbms_output.put_line('p_message:'|| sqlerrm);
       TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                            , 'TMC_MAINTAIN_TRADEAREAS'
                                                            , '15'
                                                            , 'Security Not Set Properly'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
     End;


    if p_message is null then

          BEGIN
               select TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(p_geom)
               into p_coordinates1
               FROM DUAL;
               dbms_output.put_line('RECTIFIED GEOMETRY:');
          EXCEPTION
               when others then
               dbms_output.put_line('RECTIFIED SQL ERROR ' || sqlerrm);

               Select SDO_GEOM.SDO_UNION(p_geom,p_geom,0.001)
                into p_coordinates1
                from DUAL;
          END;

          BEGIN

               select TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(p_coordinates1)
               into p_coordinates
               FROM DUAL;

               dbms_output.put_line('SIMPLIFIED GEOMETRY:');

          EXCEPTION

               when others then
               dbms_output.put_line('SIMPLIFIED SQL ERROR ' || sqlerrm);
               Select SDO_GEOM.SDO_UNION(p_coordinates1,p_coordinates1,0.001)
               into p_coordinates
               from DUAL;
          END;

           if p_coordinates.sdo_srid  != 8307 then
                Begin
                Select SDO_CS.TRANSFORM(p_coordinates,8307)
                into p_coordinates
                from dual;
                Exception
                    When others then
                    DBMS_OUTPUT.PUT_LINE('GEOMETRY SRID transformation : '||sqlerrm);
                     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Maintain Markets'
                                                              , 'TMC_MAINTAIN_TRADEAREAS'
                                                              , ''
                                                              , 'GEOMETRY SRID transformation'
                                                              , sqlerrm
                                                              , TMCS_SEC_CTX.GET_CLIENT_ID
                                                              , TMCS_SEC_CTX.GET_USER
                                                              );
                End;
            Else
             p_coordinates := p_coordinates;
            End if;


          dbms_output.put_line('Validate Geometry : '|| SDO_GEOM.VALIDATE_GEOMETRY(p_coordinates,0.001));

          BEGIN

--               SELECT b.site_name,ORG_ID
--               INTO l_site_name,l_regionID
--               FROM TMCS_SITES_B b
--               WHERE b.site_id= p_site_id
--               and  sdo_inside(b.geometry,TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(p_geom))='TRUE';


                l_sql := 'SELECT count(1)
                FROM TABLE(sdo_PointInPolygon(
                  CURSOR(select  LONGITUDE,LATITUDE,site_name,ORG_ID from TMCS_SITES_B where site_id=  :x1 ),
                  TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(:x2),
                  0.05, ''mask=INSIDE sdo_batch_size=600'')) a';

               Execute immediate l_sql into l_count using  p_site_id,p_geom;

               dbms_output.put_line('l_count: '||l_count);
               dbms_output.put_line('l_SITE_NAME: '||l_site_name);

               if l_count > 0 then
                   SELECT b.site_name,ORG_ID,geometry
                   INTO l_site_name,l_regionID,p_coordinates1
                   FROM TMCS_SITES_B b
                   WHERE b.site_id= p_site_id;


                   dbms_output.put_line('Validate Site Geometry : '|| SDO_GEOM.VALIDATE_GEOMETRY(p_coordinates1,0.001));
                   dbms_output.put_line('l_SITE_NAME: '||l_site_name);
               Else
                    l_site_name := NULL;
               End if;

          EXCEPTION

               when no_data_found then NULL;
               l_site_name := NULL;
                dbms_output.put_line('l_SITE_NAME: '||l_site_name);
                 dbms_output.put_line('Sqlerrm: '||sqlerrm);
               when too_many_rows then l_trade_area_exists := 1;

               DBMS_OUTPUT.put_line('sql error: ' || sqlerrm);
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                            , 'TMC_MAINTAIN_TRADEAREAS'
                                                            , '2'
                                                            , 'Site TA Doesn''t encompass the Site - '|| p_site_id
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
          END;

          IF l_site_name is not null THEN

               BEGIN
                    select 1
                    into  l_trade_area_exists
                    from  TMCS_TRADEAREAS_SITES
                    where site_id = p_site_id
                    and TA_TYPE = p_TA_TYPE;

               EXCEPTION
                    when no_data_found then NULL;
                    when too_many_rows then l_trade_area_exists := 1;

               END;



                BEGIN
                    select 1
                    into  l_site_exists
                    from  TMCS_SITES_B
                    where site_id = p_site_id;

               EXCEPTION
                    when no_data_found then NULL;
                    when too_many_rows then l_site_exists := 1;
               END;

          --     dbms_output.put_line('l_site_exists: '||l_site_exists);

          l_tradearea_id := TMCS_TRADEAREA_S.nextval;
          --    dbms_output.put_line('l_tradearea_id: '||l_tradearea_id);

              IF NVL(l_site_exists,-1) = 1 AND NVL(l_trade_area_exists,-1) = 1 THEN

                    UPDATE  TMCS_TRADEAREAS_SITES
                    SET     current_status = 'FALSE'
                    ,PRIMARY_FLAG = 'N'
                    ,last_updated_by = p_user_name
                    ,last_update_Date = SYSDATE
                    WHERE   site_id = p_site_id
                    and TA_TYPE = p_TA_TYPE
                    and (
                             (UPPER(p_TA_STATUS) = 'TRUE'  and current_status= 'TRUE')
                            or  (UPPER(p_TA_STATUS) = 'FALSE'  and current_status= 'FALSE')
                          );


              ELSIF l_site_exists IS NULL THEN
                      NULL;
--                   DELETE FROM TMCS_TRADEAREAS_SITES
--                   WHERE   site_id = p_site_id;
--                --   dbms_output.put_line('Sucessfully DELETED: ');
              END IF;


            IF  NVL(l_site_exists,-1) = 1 THEN

                begin
                        -- dbms_output.put_line('BEGIN Inserted: ');
                    INSERT INTO TMCS_TRADEAREAS_SITES
                                        (tradearea_id
                                         ,site_id
                                         ,brand
                                         ,BRAND_ID
                                         ,geometry
                                         ,description
                                         ,current_status
                                         ,created_by
                                         ,creation_Date
                                         ,last_updated_by
                                         ,last_update_Date
                                         ,approved_by
                                         ,approved_on
                                         ,org_ID
                                         ,Client_ID
                                         ,TA_TYPE
                                         ,PRIMARY_FLAG
                                        )
                    VALUES
                                          (l_tradearea_id
                                         ,p_site_id
                                         ,p_brand
                                         ,p_brand
                                         ,p_coordinates
                                         ,p_description
                                         ,p_TA_STATUS --'TRUE'
                                         ,p_user_name
                                         ,sysdate
                                        ,p_user_name
                                         ,sysdate
                                         ,NULL
                                         ,NULL
                                         ,l_regionID
                                         ,l_Client_ID
                                         ,p_TA_TYPE
                                         ,'Y'
                                         );


                    Begin
                        Select TMC_PACKAGE
                        into l_package
                        from TMCS_GIS_CLIENT_SETUP
                        where UPPER(TMC_Brand) =  l_Client_ID
                        and UPPER(TMC_Functionality) = 'TA_DEMOGRAPHICS';

                        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f ); END;';
                        dbms_output.put_line(l_tradearea_id||'plsql_block  --> ' || plsql_block);

                        if l_package is not null then
                            EXECUTE IMMEDIATE plsql_block using l_tradearea_id,p_coordinates,'TRUE','Site',tmc_get_demo_table(TMCS_SEC_CTX.GET_CLIENT_ID),OUT p_message;
                        End if;

                        if p_message != 1 then

                            p_message := 5; -- TA Demographics Error
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                                , 'TMC_MAINTAIN_TRADEAREAS'
                                                                , '5'
                                                                ,  'Site Tradearea Demographics Error  '
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
                        END IF;

                    Exception
                      when others then

                      dbms_output.put_line('Demographics SQL ERROR  ' || sqlerrm);
                       p_message := 5; -- TA Demographics Error
                       TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                                , 'TMC_MAINTAIN_TRADEAREAS'
                                                                , '5'
                                                                ,  'Site Tradearea Demographics Error  '
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
                    End;

                    Begin
                        l_package := null;
                        Select TMC_PACKAGE
                        into l_package
                        from TMCS_GIS_CLIENT_SETUP
                        where UPPER(TMC_Brand) =  l_Client_ID
                        and UPPER(TMC_Functionality) = 'GET_TA_SCORE';

                        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d ); END;';

                        dbms_output.put_line(l_tradearea_id||'plsql_block  --> ' || plsql_block);

                        if l_package is not null then
                            EXECUTE IMMEDIATE plsql_block using l_tradearea_id,p_site_id,'Site',OUT p_message;
                        Else
                            p_message := 1; -- TA Score Error
                        End if;

                        if p_message != 1 then

                            p_message := 23; -- TA Score Error

                        END IF;

                    Exception
                      when others then
                      dbms_output.put_line('TA Score SQL ERROR  ' || sqlerrm);
                      l_error := sqlerrm;
                     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                                , 'TMC_MAINTAIN_TRADEAREAS'
                                                                , '23'
                                                                ,  'GET_TA_SCORE'||'TA Score Error '
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
                    End;


                Exception
                    WHEN OTHERS THEN
                    p_message := 4;   -- INSERT TA ERROR
                    rollback;
            --        dbms_output.put_line('p_message ' || p_message);
           --         dbms_output.put_line('SQL ERROR ' || sqlerrm);
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                                , 'TMC_MAINTAIN_TRADEAREAS'
                                                                , '4'
                                                                ,  'INSERT TradeArea  '
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
                End;

            END IF;
               --p_message := 1;

           dbms_output.put_line('TradeArea Insert: '||p_message);
          ELSE
               p_message := 2; -- Site Name is Null
              --  dbms_output.put_line('TradeArea Insert: '||p_message);
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                            , 'TMC_MAINTAIN_TRADEAREAS'
                                                            , '2'
                                                            , 'Site TA Doesn''t encompass the Site - '|| p_site_id
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
          END IF;

    Else
     p_message := 15;
     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                            , 'TMC_MAINTAIN_TRADEAREAS'
                                                            , '15'
                                                            , 'Security Not Set Properly'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
    End If;

     If p_message in (1,23) then
       COMMIT;
     ELSE
       rollback;
       -- null;
     END IF;

 -- dbms_output.put_line('p_message' || p_message);


 EXCEPTION
     WHEN OTHERS THEN
        p_message := 3; --|| p_brand;    -- Trade Area Insert Error
        rollback;
        dbms_output.put_line('p_message ' || p_message);
 --    dbms_output.put_line('FINAL SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                            , 'TMC_MAINTAIN_TRADEAREAS'
                                                            , '3'
                                                            ,  'Insert Site TA General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
 END;
 PROCEDURE TMC_TA_DEMO_REPORT (P_SITEID  IN NUMBER
                              ,P_Type    IN VARCHAR2
                              ,P_BRAND   IN VARCHAR2
                              ,p_user_name in VARCHAR2
                              ,P_CorelationID VARCHAR2
                              ,P_result OUT style) As

   l_geometry MDSYS.SDO_GEOMETRY;
   p_message VARCHAR2(32000);
   plsql_block  VARCHAR2(500);
   l_package     VARCHAR2(500);
   l_TMCbrand   VARCHAR2(10);
   l_Client_ID VARCHAR2(32000);

  BEGIN
--        tmcs_sec_ctx. set_context(p_user_name);
           BEGIN
            Select G_Client_ID
             into l_Client_ID
             from tmcs_glob_brand_access_tmp
             where G_Brand_ID = p_brand;
           EXCEPTION
                When no_data_found then
                 p_message := 15; --User Brand Security Not Set
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TA Demo Report'
                                                            , 'TMC_TA_DEMO_REPORT'
                                                            , '15'
                                                            , 'Security Not Set Properly'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
           END;


          dbms_output.put_line('l_TMCbrand: '||l_Client_ID);
                 l_TMCbrand :=   l_Client_ID;

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) =  l_TMCbrand
        and UPPER(TMC_Functionality) = 'TA_DEMO_REPORT';

        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e ); END;';

        dbms_output.put_line('plsql_block  --> ' || plsql_block);

        EXECUTE IMMEDIATE plsql_block using P_SITEID,P_Type,P_BRAND,P_CorelationID ,OUT P_result;

  EXCEPTION

    When no_data_found then null;
    dbms_output.put_line('TMC_TA_DEMO_REPORT ERROR '|| sqlerrm);

  END;
 function tmc_setgeometry(tbl varchar2, column varchar2 , whereClause varchar2)
    return MDSYS.sdo_geometry_array deterministic as
    geomarr MDSYS.sdo_geometry_array;
    geom sdo_geometry;
    idx number;
    type        cursor_type is REF CURSOR;
    query_crs   cursor_type ;
 begin
    open query_crs for 'select '||column||' from '||tbl || ' where ' ||whereClause  ;
    --dbms_output.put_line ('Select Query : ' || 'select '||column||' from '||tbl || ' where ' ||whereClause);
    geomarr := MDSYS.sdo_geometry_array();
    LOOP
    fetch query_crs into geom;
    EXIT WHEN query_crs%NOTFOUND;
    geomarr.extend;
    geomarr(geomarr.count) := geom;

    END LOOP;
    return geomarr;
 end;
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
                            ) As
    l_start number default dbms_utility.get_time;
    l_package VARCHAR2(32000);
    plsql_block VARCHAR2(500);
    l_TMCbrand  VARCHAR2(10);

 BEGIN

--     Select GROUP_CODE
--        into l_TMCbrand
--        from TMCS_GROUP_BRANDS
--        where GROUP_CODE = p_brand;

    -- TMCS_SITE_SELECTION_PKG.SET_GROUP_CODE(p_brand);

    IF UPPER(p_template) = 'CUSTOM' then

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) =  p_clientID
        and UPPER(TMC_Functionality) = 'CUSTOM_REPORTS';

        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e,  :f, :g, :h, :i, :j ); END;';

        dbms_output.put_line('plsql_block  --> ' || plsql_block);

        EXECUTE IMMEDIATE plsql_block using OUT P_result,P_LAT,P_LONG,P_RING1,P_RING2,P_RING3,p_type,p_ID,P_CorelationID,p_template;

    ELSIF UPPER(p_template) = 'STANDARD' then

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) =  UPPER(p_clientID)
        and UPPER(TMC_Functionality) = 'STANDARD_DEMO_REPORT';

        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e,  :f, :g, :h, :i, :j ); END;';

        dbms_output.put_line('plsql_block  --> ' || plsql_block);

        EXECUTE IMMEDIATE plsql_block using OUT P_result,P_LAT,P_LONG,P_RING1,P_RING2,P_RING3,p_type,p_ID,P_CorelationID,p_template;

    END IF;

    dbms_output.put_line ('Finished  Demographics ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

 Exception
    WHEN OTHERS THEN
    p_result(1) := sqlerrm;
    dbms_output.put_line('TMC_3_RING_REPORT SQL ERROR ' || sqlerrm);
 END;
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
                            ) As
    l_start number default dbms_utility.get_time;
    l_package VARCHAR2(32000);
    plsql_block VARCHAR2(500);
    l_TMCbrand  VARCHAR2(10);
 BEGIN

--     Select GROUP_CODE
--        into l_TMCbrand
--        from TMCS_GROUP_BRANDS
--        where GROUP_CODE = p_brand;

    -- TMCS_SITE_SELECTION_PKG.SET_GROUP_CODE(p_brand);

    IF UPPER(p_template) = 'CUSTOM' then

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) =  p_brand
        and UPPER(TMC_Functionality) = 'CUSTOM_REPORTS';

        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e,  :f, :g, :h ); END;';

        dbms_output.put_line('plsql_block  --> ' || plsql_block);

        EXECUTE IMMEDIATE plsql_block using OUT P_result,P_LAT,P_LONG,P_RING1,P_RING2,P_RING3,p_type,p_ID;

    ELSIF UPPER(p_template) = 'STANDARD' then

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) =  UPPER(p_brand)
        and UPPER(TMC_Functionality) = 'STANDARD_DEMO_REPORT';

        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e,  :f, :g, :h ); END;';

        dbms_output.put_line('plsql_block  --> ' || plsql_block);

        EXECUTE IMMEDIATE plsql_block using OUT P_result,P_LAT,P_LONG,P_RING1,P_RING2,P_RING3,p_type,p_ID;

    END IF;

    dbms_output.put_line ('Finished  Demographics ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

 Exception
    WHEN OTHERS THEN
    p_result(1) := sqlerrm;
    dbms_output.put_line('TMC_3_RING_REPORT SQL ERROR ' || sqlerrm);
 END;

 Procedure TMC_GETSF( p_message out VARCHAR2
                     ,p_brand   IN   VARCHAR2
                     ,p_SITEID    in  NUMBER
                     ,p_user_name in VARCHAR2
                     ,p_SF_ID IN NUMBER
                            ) As
    l_package VARCHAR2(32000);
    plsql_block VARCHAR2(500);
    l_TMCbrand  VARCHAR2(10);
    l_Client_ID NUMBER;
 BEGIN

--     tmcs_sec_ctx. set_context(p_user_name);

       BEGIN
        Select G_Client_ID
         into l_Client_ID
         from tmcs_glob_brand_access_tmp
         where G_Brand_ID = p_brand;
       EXCEPTION
            When no_data_found then
             p_message := 15; --User Brand Security Not Set
             dbms_output.put_line('p_message  --> ' || p_message);
         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site SF'
                                                            , 'TMC_GETSF'
                                                            , '15'
                                                            , 'Security Not Set Properly'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
       END;

    Select TMC_PACKAGE
    into l_package
    from TMCS_GIS_CLIENT_SETUP
    where UPPER(TMC_Brand) = l_Client_ID
    and UPPER(TMC_Functionality) = 'SF_REPORT';

    plsql_block := 'BEGIN '||l_package||'(:a, :b, :c,:d); END;';

    dbms_output.put_line('plsql_block  --> ' || plsql_block);

    EXECUTE IMMEDIATE plsql_block using OUT p_message,p_SITEID,p_SF_ID,p_user_name;
    DBMS_OUTPUT.PUT_LINE('P_MESSAGE  GIS SLM'||P_MESSAGE);
 EXCEPTION
        when others then null;
        DBMS_OUTPUT.put_line('sql error: ' || sqlerrm);
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site SF'
                                                            , 'TMC_GETSF'
                                                            , '99'
                                                            , 'General Error in SF procedure'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
P_MESSAGE := sqlerrm;
 END;

 Procedure TMC_GETANALOG( p_message out VARCHAR2
                     ,p_brand   IN   VARCHAR2
                     ,p_SITEID    in  NUMBER
                     ,p_user_name IN VARCHAR2
                            ) As
    l_package VARCHAR2(32000);
    plsql_block VARCHAR2(500);
    l_TMCbrand  VARCHAR2(10);
    l_Client_ID NUMBER;
 BEGIN

--     tmcs_sec_ctx. set_context(p_user_name);

    Select G_Client_ID
     into l_Client_ID
     from tmcs_glob_brand_access_tmp
     where G_Brand_ID = p_brand;

    -- TMCS_SITE_SELECTION_PKG.SET_GROUP_CODE(l_TMCbrand);

    Select TMC_PACKAGE
    into l_package
    from TMCS_GIS_CLIENT_SETUP
    where UPPER(TMC_Brand) =  UPPER(l_TMCbrand)
    and UPPER(TMC_Functionality) = 'ANALOG_REPORT';

    plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';

    dbms_output.put_line('plsql_block  --> ' || plsql_block);

    EXECUTE IMMEDIATE plsql_block using OUT p_message,p_brand,p_SITEID;

 EXCEPTION

        when others then null;

        DBMS_OUTPUT.put_line('sql error: ' || sqlerrm);

 END;


Procedure TMC_MOD_TA_DISAGG(  p_Site_ID IN NUMBER
                             ,p_brand   IN VARCHAR2
                             ,p_user_name IN VARCHAR2) As

 l_package VARCHAR2(32000);
 plsql_block VARCHAR2(500);
 l_TMCbrand VARCHAR2(10);
 l_Client_ID NUMBER;
Begin

--  tmcs_sec_ctx. set_context(p_user_name);

    Select G_Client_ID
     into l_Client_ID
     from tmcs_glob_brand_access_tmp
     where G_Brand_ID = p_brand;

     Select TMC_PACKAGE
    into l_package
    from TMCS_GIS_CLIENT_SETUP
    where UPPER(TMC_Brand) =  UPPER(l_TMCbrand)
    and UPPER(TMC_Functionality) = 'CHANGE_TA_DISAGG';

    plsql_block := 'BEGIN '||l_package||'(:a, :b); END;';

    dbms_output.put_line('plsql_block  --> ' || plsql_block);

    EXECUTE IMMEDIATE plsql_block using IN p_Site_ID,p_brand;

Exception

    When others then null;
    DBMS_OUTPUT.put_line ('ERROR : ' || SQLERRM);

End;

--Function tmc_get_group_code(p_brand varchar2) return char is
-- stat boolean;
-- l_rep_appl_id number;
--Begin
--  --stat:=FND_PROFILE.SAVE('TMCS_GROUP', p_brand, 'SITE');
--  if stat then
--   return('TRUE');
--  else
--   return('FALSE');
--  end if;
--Exception
--  When others then return('FALSE');
--End;
function TMC_CALLWEBSERVICE( p_wsdl    varchar2,
                              p_servicename varchar2,
                              p_portType    varchar2,
                              p_operationName   varchar2,
                              p_soapURI     VARCHAR2,
                              p_encordingURI    VARCHAR2,
                              p_responseTag varchar2,
                              p_param1    VARCHAR2,
                              p_param2    varchar2
                            ) return VARCHAR2 is

http_req        UTL_HTTP.req;
http_resp       UTL_HTTP.resp;

l_message     VARCHAR2(1000);
response        VARCHAR2(32000);
xml_string      VARCHAR2(32000);
l_start      NUMBER DEFAULT DBMS_UTILITY.get_time ;
BEGIN
  xml_string :=  '<soapenv:Envelope xmlns:soapenv=http://schemas.xmlsoap.org/soap/envelope/ xmlns:tem=http://tempuri.org/><soapenv:Header/><soapenv:Body>
  <tem:'||p_operationName||'>
      <tem:userInput>'||p_param1||'</tem:userInput>
      <tem:wizardFilename>'||p_param2||'</tem:wizardFilename>
  </tem:'||p_operationName||'>
  </soapenv:Body></soapenv:Envelope>';

   dbms_output.put_line ('Started Calling  Alteryx Web-Service :  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );
   TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Alteryx Wizard Request'
                                        , 'TMC_CALLWEBSERVICE '
                                        , 'Request Sent to  Alteryx WebService'
                                        , p_wsdl
                                        , round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...'   || xml_string
                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                        , TMCS_SEC_CTX.GET_USER );

   utl_http.set_transfer_timeout(1200);
   http_req :=UTL_HTTP.begin_request(p_wsdl, 'POST', 'HTTP/1.1');
   UTL_HTTP.set_header(http_req, 'SOAPAction', p_soapURI);
   UTL_HTTP.set_header (http_req, 'Operation', p_operationName);
   UTL_HTTP.set_header (http_req, 'Style', 'Document');
   UTL_HTTP.set_header (http_req, 'Content-Type', 'text/xml');
   UTL_HTTP.set_header(http_req, 'Content-Length', length(xml_string));
--   UTL_HTTP.SET_HEADER(http_req, 'Connection', 'Keep-Alive');
    DBMS_OUTPUT.put_line('write xml :'||xml_string);
   UTL_HTTP.write_text (http_req, xml_string);

   http_resp := UTL_HTTP.get_response(http_req);

   utl_http.set_transfer_timeout(1200);
   UTL_HTTP.read_text(http_resp, response);
   UTL_HTTP.end_response(http_resp);

   DBMS_OUTPUT.put_line('Response> length: ' || response || '');
   if http_resp.status_code = '200' then
        select TO_CHAR(EXTRACTVALUE(xmltype(response), '//executeWizardResult',' xmlns=http://tempuri.org/'))
        into l_message
        from dual;

        l_message := REPLACE(l_message,'&','&'||'amp;');
        DBMS_OUTPUT.put_line('executeWizardResponse Response> : ' || l_message || '');
      TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Alteryx Wizard Response'
                            , 'TMC_CALLWEBSERVICE '
                            , 'Response from service - Status_code : ' || http_resp.status_code || ' Message :  '||http_resp.reason_phrase
                            , p_wsdl
                            , round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...'   || l_message
                            , TMCS_SEC_CTX.GET_CLIENT_ID
                            , TMCS_SEC_CTX.GET_USER );
   Else
    DBMS_OUTPUT.put_line('Response> status_code: ' || http_resp.status_code || '');
    DBMS_OUTPUT.put_line('Response> reason_phrase: ' ||http_resp.reason_phrase || '');
    DBMS_OUTPUT.put_line('Response> http_version: ' ||http_resp.http_version || '');
    l_message := null;
      TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Alteryx Wizard Response'
                                    , 'TMC_CALLWEBSERVICE '
                                    , 'Response from service - Status_code : ' || http_resp.status_code || ' Message :  '||http_resp.reason_phrase
                                    , p_wsdl
                                    , round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...'   || response
                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                    , TMCS_SEC_CTX.GET_USER );
   End if;
   dbms_output.put_line ('Finished Calling  Kettle Service :  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

   return l_message;
EXCEPTION
    When others then
    UTL_HTTP.end_response(http_resp);
    UTL_TCP.close_all_connections;
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Alteryx Webservice Error'
                                    , 'TMC_CALLWEBSERVICE '
                                    , 'Error'
                                    , p_wsdl
                                    , sqlerrm
                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                    , TMCS_SEC_CTX.GET_USER );
end;
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
                                ) As
l_targetID NUMBER;
Begin
        TMC_CREATE_Targets
                                    (p_message
                                    ,p_dma
                                    ,p_target_name
                                    ,p_longitude
                                    ,p_latitude
                                    ,p_address
                                    ,p_city
                                    ,p_state
                                    ,p_country
                                    ,p_zip_code
                                    ,p_ring_miles
                                    ,p_description
                                    ,p_brand
                                    ,p_user_name
                                    ,p_seedID
                                    ,l_targetID
                                    ) ;
    dbms_output.put_line('Target is created with TargetID: ' || l_targetID);
    dbms_output.put_line('p_message output ' || p_message);
Exception
    When others then
      p_message := 99;
        rollback;
     dbms_output.put_line('SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target'
                                                            , 'TMC_MAINTAIN_Targets'
                                                            , '99'
                                                            ,  'General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
End;
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
                                ) AS
l_target_id NUMBER;
l_Client_ID NUMBER;
  plsql_block  VARCHAR2(500);
   l_package     VARCHAR2(500);
   l_source     VARCHAr2(320);
   l_CBSA   NUMBER;
   l_STORE NUMBER;
   l_regionID NUMBER;
   l_geometry MDSYS.SDO_GEOMETRY;
   l_error VARCHAR2(32000);
    l_distance NUMBER;
 l_tempRegionID NUMBER;
Begin

        l_geometry := TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(SDO_GEOMETRY(2001, 8307,SDO_POINT_TYPE(p_longitude,p_latitude,NULL),NULL, NULL));

--        tmcs_sec_ctx.set_context (p_user_name);
    Begin
     Select G_Client_ID
     into l_Client_ID
     from tmcs_glob_brand_access_tmp
     where G_Brand_ID = p_brand;
    Exception
        when no_data_found then
        p_message := 15;  -- USER Brand Security is not set
        l_error := sqlerrm;
       TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target '
                                                            , 'TMC_MAINTAIN_Targets'
                                                            , '15'
                                                            , 'Security Not Set Properly'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
      End;


    if p_seedID is null then
        l_source := '';
    else
        l_source := 'Optimization Point';
    End if;

    BEGIN

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) =  l_Client_ID
        and UPPER(TMC_Functionality) = 'GET_CLASS';

         IF l_package is not null then
               plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';
               dbms_output.put_line(l_package||'l_text  --> ' || plsql_block);
               EXECUTE IMMEDIATE plsql_block using l_geometry,OUT l_CBSA,OUT l_STORE;
        End if;

    EXCEPTION
        when others then null;
        dbms_output.put_line('GET_CLASS SQL ERROR  --> '|| sqlerrm);
       TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target'
                                                            , 'TMC_MAINTAIN_Targets'
                                                            , '6'
                                                            ,  'GET_CLASS ' || ' Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );

    END;

    Begin

        Select REGION_ID
        into l_regionID
        from TMCS_REGIONS a
        where SDO_CONTAINS(a.geometry, l_geometry) = 'TRUE'
        and UPPER(COUNTRY) = UPPER(TMCS_SEC_CTX.GET_COUNTRY_CODE);

    Exception
        When others then
                Begin
                    Select SDO_NN_DISTANCE(1), REGION_ID
                    into l_distance,l_tempRegionID
                    from TMCS_REGIONS
                    where SDO_NN(geometry,l_geometry,'distance = 10 unit = mile',1) = 'TRUE'
                    and UPPER(COUNTRY) = UPPER(TMCS_SEC_CTX.GET_COUNTRY_CODE);

                    if l_distance <= 10 then
                        l_regionID := l_tempRegionID;

                    Else
                        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                                , 'TMC_MAINTAIN_SITES'
                                                                , '7'
                                                                , 'Region not Found even within 10 miles'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
                    End if;


                Exception

                  When others then
                  dbms_OUTPUT.Put_line('Get Region Error : -->  '||sqlerrm);
                  l_error := sqlerrm;

                 TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                                , 'TMC_MAINTAIN_SITES'
                                                                , '7'
                                                                ,  'Region ID not Found'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
                End;
    End;

     If p_message is  null then
            l_target_id :=TMCS_TARGET_S.nextval;
            p_targetID := l_target_id;
            --dbms_output.put_line(l_target_id);
              Begin


                   INSERT INTO TMCS_Targets_B (target_id
                                          ,C_EXT_ATTR1
                                          ,target_name
                                          ,longitude
                                          ,latitude
                                          ,address
                                          ,city
                                          ,state
                                          ,country
                                          ,zip_code
                                          ,creation_date
                                          ,created_by
                                          ,last_update_date
                                          ,last_updated_by
                                          ,status
                                          ,strategy
                                          ,BRAND_ID
                                          ,CLIENT_ID
                                          ,ORG_ID
                                          ,SEED_ID
                                          ,TARGET_SOURCE
                                          ,CBSA_CLASS
                                          ,STORE_CLASS
                                          ,geometry)
                                    VALUES (l_target_id
                                          ,p_dma
                                          ,p_target_name
                                          ,p_longitude
                                          ,p_latitude
                                          ,p_address
                                          ,p_city
                                          ,p_state
                                          ,TMCS_SEC_CTX.GET_COUNTRY_CODE()
                                          ,p_zip_code
                                          , sysdate
                                          ,p_user_name
                                          , sysdate
                                          ,p_user_name
                                          , TMCS_GET_DEFAULT_STATUS('TARGET') --'UNASSIGNED'
                                          , 'C'
                                          ,p_brand
                                          ,l_Client_ID
                                          ,l_regionID
                                          ,p_seedID
                                          ,l_source
                                          ,l_CBSA
                                          ,l_STORE
                                          , l_geometry

                                          );
                dbms_output.put_line('Insert Sucessfull :'|| sqlerrm);
              EXCEPTION
                when others then null;
                p_message := 9; -- This mean there is a violation while creating the target
                l_error := sqlerrm;
                dbms_output.put_line('Insert Error :'|| sqlerrm);
             TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target'
                                                            , 'TMC_MAINTAIN_Targets'
                                                            , '9'
                                                            ,  'This mean there is a violation while creating the target  '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
              END;

            if p_message is null then

                  BEGIN

                        TMCS_UPDATE_STD_ATTRIBUTES(p_message
                                                                   ,'TARGET'
                                                                   ,l_target_id
                                                                   , l_geometry);

                  EXCEPTION
                        when others then null;
                        dbms_output.put_line('SQL ERROR ' || sqlerrm);
                        p_message := 14; --Error while updating Standard Attributes
                        l_error := sqlerrm;
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target'
                                                            , 'TMC_MAINTAIN_Targets'
                                                            , '14'
                                                            ,  'STANDARD_ATTR_UPDATE ' || ' Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
                  END;

                  BEGIN
                           TMCS_SET_ENTITY_DEFAULTS(p_message
                                                                   ,'TARGET'
                                                                   ,l_target_id);

                  EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 14; --Error while updating Standard Attributes
                            l_error := sqlerrm;
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TARGET'
                                                            , 'TMC_MAINTAIN_Targets'
                                                            , '14'
                                                            ,  'Set Entity Defaults ' || ' Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
                  END;

                    BEGIN
                           TMCS_UPDATE_CUST_ATTR(p_message
                                                                   ,'TARGET'
                                                                   ,l_target_id
                                                                   ,p_CustomJson);

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 13; --Error while updating Standard Attributes
                            l_error := sqlerrm;
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TARGET'
                                                            , 'TMC_MAINTAIN_TARGETS'
                                                            , '13'
                                                            ,  'CUSTOM_ATTR_UPDATE ' || ' Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
                    END;

                  If p_message is  null then
                    TMCS_CREATE_TARGET_TA(l_target_id
                                                   ,p_brand
                                                   ,p_ring_miles
                                                   ,p_user_name
                                                   ,p_message);
                  END IF;

                  If p_message = 1 then
--                    Select TMC_PACKAGE
--                    into l_package
--                    from TMCS_GIS_CLIENT_SETUP
--                    where UPPER(TMC_Brand) =  l_Client_ID
--                    and UPPER(TMC_Functionality) = 'TGT_ENCROACHMENT';
--
--                    plsql_block := 'BEGIN '||l_package||'(:a, :b, :c ); END;';
--
--                     dbms_output.put_line('plsql_block  --> ' || plsql_block);
--
--                     if l_package is not null then
--                         EXECUTE IMMEDIATE plsql_block using l_target_id,'TARGET',OUT p_message;
--                     Else
--                        p_message := 1;
--                     End if;

                        TMCS_UPDATE_ENCROACHMENT(p_message ,l_error ,'TARGET',l_target_id);
                  else
                    rollback;
                  end if;
          End if;
     End If;

     If p_message = 1 then
         COMMIT;
         /*Asynchronous call so doing it after commit*/
         BEGIN
            Select TMC_PACKAGE
            into l_package
            from TMCS_GIS_CLIENT_SETUP
            where UPPER(TMC_Brand) = l_Client_ID
            and UPPER(TMC_Functionality) = 'GET_TARGET_NUMBER';
            plsql_block := 'BEGIN '||l_package||'(:a); END;';
         EXCEPTION
            when no_data_found then null;
            when too_many_rows then null;
         END;
         dbms_output.put_line('l_text  --> ' || plsql_block);

         if l_package is not null then
            EXECUTE IMMEDIATE plsql_block using l_target_id;
         Else
            /*Added to update target_number from target_id by VKK*/
            Begin
               update tmcs_targets_b
               set    target_number = l_target_id
               where  target_id = l_target_id;
            End;
            commit;
            p_message := 1;
         End if;

     Else
         rollback;
     End if;
  dbms_output.put_line('p_message' || p_message);

 EXCEPTION
     WHEN OTHERS THEN
        p_message := 99;
        rollback;
     dbms_output.put_line('SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target'
                                                            , 'TMC_MAINTAIN_Targets'
                                                            , '99'
                                                            ,  'General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
END;
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
                                     ) AS

   l_trade_area_exists VARCHAR2(10);
   l_target_exists VARCHAR2(10);
   l_tradearea_id  NUMBER;
   l_target_name VARCHAR2(256);
   l_forcast_model NUMBER;
   p_coordinates1 MDSYS.SDO_GEOMETRY;
   p_coordinates MDSYS.SDO_GEOMETRY;
   l_TMCbrand   VARCHAR2(10);
   plsql_block  VARCHAR2(500);
   l_package     VARCHAR2(500);
   l_Client_ID NUMBER;
   l_regionID NUMBER;
   l_TA_TYPE VARCHAR2(320);
   l_count NUMBER;
   l_sql VARCHAR2(3200);
 BEGIN
 dbms_output.put_line('l_SITE_ID: '||p_target_id);


     BEGIN
         Select G_Client_ID
             into l_Client_ID
             from tmcs_glob_brand_access_tmp
             where G_Brand_ID = p_brand;

                l_TMCbrand := l_Client_ID;
     Exception
        when no_data_found then
        p_message := 15;  -- USER Brand Security is not set
       TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target  TA'
                                                            , 'TMC_MAINTAIN_TARGETS_TA'
                                                            , '15'
                                                            , 'Security Not Set Properly'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
      End;
      -- TMCS_SITE_SELECTION_PKG.SET_GROUP_CODE(l_TMCbrand);

     BEGIN

        select TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(p_geom)
        into p_coordinates1
        FROM DUAL;

       --dbms_output.put_line('RECTIFIED GEOMETRY:');

     EXCEPTION
        when others then
      dbms_output.put_line('RECTIFIED SQL ERROR ' || sqlerrm);
        Select SDO_GEOM.SDO_UNION(p_geom,p_geom,0.001)
                    into p_coordinates1
                    from DUAL;
     END;

     BEGIN

        select TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(p_coordinates1)
        into p_coordinates
        FROM DUAL;
       -- dbms_output.put_line('SIMPLIFIED GEOMETRY:');

     EXCEPTION

        when others then NULL;
        dbms_output.put_line('SIMPLIFIED SQL ERROR ' || sqlerrm);
        Select SDO_GEOM.SDO_UNION(p_coordinates1,p_coordinates1,0.001)
                    into p_coordinates
                    from DUAL;
     END;

   dbms_output.put_line(p_coordinates.GET_GTYPE());
   dbms_output.put_line(SDO_GEOM.VALIDATE_GEOMETRY(p_coordinates,0.001));

    -- Adding code for this to work for all existing clients prior to this change.
       IF p_TA_TYPE  is null then
        l_TA_TYPE := p_description;
       else
         l_TA_TYPE := p_TA_TYPE;
       END IF;

  dbms_output.put_line('l_TA_TYPE  : '||l_TA_TYPE);
      BEGIN

--        SELECT b.target_name,ORG_ID
--        INTO l_target_name,l_regionID
--        FROM TMCS_TARGETS_B b
--        WHERE b.target_id= p_target_id
--        and  sdo_relate(b.geometry,TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(p_coordinates),'mask=ANYINTERACT')='TRUE';

        l_sql := 'SELECT count(1)
                FROM TABLE(sdo_PointInPolygon(
                  CURSOR(select  LONGITUDE,LATITUDE from TMCS_TARGETS_B where target_id=  :x1 ),
                  TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(:x2),
                  0.05, ''mask=INSIDE sdo_batch_size=600'')) a';

               Execute immediate l_sql into l_count using  p_target_id,p_geom;

               dbms_output.put_line('l_count: '||l_count);
               dbms_output.put_line('l_target_name: '||l_target_name);

               if l_count > 0 then
                   SELECT b.target_name,ORG_ID,geometry
                   INTO l_target_name,l_regionID,p_coordinates1
                   FROM TMCS_TARGETS_B b
                   WHERE b.target_id= p_target_id;


                   dbms_output.put_line('Validate Site Geometry : '|| SDO_GEOM.VALIDATE_GEOMETRY(p_coordinates1,0.001));
                   dbms_output.put_line('l_target_name: '||l_target_name);
               Else
                    l_target_name := NULL;
               End if;

        dbms_output.put_line('l_target_name: '||l_target_name);

      EXCEPTION


        when no_data_found then NULL;

          DBMS_OUTPUT.put_line('sql error: ' || sqlerrm);
          dbms_output.put_line('l_target_name: '||l_target_name);
          p_message := 10;
          TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target TA'
                                                            , 'TMC_MAINTAIN_TARGETS_TA'
                                                            , p_message
                                                            ,  'Target Name is Null  '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
         when too_many_rows then l_trade_area_exists := 1;

         DBMS_OUTPUT.put_line('sql error: ' || sqlerrm);
          dbms_output.put_line('l_target_name: '||l_target_name);
          p_message := 10;
          TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target TA'
                                                            , 'TMC_MAINTAIN_TARGETS_TA'
                                                            , p_message
                                                            ,  'Target Name is Null  '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );

          when others then
        DBMS_OUTPUT.put_line('sql error: ' || sqlerrm);
      END;


      IF l_target_name is not null THEN

           BEGIN
             select 1
             into  l_trade_area_exists
             from  TMCS_TRADEAREAS_TARGETS
             where target_id = p_target_id;
           EXCEPTION
             when no_data_found then NULL;
             when too_many_rows then l_trade_area_exists := 1;

           END;

 --     dbms_output.put_line('l_trade_area_exists: '||l_trade_area_exists);

           BEGIN
             select 1
             into  l_target_exists
             from  TMCS_TARGETS_B
             where target_id = p_target_id;


           EXCEPTION
             when no_data_found then NULL;
             when too_many_rows then l_target_exists := 1;
           END;

     --  dbms_output.put_line('l_target_exists: '||l_target_exists);

       l_tradearea_id := TMCS_TRADEAREA_T_S.nextval;
  --     dbms_output.put_line('l_tradearea_id: '||l_tradearea_id);

           IF NVL(l_target_exists,-1) = 1 AND NVL(l_trade_area_exists,-1) = 1 THEN
   --          dbms_output.put_line('Sucessfully UPDATED 0: ');
               UPDATE  TMCS_TRADEAREAS_TARGETS
              SET     current_status = 'FALSE'
               ,last_updated_by = p_user_name---1--fnd_global.user_id
               ,last_update_Date = SYSDATE
               WHERE   target_id = p_target_id ;

                UPDATE  TMCS_TRADEAREAS_TARGETS
              SET     PRIMARY_FLAG = 'N'
               ,last_updated_by = p_user_name---1--fnd_global.user_id
               ,last_update_Date = SYSDATE
               WHERE   target_id = p_target_id  and TA_TYPE = l_TA_TYPE;

              UPDATE  TMCS_TRADEAREAS_TARGETS
              SET     current_status = 'FALSE'
                         ,PRIMARY_FLAG = 'N'
         --             ,last_updated_by = -1
                      ,last_updated_by = p_user_name---1--fnd_global.user_id
                      ,last_update_Date = SYSDATE
              WHERE   target_id = p_target_id
--                      and BRAND = p_brand
                      and TA_TYPE = l_TA_TYPE
                    and (
                             (UPPER(p_TA_STATUS) = 'TRUE'  and current_status= 'TRUE')
                            or  (UPPER(p_TA_STATUS) = 'FALSE'  and current_status= 'FALSE')
                          );
    --           dbms_output.put_line('Sucessfully UPDATED: ');

           ELSIF l_target_exists IS NULL THEN

              DELETE FROM TMCS_TRADEAREAS_TARGETS
              WHERE   target_id = p_target_id;
      --        dbms_output.put_line('Sucessfully DELETED: ');

           END IF;


           IF  NVL(l_target_exists,-1) = 1 THEN

                 begin
        --             dbms_output.put_line('BEGIN Inserted: ');




                  INSERT INTO TMCS_TRADEAREAS_TARGETS
                                               (tradearea_id
                                                ,target_id
                                                ,brand
                                                ,geometry
                                                ,description
                                                ,current_status
                                                ,created_by
                                                ,creation_Date
                                                ,last_updated_by
                                                ,last_update_Date
                                                ,approved_by
                                                ,approved_on
                                                ,Client_ID
                                                ,ORG_ID
                                                ,TA_TYPE
                                                ,PRIMARY_FLAG
                                                ,brand_ID
                                               )
                  VALUES
                                                 (l_tradearea_id
                                                ,p_target_id
                                                ,p_brand
                                                ,p_coordinates
                                                ,p_description
                                                ,'TRUE'
                                                ,p_user_name
                                                ,sysdate
                                                ,p_user_name
                                                ,sysdate
                                                ,NULL
                                                ,NULL
                                                ,l_Client_ID
                                                ,l_regionID
                                                ,l_TA_TYPE
                                                ,'Y'
                                                ,p_brand
                                                );

                   --commit;

                    Select TMC_PACKAGE
                    into l_package
                    from TMCS_GIS_CLIENT_SETUP
                    where UPPER(TMC_Brand) =  l_TMCbrand
                    and UPPER(TMC_Functionality) = 'TA_DEMOGRAPHICS';

                    plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d,:e, :f ); END;';

                    dbms_output.put_line(l_tradearea_id||'plsql_block  --> ' || plsql_block);

                    EXECUTE IMMEDIATE plsql_block using l_tradearea_id,p_coordinates,'TRUE','Target',tmc_get_demo_table(TMCS_SEC_CTX.GET_CLIENT_ID),OUT p_message;


                     if p_message != 1 then

                        p_message := 5; -- TA Demographics Error

                     END IF;



                 Exception
                    WHEN OTHERS THEN
                    p_message := 4; --     Insert TA Error
                    rollback;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target TA'
                                                            , 'TMC_MAINTAIN_TARGETS_TA'
                                                            , '4'
                                                            ,  'INSERT TradeArea  '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
            --        dbms_output.put_line('p_message ' || p_message);
            --        dbms_output.put_line('SQL ERROR ' || sqlerrm);
                 End;

           END IF;
       --p_message := 1;

       --dbms_output.put_line('TradeArea Insert: '||p_message);
      ELSE
        p_message := 10; -- Target Name is Null
        --dbms_output.put_line('TradeArea Insert: '||p_message);
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target TA'
                                                            , 'TMC_MAINTAIN_TARGETS_TA'
                                                            , p_message
                                                            ,  'Target Name is Null  '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
      END IF;

      If p_message = 1 then

        COMMIT;
      ELSE
            rollback;
      END IF;

  --dbms_output.put_line('p_message' || p_message);


 EXCEPTION
     WHEN OTHERS THEN
        p_message := 3 || p_brand;    -- Trade Area Insert Error
        rollback;
       TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target TA'
                                                            , 'TMC_MAINTAIN_TARGETS_TA'
                                                            , '3'
                                                            ,  'Insert Target TA General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
    --    dbms_output.put_line('p_message ' || p_message);
     --dbms_output.put_line('FINAL SQL ERROR ' || sqlerrm);
 END;

  PROCEDURE TMC_MARKET_REPORT
                             (P_result OUT style
                             ,p_ID    IN VARCHAR2
                             ,p_type  IN VARCHAR2
                             ,p_brand IN VARCHAR2
                             ,p_template   IN VARCHAR2
                            ) As
    l_start number default dbms_utility.get_time;
    l_package VARCHAR2(32000);
    plsql_block VARCHAR2(500);
    l_TMCbrand  VARCHAR2(10);
 BEGIN

--     Select GROUP_CODE
--        into l_TMCbrand
--        from TMCS_GROUP_BRANDS
--        where GROUP_CODE = p_brand;

    -- TMCS_SITE_SELECTION_PKG.SET_GROUP_CODE(p_brand);

    IF UPPER(p_template) = 'CUSTOM' then

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) =  p_brand
        and UPPER(TMC_Functionality) = 'CUSTOM_REPORTS';

        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e,  :f, :g, :h,:i ); END;';

        dbms_output.put_line('plsql_block  --> ' || plsql_block);

        EXECUTE IMMEDIATE plsql_block using OUT P_result,p_type,p_ID,p_template;

    ELSIF UPPER(p_template) = 'STANDARD' then

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) =  UPPER(p_brand)
        and UPPER(TMC_Functionality) = 'MARKET_DEMO_REPORT';

        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d ); END;';

        dbms_output.put_line('plsql_block  --> ' || plsql_block);

        EXECUTE IMMEDIATE plsql_block using p_ID,p_type,p_brand,OUT P_result;

    END IF;

    dbms_output.put_line ('Finished  Demographics ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

 Exception
    WHEN OTHERS THEN
    p_result(1) := sqlerrm;
    dbms_output.put_line('TMC_3_RING_REPORT SQL ERROR ' || sqlerrm);
 END;
PROCEDURE  TMC_DRAW_ENTITY_TA( p_ENTITYID IN NUMBER
                                                        , P_ENTITYTYPE in VARCHAR2 DEFAULT 'SITE'
                                                        , P_TA_TYPE in VARCHAR2 DEFAULT 'RETAIL'
                                                        , P_DESCRIPTION in VARCHAR2 DEFAULT NULL
                                                        , P_GEOMETRY IN MDSYS.SDO_GEOMETRY
                                                        , P_BRAND_ID IN NUMBER
                                                        , P_MESSAGE out VARCHAR2
                                                        ) as
l_longitude NUMBER;
l_latitude  NUMBER;
l_values    VARCHAR2(32000);
l_brand_ID varchar2(30);
l_geom      MDSYS.SDO_GEOMETRY;
l_geometry MDSYS.SDO_GEOMETRY;
l_state VARCHAR2(21);
l_instance VARCHAR2(100);
l_ALTX_name VARCHAR2(500);
l_description VARCHAR2(500);
l_package VARCHAR2(320);
plsql_block VARCHAR2(320);
p_unit VARCHAR2(32);

BEGIN


        IF UPPER(P_ENTITYTYPE) = 'SITE' then

            TMC_MAINTAIN_TRADEAREAS
                                    ( p_message
                                     , p_ENTITYID
                                     , TMCS_SEC_CTX.get_user
                                     , ''
                                     , P_DESCRIPTION
                                     , P_BRAND_ID
                                     , P_GEOMETRY
                                     , P_TA_TYPE
                                     ) ;

        ELSIF UPPER(P_ENTITYTYPE) = 'TARGET' then
                TMC_MAINTAIN_TARGETS_TA
                                        (  p_message
                                         , p_ENTITYID
                                         , P_BRAND_ID
                                         , TMCS_SEC_CTX.get_user
                                         , NULL
                                         , P_DESCRIPTION
                                         , P_GEOMETRY
                                         , P_TA_TYPE
                                         ) ;

        ELSIF UPPER(P_ENTITYTYPE) = 'STORE' then
           TMCS_MAINTAIN_STORE_TRADEAREAS
                                    (  p_message
                                     , p_ENTITYID
                                     , TMCS_SEC_CTX.get_user
                                     , ''
                                     , P_DESCRIPTION
                                     , P_BRAND_ID
                                     , P_GEOMETRY
                                     , P_TA_TYPE
                                     );
        ELSIF UPPER(P_ENTITYTYPE) = 'PROSPECT' then
            TMC_MAINTAIN_PROSPECTS_TA
                                    (  p_message
                                     , p_ENTITYID
                                     , P_DESCRIPTION
                                     , P_BRAND_ID
                                     , TMCS_SEC_CTX.get_user
                                     , P_GEOMETRY
                                     );
        END if;


EXCEPTION
   When others then null;
   p_message := 17;
   DBMS_OUTPUT.put_line('Web Service error: ' || sqlerrm);
       TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entityType
                                            , 'TMC_DRAW_ENTITY_TA'
                                            , '17'
                                            ,  'General Error  while creating CUSTOM TA'
                                            , SQLERRM
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.get_user
                                            );
END;
 procedure  tmc_DT_SiteTA( p_SiteID IN NUMBER
                        ,p_user_name IN Varchar2
                        , p_DTmin  IN NUMBER
                         ,p_type IN VARCHAR2
                        , p_message out VARCHAR2
                        , p_ta_TYPE in VARCHAR2 DEFAULT 'RETAIL'
                        , p_entityType in VARCHAR2 DEFAULT 'SITE'
                        ) as
l_longitude NUMBER;
l_latitude  NUMBER;
l_values    VARCHAR2(32000);
l_brand_ID varchar2(30);
l_geom      MDSYS.SDO_GEOMETRY;
l_geometry MDSYS.SDO_GEOMETRY;
l_state VARCHAR2(21);
l_instance VARCHAR2(100);
l_ALTX_name VARCHAR2(500);
l_description VARCHAR2(500);
l_package VARCHAR2(320);
plsql_block VARCHAR2(320);
p_unit VARCHAR2(32);
Begin

        if Upper(p_entityType) = 'SITE' then

               Select longitude,latitude,brand_ID,geometry
               into l_longitude,l_latitude,l_brand_ID,l_geometry
               from TMCS_SITES_B
               where Site_ID = p_SiteID;

       ElsIF UPPER(p_entityType) = 'TARGET' then

               Select longitude,latitude,brand_ID,geometry
               into l_longitude,l_latitude,l_brand_ID,l_geometry
               from TMCS_TARGETS_B
               where TARGET_ID = p_SiteID;

       ElsIF upper(p_entityType) = 'STORE' then

               Select longitude,latitude,brand_ID,geometry
               into l_longitude,l_latitude,l_brand_ID,l_geometry
               from TMCS_ALL_STORES
               where STORE_ID = p_SiteID;

       End if;


   dbms_output.put_line(l_latitude|| '  p_entityType: '||l_longitude);

--    BEGIN
--
--         select SYS_CONTEXT('USERENV','SERVER_HOST') --utl_inaddr.get_host_name
--         into l_instance
--         from dual;
--
--             if   l_instance = 'ip-10-0-0-133' then
--                l_ALTX_name :=  'BKNG\Alteryx\DT_TA.yxwz';
--              Elsif l_instance =  'ip-10-0-0-142' then
--                      l_ALTX_name := 'BKNG\Models\Alteryx\DT_TA.yxwz';
--             End if;
--
--    EXCEPTION
--        WHEN no_data_found then null;
--        p_message := 15; --User Brand Security Not Set
--    END;


    BEGIN

       TMCS_GIS_SLM_PKG_VN.TMCS_DELETE_DATA_COMMIT ( 'TEMP_TMC_DT_TA', 'Site_ID = '||p_SITEID );

        case (UPPER( p_type))

            when 'DRIVE TIME' then
                        BEGIN

                                Select TMC_PACKAGE
                                into l_package
                                from TMCS_GIS_CLIENT_SETUP
                                where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID
                                and UPPER(TMC_Functionality) = 'GET_STD_DT_TA';

                                plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';

                                dbms_output.put_line('l_text  --> ' || plsql_block);

                                if l_package is not null then
                                    EXECUTE IMMEDIATE plsql_block using p_siteID,p_DTmin,OUT p_message;
                                End if;

                        EXCEPTION
                                when others then null;
                                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                                p_message := 16; --Error while updating Standard Attribute
                                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                                , 'tmc_DT_SiteTA'
                                                                , p_message
                                                                ,  'GET_STD_DT_TA ' || ' Client Specific Procedure Not Found'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
                        END;


                        BEGIN
                                Select geometry
                                into l_geom
                                from TEMP_TMC_DT_TA
                                where Site_ID = p_SiteID;
                                --dbms_output.put_line(l_brand_ID);
                        EXCEPTION
                                when others then
                                dbms_output.put_line('SELECT CLASS ERROR : '||sqlerrm);
                                p_message := 12;      -- No Drivetime generated
                                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entityType
                                            , 'tmc_DT_SiteTA'
                                            , p_message
                                            ,  'Drive Time Not Created by Client Specific Package'
                                            , SQLERRM
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.get_user
                                            );
                        END;

                        l_description :=    'user Defined '||p_DTmin||' Minutes Drive Time';

            when 'RING' then

                        if UPPER(TMCS_SEC_CTX.GET_COUNTRY_CODE()) = 'USA' then
                                p_unit :=  'mile';
                        Else
                                p_unit := 'km';
                        End if;

                        l_geom  := sdo_geom.sdo_buffer (SDO_GEOMETRY(2001, 8307,SDO_POINT_TYPE(l_longitude,l_latitude,NULL),NULL, NULL)
                                                                       ,p_DTmin,0.005,'unit='||p_unit||', arc_tolerance=0.005');

                        l_description :=    'user Defined '||p_DTmin||' '|| p_unit;

        END CASE;


          if l_geom is not null then

                IF UPPER(p_entityType) = 'SITE' then
                   TMC_MAINTAIN_TRADEAREAS (p_message
                                                               ,p_siteID
                                                               ,p_user_name
                                                               ,'Drive Time'
                                                               ,l_description
                                                               ,l_brand_ID
                                                               ,l_geom
                                                               ,p_ta_TYPE
                                                               );
                ELSIF  UPPER(p_entityType) = 'TARGET' then

                   TMC_MAINTAIN_TARGETS_TA
                                    (p_message
                                     ,p_siteID
                                     ,l_brand_ID
                                     ,p_user_name
                                     ,p_DTmin
                                     ,l_description
                                     ,l_geom
                                     ,p_ta_TYPE
                                     ,'TRUE'
                                     );

                ELSIF  UPPER(p_entityType) = 'STORE' then
                        TMCS_MAINTAIN_STORE_TRADEAREAS
                                            (p_message
                                             ,p_siteID
                                             ,p_user_name
                                             ,''
                                             ,l_description
                                             ,l_brand_ID
                                             ,l_geom
                                             ,p_ta_TYPE
                                             , 'TRUE'
                                             ) ;
                End if;
          END IF;

    EXCEPTION
        when others then null;
        DBMS_OUTPUT.put_line('Web Service error: ' || sqlerrm);
        p_message :=  16;
         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entityType
                                            , 'tmc_DT_SiteTA'
                                            , '16'
                                            ,  'Some error while creating Standard TA'
                                            , SQLERRM
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.get_user
                                            );
    END;

commit;
Exception
   When others then null;
   p_message := 17;
   DBMS_OUTPUT.put_line('Web Service error: ' || sqlerrm);
       TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entityType
                                            , 'tmc_DT_SiteTA'
                                            , '17'
                                            ,  'General Error  while creating Standard TA'
                                            , SQLERRM
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.get_user
                                            );
END;
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
                                ) As

l_prospect_id NUMBER;
l_Client_ID NUMBER;
plsql_block  VARCHAR2(500);
l_package     VARCHAR2(500);
l_error     VARCHAR2(500);
l_regionID NUMBER;
 l_distance NUMBER;
 l_tempRegionID NUMBER;
l_STORE NUMBER;
l_CBSA NUMBER;

l_geometry MDSYS.SDO_GEOMETRY ;

Begin
--        tmcs_sec_ctx.set_context (p_user_name);
      l_geometry := TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(SDO_GEOMETRY(2001, 8307,SDO_POINT_TYPE(p_longitude,p_latitude,NULL),NULL, NULL));
           Begin
     Select G_Client_ID
     into l_Client_ID
     from tmcs_glob_brand_access_tmp
     where G_Brand_ID = p_brand;
    Exception
        when no_data_found then
        p_message := 15;  -- USER Brand Security is not set
      End;

    Begin

            Select REGION_ID
            into l_regionID
            from TMCS_REGIONS a
            where SDO_CONTAINS(a.geometry, l_geometry) = 'TRUE'
            and UPPER(COUNTRY) = UPPER(TMCS_SEC_CTX.GET_COUNTRY_CODE);

    Exception
            When others then
                Begin
                    Select SDO_NN_DISTANCE(1), REGION_ID
                    into l_distance,l_tempRegionID
                    from TMCS_REGIONS
                    where SDO_NN(geometry,l_geometry,'distance = 10 unit = mile',1) = 'TRUE'
                    and UPPER(COUNTRY) = UPPER(TMCS_SEC_CTX.GET_COUNTRY_CODE);

                    if l_distance <= 10 then
                        l_regionID := l_tempRegionID;

                    Else
                        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                                , 'TMC_MAINTAIN_SITES'
                                                                , '7'
                                                                , 'Region not Found even within 10 miles'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
                    End if;

                Exception

                  When others then
                  dbms_OUTPUT.Put_line('Get Region Error : -->  '||sqlerrm);
--                  l_error := sqlerrm;

                 TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                                , 'TMC_MAINTAIN_SITES'
                                                                , '7'
                                                                ,  'Region ID not Found'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
                End;
    End;

    BEGIN

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) =  l_Client_ID
        and UPPER(TMC_Functionality) = 'GET_CLASS';

         IF l_package is not null then
               plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';
               dbms_output.put_line(l_package||'l_text  --> ' || plsql_block);
               EXECUTE IMMEDIATE plsql_block using l_geometry,OUT l_CBSA,OUT l_STORE;
        End if;

    EXCEPTION
        when others then null;
        dbms_output.put_line('GET_CLASS SQL ERROR  --> '|| sqlerrm);
       TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Target'
                                                            , 'TMC_MAINTAIN_Prospect'
                                                            , '6'
                                                            ,  'GET_CLASS ' || ' Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );

    END;



    if upper(p_insert) = 'TRUE' then

        l_prospect_id :=TMCS_PROSPECTS_SQ.nextval;

          Begin

               INSERT INTO TMCS_PROSPECTS (PROSPECT_ID
                                  ,PROJECT_NAME
                                  ,ADDRESS
                                  ,CITY
                                  ,STATE
                                  ,ZIP_CODE
                                  ,LONGITUDE
                                  ,LATITUDE
                                  ,creation_date
                                  ,created_by
                                  ,last_update_date
                                  ,last_updated_by
                                  ,status
                                  ,STORE_TYPE
                                  ,DRIVE_THRU
                                  ,BRAND_ID
                                  ,CLIENT_ID
                                  ,ORG_ID
--                                  ,store_class
--                                  ,cbsa_class
                                  ,geometry
                                  ,COUNTRY)
                            VALUES (l_prospect_id
                                  ,p_prospect_name
                                  ,p_address
                                  ,p_city
                                  ,p_state
                                  ,p_zip_code
                                  ,p_longitude
                                  ,p_latitude
                                  , sysdate
                                  ,p_user_name
                                  , sysdate
                                  ,p_user_name
                                  ,'Pending Review'
                                  ,p_StoreType
                                  ,p_drive_thru
                                  ,p_brand
                                  ,l_Client_ID
                                  ,l_regionID
--                                  ,l_STORE
--                                  ,l_CBSA
                                  ,TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(l_geometry)
                                  ,TMCS_SEC_CTX.GET_COUNTRY_CODE()
                                  );
          EXCEPTION
            when others then null;
            p_message := 9; -- This mean there is a violation while creating the target
            dbms_output.put_line('Insert Error :'|| sqlerrm);
             TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('PROSPECTS'
                                                            , 'TMC_MAINTAIN_PROSPECTs'
                                                            , '9'
                                                            ,  'This mean there is a violation while creating the target  '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
          END;

    ElsIF  upper(p_insert) = 'FALSE' then

        l_prospect_id := p_prospectID;

        update TMCS_PROSPECTS
        set  ADDRESS = p_address
          ,CITY =  p_city
          ,STATE = p_state
          ,ZIP_CODE = p_zip_code
          ,LONGITUDE = p_longitude
          ,LATITUDE = p_latitude
          ,last_update_date = sysdate
          ,last_updated_by = p_user_name
          ,GEOMETRY = l_geometry
          ,COUNTRY = TMCS_SEC_CTX.GET_COUNTRY_CODE()
          where PROSPECT_ID = p_prospectID;

    End if;

     dbms_output.put_line(l_Client_ID);
        dbms_output.put_line(l_prospect_id);

      BEGIN

            TMCS_UPDATE_STD_ATTRIBUTES(p_message
                                                                   ,'PROSPECT'
                                                                   ,l_prospect_id
                                                                   , l_geometry);

      EXCEPTION
            when others then null;
            dbms_output.put_line('SQL ERROR ' || sqlerrm);
            p_message := 14; --Error while updating Standard Attributes
      END;

      BEGIN

           TMCS_SET_ENTITY_DEFAULTS(p_message
                                                   ,'PROSPECT'
                                                   ,l_prospect_id);

      EXCEPTION
                when others then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                p_message := 14; --Error while updating Standard Attributes
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('PROSPECT'
                                                , 'TMC_MAINTAIN_PROSPECTS'
                                                , '14'
                                                ,  'Set Entity Defaults ' || ' Client Specific Procedure Not Found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , p_user_name
                                                );
      END;

      if p_CustomJson is not null then

            BEGIN
               TMCS_UPDATE_CUST_ATTR(p_message
                                                       ,'PROSPECT'
                                                       ,l_prospect_id
                                                       ,p_CustomJson);

            EXCEPTION
                when others then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                p_message := 13; --Error while updating Standard Attributes
                l_error := sqlerrm;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('PROSPECT'
                                                , 'TMC_MAINTAIN_PROSPECTS'
                                                , '13'
                                                ,  'CUSTOM_ATTR_UPDATE ' || ' Client Specific Procedure Not Found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , p_user_name
                                                );
            END;

      End if;

       If p_trade_area_type = 'PREDEFINED_RING'  and p_message is  null then


            Select TMC_PACKAGE
            into l_package
            from TMCS_GIS_CLIENT_SETUP
            where UPPER(TMC_Brand) = l_Client_ID
            and UPPER(TMC_Functionality) = 'GET_PROSPECT_TRADEAREA';
            plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f, :g); END;';


            dbms_output.put_line('l_text  --> ' || plsql_block);

            if l_package is not null then
                EXECUTE IMMEDIATE plsql_block using l_prospect_id,p_brand, p_user_name, p_trade_area_type,p_description,p_ring_miles,OUT p_message;
            Else
                p_message := 1;
            End if;


      ELSIF p_trade_area_type != 'PREDEFINED_RING'  and p_message is  null then


               TMC_MAINTAIN_TRADEAREAS (p_message
                                       ,l_prospect_id
                                       ,p_user_name
                                       ,p_trade_area_type
                                       ,p_description
                                       ,''
                                       ,p_drive_time_coordinates
                                       );
      END IF;

     If p_message = 1 then

            Select TMC_PACKAGE
            into l_package
            from TMCS_GIS_CLIENT_SETUP
            where UPPER(TMC_Brand) =  l_Client_ID
            and UPPER(TMC_Functionality) = 'PROSPECT_ENCROACHMENT';

            plsql_block := 'BEGIN '||l_package||'(:a, :b, :c ); END;';

             dbms_output.put_line('plsql_block  --> ' || plsql_block);

             if l_package is not null then
                 EXECUTE IMMEDIATE plsql_block using l_prospect_id,'PROSPECT',OUT p_message;
             Else
                p_message := 1;
             End if;

     end if;


      If p_message = 1 then
        COMMIT;
      else
        rollback;
      end if;

  dbms_output.put_line('p_message' || p_message);

 EXCEPTION
     WHEN OTHERS THEN
        p_message := 99;
        rollback;
     dbms_output.put_line('SQL ERROR ' || sqlerrm);
END;
PROCEDURE TMC_MAINTAIN_PROSPECTS_TA
                                    (p_message OUT VARCHAR2
                                     ,p_prospectID IN NUMBER
                                     ,p_description IN VARCHAR2
                                     ,p_brand in VARCHAR2
                                     ,p_user_name IN VARCHAR2
                                     ,p_geom IN MDSYS.SDO_GEOMETRY
                                     ) AS

   l_trade_area_exists VARCHAR2(10);
   l_prospect_exists VARCHAR2(10);
   l_tradearea_id  NUMBER;
   l_prospect_name VARCHAR2(256);
   l_forcast_model NUMBER;
   p_coordinates1 MDSYS.SDO_GEOMETRY;
   p_coordinates MDSYS.SDO_GEOMETRY;
   l_TMCbrand   VARCHAR2(10);
   plsql_block  VARCHAR2(500);
   l_package     VARCHAR2(500);
   l_Client_ID NUMBER;
   l_regionID NUMBER;
   l_count NUMBER;
   l_sql VARCHAR2(3200);
 BEGIN
 dbms_output.put_line('p_prospectID: '||p_prospectID);


     BEGIN
         Select G_Client_ID
             into l_Client_ID
             from tmcs_glob_brand_access_tmp
             where G_Brand_ID = p_brand;

                l_TMCbrand := l_Client_ID;
     Exception
        when no_data_found then
        p_message := 15;  -- USER Brand Security is not set
      End;
      -- TMCS_SITE_SELECTION_PKG.SET_GROUP_CODE(l_TMCbrand);

     BEGIN

        select TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(p_geom)
        into p_coordinates1
        FROM DUAL;

     EXCEPTION
        when others then
        Select SDO_GEOM.SDO_UNION(p_geom,p_geom,0.001)
        into p_coordinates1
        from DUAL;

     END;

     BEGIN

        select TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(p_coordinates1)
        into p_coordinates
        FROM DUAL;

     EXCEPTION

        when others then NULL;
        Select SDO_GEOM.SDO_UNION(p_coordinates1,p_coordinates1,0.001)
        into p_coordinates
        from DUAL;
     END;

--   dbms_output.put_line(p_coordinates.GET_GTYPE());
--   dbms_output.put_line(SDO_GEOM.VALIDATE_GEOMETRY(p_coordinates,0.001));
      IF p_coordinates IS not NULL then
            dbms_output.put_line(p_coordinates.GET_GTYPE());
            dbms_output.put_line(SDO_GEOM.VALIDATE_GEOMETRY(p_coordinates,0.001));
      Else
            dbms_output.put_line('Geometry is null');
      End if;

--        dbms_output.put_line(SDO_UTIL.TO_GEOJSON(p_coordinates));
        Commit;

      BEGIN

--        SELECT b.PROJECT_NAME,ORG_ID
--        INTO l_prospect_name,l_regionID
--        FROM TMCS_PROSPECTS b
--        WHERE b.PROSPECT_ID= p_prospectID
--        and  sdo_relate(geometry,TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(p_coordinates),'mask=INSIDE')='TRUE';

        l_sql := 'SELECT count(1)
                FROM TABLE(sdo_PointInPolygon(
                  CURSOR(select  LONGITUDE,LATITUDE from TMCS_PROSPECTS where PROSPECT_ID=  :x1 ),
                  TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(:x2),
                  0.05, ''mask=INSIDE sdo_batch_size=600'')) a';

               Execute immediate l_sql into l_count using  p_prospectID,p_geom;

               dbms_output.put_line('l_count: '||l_count);
               dbms_output.put_line('l_prospect_name: '||l_prospect_name);

               if l_count > 0 then
                   SELECT b.PROJECT_NAME,ORG_ID,geometry
                   INTO l_prospect_name,l_regionID,p_coordinates1
                   FROM TMCS_PROSPECTS b
                   WHERE b.PROSPECT_ID= p_prospectID;


                   dbms_output.put_line('Validate Site Geometry : '|| SDO_GEOM.VALIDATE_GEOMETRY(p_coordinates1,0.001));
                   dbms_output.put_line('l_prospect_name: '||l_prospect_name);
               Else
                    l_prospect_name := NULL;
               End if;


        dbms_output.put_line('l_PROSPECT_NAME: '||l_prospect_name);
      EXCEPTION

         when no_data_found then NULL;
         DBMS_OUTPUT.put_line('no_data_found sql error: ' || sqlerrm);
         dbms_output.put_line('no_data_found l_site_name: '||l_prospect_name);
         when too_many_rows then l_trade_area_exists := 1;
         DBMS_OUTPUT.put_line('sql error: ' || sqlerrm);
         dbms_output.put_line('l_site_name: '||l_prospect_name);
      END;


      IF l_prospect_name is not null THEN

           BEGIN
             select 1
             into  l_trade_area_exists
             from  TMCS_TRADEAREAS_PROSPECTS
             where PROSPECT_ID = p_prospectID;
           EXCEPTION
             when no_data_found then NULL;
             when too_many_rows then l_trade_area_exists := 1;
           END;

            --     dbms_output.put_line('l_trade_area_exists: '||l_trade_area_exists);

           BEGIN
             select 1
             into  l_prospect_exists
             from  TMCS_PROSPECTS
             where PROSPECT_ID = p_prospectID;
           EXCEPTION
             when no_data_found then NULL;
             when too_many_rows then l_prospect_exists := 1;
           END;

--              dbms_output.put_line('l_target_exists: '||l_Prospect_exists);

       l_tradearea_id := TMCS_TRADEAREAS_PROSPECTS_SQ.nextval;
            --     dbms_output.put_line('l_tradearea_id: '||l_tradearea_id);

           IF NVL(l_prospect_exists,-1) = 1 AND NVL(l_trade_area_exists,-1) = 1 THEN

              UPDATE  TMCS_TRADEAREAS_PROSPECTS
              SET     current_status = 'FALSE'
                      ,last_updated_by = l_Client_ID
                      ,last_update_Date = SYSDATE
              WHERE   PROSPECT_ID = p_prospectID and current_status= 'TRUE'
                      and BRAND = p_brand;
                --           dbms_output.put_line('Sucessfully UPDATED: ');

           ELSIF l_prospect_exists IS NULL THEN
              DELETE FROM TMCS_TRADEAREAS_PROSPECTS
              WHERE   PROSPECT_ID = p_prospectID;
              --        dbms_output.put_line('Sucessfully DELETED: ');
           END IF;

--            dbms_output.put_line('ORG_ID: '||l_regionID);
--             dbms_output.put_line('CLIENT_ID: '||l_Client_ID);
--              dbms_output.put_line('BRAND_ID: '||p_brand);

           IF  NVL(l_prospect_exists,-1) = 1 THEN
                 begin
                 --             dbms_output.put_line('BEGIN Inserted: ');

                  INSERT INTO TMCS_TRADEAREAS_PROSPECTS
                             (tradearea_id
                              ,PROSPECT_ID
                              ,brand_ID
                              ,geometry
                              ,description
                              ,current_status
                              ,created_by
                              ,creation_Date
                              ,last_updated_by
                              ,last_update_Date
                              ,approved_by
                              ,approved_on
                              ,Client_ID
                              ,ORG_ID
                              ,TA_TYPE
                              ,PRIMARY_FLAG
                             )
                  VALUES
                            (l_tradearea_id
                            ,p_prospectID
                            ,p_brand
                            ,p_coordinates
                            ,p_description
                            ,'TRUE'
                            ,p_user_name
                            ,sysdate
                            ,p_user_name
                            ,sysdate
                            ,NULL
                            ,NULL
                            ,l_Client_ID
                            ,l_regionID
                            ,'RETAIL'
                            ,'Y'
                            );

                    Select TMC_PACKAGE
                    into l_package
                    from TMCS_GIS_CLIENT_SETUP
                    where UPPER(TMC_Brand) =  l_TMCbrand
                    and UPPER(TMC_Functionality) = 'TA_DEMOGRAPHICS';

                    plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d,:e, :f ); END;';

                    --          dbms_output.put_line('plsql_block  --> ' || plsql_block);

                    EXECUTE IMMEDIATE plsql_block using l_tradearea_id,p_coordinates,'TRUE','PROSPECT',tmc_get_demo_table(TMCS_SEC_CTX.GET_CLIENT_ID),OUT p_message;

                     if p_message != 1 then
                        p_message := 5; -- TA Demographics Error
                     END IF;

                 Exception
                    WHEN OTHERS THEN
                    p_message := 4; --     Insert TA Error
                    rollback;
                     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('PROSPECT TA'
                                                                , 'TMC_MAINTAIN_PROSPECTS_TA'
                                                                , '4'
                                                                ,  'PROSPECT Tradearea INSERT Error  '
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
                 End;

           END IF;
           --dbms_output.put_line('TradeArea Insert: '||p_message);
      ELSE
        p_message := 10; -- Target Name is Null
        --dbms_output.put_line('TradeArea Insert: '||p_message);
      END IF;

      If p_message = 1 then
        COMMIT;
      ELSE
        ROLLBACK;
      END IF;

 EXCEPTION
     WHEN OTHERS THEN
        p_message := 3 || p_brand;    -- Trade Area Insert Error
        rollback;
     --dbms_output.put_line('FINAL SQL ERROR ' || sqlerrm);
 END;

FUNCTION SPLIT_STRING (p_in_string VARCHAR2, p_delim VARCHAR2) RETURN l_array
   IS

      i       number :=0;
      pos     number :=0;
      lv_str  varchar2(32767) := p_in_string;

   strings l_array;

   BEGIN

      -- determine first chuck of string
      pos := instr(lv_str,p_delim,1,1);

      if pos = 0 and p_in_string is not null then
          strings(1) := p_in_string;
      elsif pos > 0 then
	      -- while there are chunks left, loop
	      WHILE ( pos != 0) LOOP

	         -- increment counter
	         i := i + 1;

	         -- create array element for chuck of string
	         strings(i) := trim( both' ' from  replace(substr(lv_str,1,pos),p_delim));

	         -- remove chunk from string
	         lv_str := substr(lv_str,pos+1,length(lv_str));
	          --DBMS_OUTPUT.put_line('lv_str  -->'|| lv_str );
	         -- determine next chunk
	         pos := instr(lv_str,p_delim,1,1);

	         -- no last chunk, add to array
	         IF pos = 0 THEN

	            strings(i+1) := trim( both' ' from  replace(lv_str,p_delim));

	         END IF;

	      END LOOP;
		end if;
      -- return array
      RETURN strings;

   END SPLIT_STRING;
Procedure TMCS_ANALOG_SAVE_RESULTS(
                                        p_AnalogID  IN NUMBER
                                        ,P_SITE_ID   IN NUMBER
                                        ,P_STORE_IDs IN VARCHAR2
                                        ,p_user_name IN VARCHAR2
                                        ,p_tatype    IN NUMBER
                                        ,p_brand IN NUMBER
                                        ,p_message OUT VARCHAR2
                                        ) As
l_Client_ID NUMBER;
l_package VARCHAR2(3200);
plsql_block VARCHAR2(3200);
BEGIN
--    tmcs_sec_ctx. set_context(p_user_name);

   BEGIN
         Select Distinct(G_Client_ID)
         into l_Client_ID
         FROM TMCS_GLOB_BRAND_ACCESS_TMP
         where G_Brand_ID = (SELECT BRAND_ID  FROM TMCS_SITES_B WHERE SITE_ID = P_SITE_ID);
   EXCEPTION
        When no_data_found then
         p_message := 15; --User Brand Security Not Set
   END;


   BEGIN

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) =  l_Client_ID
        and UPPER(TMC_Functionality) = 'ANALOG_SAVE_RESULTS';
        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c,:d,:e,:f); END;';


        dbms_output.put_line(l_package||'l_text  --> ' || plsql_block);
        if  l_package is not null then
            EXECUTE IMMEDIATE plsql_block using p_AnalogID,P_SITE_ID,P_STORE_IDs,p_user_name,p_tatype,OUT p_message;
        Else
            dbms_output.put_line('l_package is null');
             p_message := 26; -- Analog Save Results Error
        End if;

   EXCEPTION
        when others then null;
        dbms_output.put_line('GET_CLASS SQL ERROR  --> '|| sqlerrm);
   END;

EXCEPTION
    When others then
    dbms_output.put_line(sqlerrm);
    p_message := 26; -- Analog Save Results Error
END;
Procedure TMCS_GET_OPTMIZATION(p_scenario_ID IN NUMBER
                                                        , p_user_name IN VARCHAR2
                                                        ,p_message OUT VARCHAR2
                                                        ) As
l_Client_ID VARCHAR2(320);
l_package VARCHAR2(3200);
plsql_block   VARCHAR2(3200);

Begin

--    tmcs_sec_ctx. set_context(p_user_name);

       BEGIN
         Select  TMCS_SEC_CTX.GET_CLIENT_ID()
         into l_Client_ID
         from Dual;

       EXCEPTION
            When no_data_found then
             p_message := 15; --User Brand Security Not Set
             dbms_output.put_line('p_message  --> ' || p_message);
       END;

    Select TMC_PACKAGE
    into l_package
    from TMCS_GIS_CLIENT_SETUP
    where UPPER(TMC_Brand) = l_Client_ID
    and UPPER(TMC_Functionality) = 'OPTIMIZATION';

    plsql_block := 'BEGIN '||l_package||'(:a, :b, :e); END;';


    if l_package is not null  then
        dbms_output.put_line('plsql_block  --> ' || plsql_block);
        EXECUTE IMMEDIATE plsql_block using  p_scenario_ID,p_user_name,OUT p_message;
    Else
         dbms_output.put_line('l_package is null');
         p_message := 27; -- Optimization Procedure Error
    End if;


Exception
    When others then
    p_message := 27;
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
End;
PROCEDURE TMCS_OSM_DT_ENGINE(p_longitude IN NUMBER
                          ,p_latitude IN NUMBER
                          ,p_DT_Min IN VARCHAR2
                          ,p_threshold IN Number
                          ,p_country IN VARCHAR2
                          ,p_output_table IN VARCHAR2
                          ,P_ID IN VARCHAR2
                          ,p_columnID IN VARCHAR2
                          ,p_brand_ID IN VARCHAR2 Default NULL
                          ,p_message OUT VARCHAR2) As
--p_longitude NUMBER;
--p_latitude NUMBER;
--p_DT_Min VARCHAR2(3200);
--p_threshold Number;
--p_country VARCHAR2(5);
--p_output_table VARCHAR2(320);
--P_ID VARCHAR2(320);
--p_brand_ID VARCHAR2(320); -- Default NULL;
--p_message VARCHAR2(32000);

    l_version VARCHAR2(100);
    l_URL VARCHAR2(500);
    l_Adomain VARCHAR2(3200);
    t_http_req     utl_http.req;
    t_http_resp    utl_http.resp;
    t_request_body varchar2(30000);
    t_respond      varchar2(30000);
    t_start_pos    integer := 1;
    t_output       varchar2(2000);
    l_raw_data       RAW(4000);
    l_clob_response  CLOB;
    l_buffer_size    NUMBER(10) := 100;
    value1 VARCHAR2(30000);
    value2 VARCHAR2(30000) := '';
    l_message VARCHAR2(32000);
    l_json JSON;
    l_start      NUMBER DEFAULT DBMS_UTILITY.get_time ;
Begin

  /*Construct the information you want to send to the webservice.
    Normally this would be in a xml structure. But for a REST-
    webservice this is not mandatory. The webservice i needed to
    call excepts plain test.*/


        BEGIN
            SELECT  DOMAIN,WIZARD_NAME
            INTO l_URL,l_version
            FROM TMCS_GIS_FUNCTIONALITY_SETUP
            WHERE CLIENT_ID   =  TMCS_SEC_CTX.GET_CLIENT_ID
            AND TMC_FUNCTIONALITY = UPPER('DRIVETIME');

        EXCEPTION
            WHEN no_data_found then null;
            BEGIN
                SELECT  DOMAIN,WIZARD_NAME
                INTO l_URL,l_version
                FROM TMCS_GIS_FUNCTIONALITY_SETUP
                WHERE CLIENT_ID  =  0
                AND TMC_FUNCTIONALITY = UPPER('DRIVETIME');

            EXCEPTION
                WHEN no_data_found then null;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('OSM DT Service'
                                                    , 'TMCS_OSM_DT_ENGINE'
                                                    , '15'
                                                    , 'Configuration not set for this DB Server'
                                                    , SQLERRM
                                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                                    , TMCS_SEC_CTX.GET_USER
                                                    );
            END;
            WHEN others then null;
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('OSM DT Service'
                                    , 'TMCS_OSM_DT_ENGINE'
                                    , '15'
                                    , 'Configuration not set for this  DB Server'
                                    , SQLERRM
                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                    , TMCS_SEC_CTX.GET_USER
                                    );
        END;

    t_request_body := 'lat='||p_latitude||'&'||'lon='||p_longitude||'&'||'minvals='||p_DT_Min||'&'||'res='||p_threshold||'&'||'cn='||p_country||'&'||'table='||p_output_table||'&'||p_columnID||'='||P_ID||'&'||'brand='||p_brand_ID;

    if l_version is not null then
        t_request_body := t_request_body || '&ver=' || l_version;
    End if;

    dbms_output.Put_line(t_request_body);
	dbms_output.put_line ('Starting DT calculations ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );
    dbms_output.Put_line(l_URL||'?'||t_request_body);
  /*Telling Oracle where the webservice can be found, what kind of request is made
    and the version of the HTTP*/
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('OSM DT Service'
                                            , 'TMCS_OSM_DT_ENGINE'
                                            , 'Webservice  Request Initiated : ' ||round((dbms_utility.get_time-l_start)/100, 2)  || 'Seconds..'
                                            , 'OSM DT'
                                            , l_URL||'?'||t_request_body
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER
                                            );

    utl_http.set_transfer_timeout(600);
  t_http_req:= utl_http.begin_request( l_URL||'?'||t_request_body);

  /*In my case the webservice used authentication with a username an password
    that was provided to me. You can skip this line if it's a public webservice.*/
  --utl_http.set_authentication(t_http_req,'username','password');

  /*Describe in the request-header what kind of data is send*/
  --utl_http.set_header(t_http_req, 'Content-Type', 'application/xml');
  --utl_http.set_header(t_http_req, 'User-Agent', 'Mozilla/4.0');


  /*Describe in the request-header the lengt of the data*/
  --utl_http.set_header(t_http_req, 'Content-Length', length(t_request_body));

  /*Put the data in de body of the request*/
  --utl_http.write_text(t_http_req, t_request_body);

  /*make the actual request to the webservice en catch the responce in a
    variable*/
  t_http_resp:= utl_http.get_response(t_http_req);

  /*Read the body of the response, so you can find out if the information was
    received ok by the webservice.
    Go to the documentation of the webservice for what kind of responce you
    should expect. In my case it was:
    <responce>
      <status>ok</status>
    </responce>
  */
  utl_http.set_transfer_timeout(600);
  --utl_http.read_text(t_http_resp, t_respond);
      BEGIN

            LOOP
            utl_http.READ_LINE(t_http_resp, value1, FALSE);
            DBMS_OUTPUT.PUT_LINE(value1);

            value2 := value2|| value1;
          END LOOP;

      EXCEPTION
                WHEN UTL_HTTP.end_of_body THEN
                    UTL_HTTP.end_response(t_http_resp);
        END;
--        DBMS_OUTPUT.PUT_LINE('step1: '||value2);
    Begin

        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('OSM DT Service'
                                            , 'TMCS_OSM_DT_ENGINE'
                                            , 'Webservice  Request Finished : ' ||round((dbms_utility.get_time-l_start)/100, 2)  || 'Seconds..'
                                            , 'OSM DT'
                                            , DBMS_LOB.SUBSTR(value2,2000,1)
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER
                                            );
                Begin

--                     DBMS_OUTPUT.PUT_LINE('step2: '||value2);
                    select EXTRACTVALUE(xmltype(value2), '/caluclateDTResponse/status')
                    into l_message
                    from dual;
                Exception
                    When others then
                    l_json := JSON(value2);
                    l_message := json_ext.get_string(l_json,'status');

                End;

                dbms_output.Put_line('l_message :'|| TO_CHAR(l_message));

                if   l_message = '0' then
                     p_message := 1;
                else
                     p_message := l_message;
                End if;

    Exception
        when others then
         NULL;
        p_message := 15; --User Brand Security Not Set
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('OSM DT Error'
                                            , 'TMCS_OSM_DT_ENGINE'
                                            , 'Webservice  Request Error : ' ||round((dbms_utility.get_time-l_start)/100, 2)  || 'Seconds..'
                                            , 'OSM DT'
                                            , DBMS_LOB.SUBSTR(sqlerrm,2000,1)
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER
                                            );
    End;
      dbms_output.Put_line('p_message :'|| TO_CHAR(p_message));
	  dbms_output.put_line ('Finished DT calculations ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );
Exception
When others then
 DBMS_OUTPUT.PUT_LINE('OSM Webservice Drive Time Error :' || sqlerrm);
 p_message := sqlerrm;
  UTL_HTTP.end_response(t_http_resp);
  TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('OSM DT Error'
                                        , 'TMCS_OSM_DT_ENGINE'
                                        , '99'
                                        ,  'General Error '
                                        , p_message
                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                        , TMCS_SEC_CTX.GET_USER
                                        );
End;
Procedure  TMCS_CALL_KETTLE_SERVICE(p_transformation VARCHAR2
                                                              , P_SEND_REQUEST VARCHAR2
                                                              , P_json  OUT JSON -- Out Parameters
                                                              , P_MESSAGE  OUT VARCHAR2 -- Out Parameters
                                                              ) As
l_env VARCHAR2(320);
l_instance  VARCHAR2(320);
l_SEND_REQUEST CLOB;
l_URL VARCHAR2(32767);
l_RESPONSE CLOB;

l_error VARCHAR2(320);
l_fields JSON;
l_outputRows json_list;
l_row JSON;
l_wktGeom CLOB;

l_start      NUMBER DEFAULT DBMS_UTILITY.get_time ;

Begin
    Begin
        -- Input Parameters
--        p_transformation:= 'CREATE_TADEF_WRITE_DB.ktr';
--        P_SEND_REQUEST:= 'LONGITUDE=-95.69697305581684'||'&'||'LATITUDE=39.03534907451821'||'&'||'SITE_ID=184479'||'&'||'STORE_CLASS=4'||'&'||'BRAND_ID=71'||'&'||'CBSA_CLASS=2'||'&'||'CLIENT_ID=36';


        Begin

            SELECT  DOMAIN
            INTO l_URL
            FROM TMCS_GIS_FUNCTIONALITY_SETUP
            WHERE CLIENT_ID       =  0
    --        AND COUNTRY           = TMCS_SEC_CTX.GET_COUNTRY_CODE
            AND TMC_FUNCTIONALITY = UPPER('KETTLE_SERVICE');

        Exception
            When others then
            DBMS_OUTPUT.PUT_LINE(sqlerrm);
--            l_URL := 'http://10.0.3.155:8080/transformation/';

        End;


        l_RESPONSE := NULL;
        dbms_output.put_line('P_URL = ' ||l_URL);

        l_URL := L_URL || p_transformation;

        dbms_output.put_line('Final P_URL = ' ||l_URL);
        dbms_output.put_line('P_SEND_REQUEST = ' ||P_SEND_REQUEST);

        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Kettle transformation Request'
                                            , 'TMCS_CALL_KETTLE_SERVICE'
                                            , 'Request sent to Kettle WebService'
                                            , l_URL
                                            ,  round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...'   || P_SEND_REQUEST
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );

        dbms_output.put_line ('Started Calling  Kettle Service :  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );
        -- Calling Rest Service
          TMCS_GIS_SLM_PKG_VN.TMCS_CALL_POST_REST_WEBSERVICE ( P_SEND_REQUEST, l_URL, l_RESPONSE );

        dbms_output.put_line ('Finished Calling  Kettle Service :  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

--       dbms_output.put_line(TO_CHAR(l_RESPONSE));
        -- Converting responce to  JSON
        P_json := JSON(l_RESPONSE);
--        P_json.print();

        dbms_lob.freetemporary(l_RESPONSE);

        if UPPER(json_ext.get_string(P_json,'message')) = 'SUCCESS' then
            NULL;
            P_MESSAGE := 1;
--             P_json.print();
--             dbms_output.put_line ('Error :'||l_error);
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Kettle transformation Request'
                                            , 'TMCS_CALL_KETTLE_SERVICE'
                                            , 'Request Received from  Kettle WebService'
                                            , l_URL
                                            , round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...'
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );
        Else
            l_error := UPPER(json_ext.get_string(P_json,'message'));
            dbms_output.put_line ('Error :'||l_error);
            P_MESSAGE := 64; --User Brand Security Not Set
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Kettle transformation Error'
                                            , 'TMCS_CALL_KETTLE_SERVICE'
                                            , P_MESSAGE
                                            , 'Kettle  Transformation error'
                                            , l_error
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                        , TMCS_SEC_CTX.GET_USER );
        End if;

        dbms_output.put_line ('Finished converting CLOB to JSON  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

    Exception
        When others then
        DBMS_OUTPUT.PUT_LINE('Error running Kettle WebService  : '||sqlerrm);
        P_MESSAGE := 65;
         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Kettle transformation Error'
                                            , 'TMCS_CALL_KETTLE_SERVICE'
                                            , P_MESSAGE || '  -  Error running Kettle WebService'
                                            , l_RESPONSE
                                            , sqlerrm
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );
          dbms_lob.freetemporary(l_RESPONSE);
    End;


Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
     P_MESSAGE := 65;
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Kettle transformation Error'
                                            , 'TMCS_CALL_KETTLE_SERVICE'
                                            , p_message
                                            , 'Kettle  Transformation error'
                                            , sqlerrm
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );
End;
Function TMCS_RECTIFY_POLY(p_Poly MDSYS.SDO_GEOMETRY) Return MDSYS.SDO_GEOMETRY as

p_coordinates1 MDSYS.SDO_GEOMETRY;

Begin

        Begin
            select sdo_util.rectify_geometry(p_Poly, 0.05)
            into p_coordinates1
            FROM DUAL;

        EXCEPTION
            when others then
            Select SDO_GEOM.SDO_UNION(p_Poly,p_Poly,0.05)
                        into p_coordinates1
                        from DUAL;
        END;

       return p_coordinates1;

Exception
    When others then
    Dbms_output.Put_line(sqlerrm);
End;
Function TMCS_SIMPLIFY_POLY(p_Poly MDSYS.SDO_GEOMETRY) Return MDSYS.SDO_GEOMETRY as

p_coordinates1 MDSYS.SDO_GEOMETRY;

Begin

        Begin
            select sdo_util.SIMPLIFY(p_Poly,10,0.05)
            into p_coordinates1
            FROM DUAL;

        EXCEPTION
            when others then
            Select SDO_GEOM.SDO_UNION(p_Poly,p_Poly,0.01)
                        into p_coordinates1
                        from DUAL;
        END;

       return p_coordinates1;

Exception
    When others then
    Dbms_output.Put_line(sqlerrm);
End;
 procedure TMCS_call_POST_rest_webservice(p_send_request VARCHAR2
                                                       ,p_URL VARCHAR2
                                                       ,p_response OUT VARCHAR2
                                                       ,p_GUID OUT VARCHAR2
                                                       )
as
  t_http_req     utl_http.req;
  t_http_resp    utl_http.resp;
  t_request_body varchar2(30000);
  t_respond      varchar2(30000);
  t_start_pos    integer := 1;
  t_output       varchar2(2000);
    l_raw_data       RAW(4000);
    l_clob_response  CLOB;
    l_buffer_size    NUMBER(10) := 100;

begin
  /*Construct the information you want to send to the webservice.
    Normally this would be in a xml structure. But for a REST-
    webservice this is not mandatory. The webservice i needed to
    call excepts plain test.*/
  t_request_body :=  p_send_request;


  /*Telling Oracle where the webservice can be found, what kind of request is made
    and the version of the HTTP*/
  t_http_req:= utl_http.begin_request(p_URL
                                     , 'POST'
                                     , 'HTTP/1.1');

  /*In my case the webservice used authentication with a username an password
    that was provided to me. You can skip this line if it's a public webservice.*/
  --utl_http.set_authentication(t_http_req,'username','password');

  /*Describe in the request-header what kind of data is send*/
  utl_http.set_header(t_http_req, 'Content-Type', 'application/json');
--  utl_http.set_header(t_http_req, 'Content-Type', 'application/x-www-form-urlencoded');
  /*Describe in the request-header the lengt of the data*/
  utl_http.set_header(t_http_req, 'Content-Length', length(t_request_body));

  /*Put the data in de body of the request*/
  utl_http.write_text(t_http_req, t_request_body);

  /*make the actual request to the webservice en catch the responce in a
    variable*/
  t_http_resp:= utl_http.get_response(t_http_req);

  /*Read the body of the response, so you can find out if the information was
    received ok by the webservice.
    Go to the documentation of the webservice for what kind of responce you
    should expect. In my case it was:
    <responce>
      <status>ok</status>
    </responce>
  */
  utl_http.read_text(t_http_resp, t_respond);
    UTL_HTTP.GET_HEADER_BY_NAME(t_http_resp,'Location',p_GUID);
    DBMS_OUTPUT.put_line('GUID'||p_GUID);

  /*Some closing?1 Releasing some memory, i think....*/
  utl_http.end_response(t_http_resp);
  p_response := t_respond;
    DBMS_OUTPUT.put_line('Response> length: ' || t_respond || '');

end;
procedure TMCS_call_POST_rest_webservice(p_send_request CLOB
                                                       ,p_URL VARCHAR2
                                                       ,p_response OUT CLOB
                                                       )
as
  t_http_req     utl_http.req;
  t_http_resp    utl_http.resp;
  t_request_body CLOB;
  t_respond      varchar2(30000);
  t_start_pos    integer := 1;
  t_output       varchar2(2000);
    l_clob_response  CLOB;

  l_chunkData VARCHAR2(32000);
  l_chunkStart NUMBER := 0;
  l_chunkLength NUMBER := 32000;

  l_raw_data       RAW(30000);
  l_buffer_size NUMBER := 25000;
  offset number := 1;
  amount NUMBER := 30000;


begin
  /*Construct the information you want to send to the webservice.
    Normally this would be in a xml structure. But for a REST-
    webservice this is not mandatory. The webservice i needed to
    call excepts plain test.*/
     t_request_body := empty_clob();
   dbms_lob.createtemporary(t_request_body, true);

   l_clob_response := empty_clob();
   dbms_lob.createtemporary(l_clob_response, true);

   p_response := empty_clob();
   dbms_lob.createtemporary(p_response, true);

  t_request_body :=  p_send_request;



    utl_http.set_transfer_timeout(1200);
  /*Telling Oracle where the webservice can be found, what kind of request is made
    and the version of the HTTP*/
  t_http_req:= utl_http.begin_request(p_URL
                                     , 'POST'
                                     , 'HTTP/1.1');

  /*In my case the webservice used authentication with a username an password
    that was provided to me. You can skip this line if it's a public webservice.*/
  --utl_http.set_authentication(t_http_req,'username','password');

  /*Describe in the request-header what kind of data is send*/
  utl_http.set_header(t_http_req, 'Content-Type', 'application/json');

  /*Describe in the request-header the lengt of the data*/
  utl_http.set_header(t_http_req, 'Content-Length', dbms_lob.getlength(t_request_body));

  /*Put the data in de body of the request*/

--  utl_http.write_text(t_http_req, TO_CHAR(t_request_body));

      loop
          l_chunkData := null;
--          l_chunkData := substr(t_request_body, l_chunkStart, l_chunkLength);
          DBMS_LOB.read(t_request_body,amount,offset,l_chunkData);
          utl_http.write_text(t_http_req, TO_CHAR(l_chunkData));
--          dbms_output.put_line('Chunk Data:'||l_chunkData);
--          l_chunkStart := l_chunkStart + l_chunkLength;
          offset := offset+amount;

          if ( offset >= dbms_lob.getlength(t_request_body)) then
            exit;
          end if;

    end loop;
--dbms_output.put_line('Chunk Data:'||l_chunkData);
-- dbms_output.put_line('size3 = ' ||dbms_lob.getlength(t_request_body));
  /*make the actual request to the webservice en catch the responce in a
    variable*/
  t_http_resp:= utl_http.get_response(t_http_req);

  /*Read the body of the response, so you can find out if the information was
    received ok by the webservice.
    Go to the documentation of the webservice for what kind of responce you
    should expect. In my case it was:
    <responce>
      <status>ok</status>
    </responce>
  */
  utl_http.set_transfer_timeout(1200);

--  utl_http.read_text(t_http_resp, l_clob_response);


     BEGIN
            <<response_loop>>
            LOOP
                UTL_HTTP.read_raw(t_http_resp, l_raw_data, l_buffer_size);
                 dbms_output.put_line('size4 = ' ||length(l_raw_data));
                l_clob_response := l_clob_response || UTL_RAW.cast_to_varchar2(l_raw_data);
            END LOOP response_loop;

     EXCEPTION
        WHEN UTL_HTTP.end_of_body THEN
        UTL_HTTP.end_response(t_http_resp);
--        dbms_output.put_line('UTL_HTTP.end_of_body = ' ||sqlerrm);
     END;


--      dbms_output.put_line('Completed reading response' );
  /*Some closing?1 Releasing some memory, i think....*/
--  utl_http.end_response(t_http_resp);
  dbms_output.put_line('response clob length = ' ||dbms_lob.getlength(l_clob_response));
  p_response := l_clob_response;
--    DBMS_OUTPUT.put_line('Response> length: ' || t_respond || '');
    dbms_lob.freetemporary(t_request_body);
    dbms_lob.freetemporary(l_clob_response);

Exception
When others then
DBMS_OUTPUT.PUT_LINE('Webservice Error'|| sqlerrm);
end;
procedure TMCS_call_GET_rest_webservice(p_URL VARCHAR2
                                                       ,p_response OUT CLOB
                                                       )
as
  t_http_req     utl_http.req;
  t_http_resp    utl_http.resp;
  t_request_body CLOB;
  t_respond      varchar2(30000);
  t_start_pos    integer := 1;
  t_output       varchar2(2000);
    l_clob_response  CLOB;

  l_chunkData VARCHAR2(32000);
  l_chunkStart NUMBER := 0;
  l_chunkLength NUMBER := 32000;

  l_raw_data       RAW(30000);
  l_buffer_size NUMBER := 25000;
  offset number := 1;
  amount NUMBER := 30000;


begin
  /*Construct the information you want to send to the webservice.
    Normally this would be in a xml structure. But for a REST-
    webservice this is not mandatory. The webservice i needed to
    call excepts plain test.*/

   l_clob_response := empty_clob();
   dbms_lob.createtemporary(l_clob_response, true);

   p_response := empty_clob();
   dbms_lob.createtemporary(p_response, true);

    utl_http.set_transfer_timeout(600);
  /*Telling Oracle where the webservice can be found, what kind of request is made
    and the version of the HTTP*/
  t_http_req:= utl_http.begin_request(p_URL
                                     , 'GET'
                                     , 'HTTP/1.1');

  /*In my case the webservice used authentication with a username an password
    that was provided to me. You can skip this line if it's a public webservice.*/
  --utl_http.set_authentication(t_http_req,'username','password');
--dbms_output.put_line('Chunk Data1:'||l_chunkData);
  /*Describe in the request-header what kind of data is send*/
--  utl_http.set_header(t_http_req, 'Content-Type', 'application/json');

  /*Describe in the request-header the lengt of the data*/
--  utl_http.set_header(t_http_req, 'Content-Length', dbms_lob.getlength(t_request_body));
--dbms_output.put_line('Chunk Data:'||l_chunkData);
  /*Put the data in de body of the request*/


-- dbms_output.put_line('size3 = ' ||dbms_lob.getlength(t_request_body));
  /*make the actual request to the webservice en catch the responce in a
    variable*/
  t_http_resp:= utl_http.get_response(t_http_req);

  /*Read the body of the response, so you can find out if the information was
    received ok by the webservice.
    Go to the documentation of the webservice for what kind of responce you
    should expect. In my case it was:
    <responce>
      <status>ok</status>
    </responce>
  */
  utl_http.set_transfer_timeout(600);
--  utl_http.read_text(t_http_resp, l_clob_response);

     BEGIN
            <<response_loop>>
            LOOP
                UTL_HTTP.read_raw(t_http_resp, l_raw_data, l_buffer_size);
                 dbms_output.put_line('size4 = ' ||length(l_raw_data));
                l_clob_response := l_clob_response || UTL_RAW.cast_to_varchar2(l_raw_data);
            END LOOP response_loop;

     EXCEPTION
        WHEN UTL_HTTP.end_of_body THEN
        UTL_HTTP.end_response(t_http_resp);
--        dbms_output.put_line('UTL_HTTP.end_of_body = ' ||sqlerrm);
     END;


--      dbms_output.put_line('Completed reading response' );
  /*Some closing?1 Releasing some memory, i think....*/
--   utl_http.end_response(t_http_resp);
  dbms_output.put_line('response clob length = ' ||dbms_lob.getlength(l_clob_response));
  p_response := l_clob_response;
--    DBMS_OUTPUT.put_line('Response> length: ' || t_respond || '');
--    dbms_lob.freetemporary(t_request_body);
    dbms_lob.freetemporary(l_clob_response);

Exception
When others then
DBMS_OUTPUT.PUT_LINE('Webservice Error'|| sqlerrm);
UTL_HTTP.END_RESPONSE(t_http_resp);
end;
procedure TMCS_call_GET_rest_webservice(p_send_request VARCHAR2
                                                       , p_URL VARCHAR2
                                                       ,p_response OUT VARCHAR2
                                                       )
as
  t_http_req     utl_http.req;
  t_http_resp    utl_http.resp;
  t_request_body varchar2(30000);
  t_respond      varchar2(30000);
  t_start_pos    integer := 1;
  t_output       varchar2(2000);
    l_raw_data       RAW(4000);
    l_clob_response  CLOB;
    l_buffer_size    NUMBER(10) := 100;

begin
  /*Construct the information you want to send to the webservice.
    Normally this would be in a xml structure. But for a REST-
    webservice this is not mandatory. The webservice i needed to
    call excepts plain test.*/
  t_request_body :=  p_send_request;


  /*Telling Oracle where the webservice can be found, what kind of request is made
    and the version of the HTTP*/
  t_http_req:= utl_http.begin_request(p_URL
                                     , 'GET'
                                     , 'HTTP/1.1');

  /*In my case the webservice used authentication with a username an password
    that was provided to me. You can skip this line if it's a public webservice.*/
  --utl_http.set_authentication(t_http_req,'username','password');

  /*Describe in the request-header what kind of data is send*/
--  utl_http.set_header(t_http_req, 'Content-Type', 'application/json');

  /*Describe in the request-header the lengt of the data*/
  utl_http.set_header(t_http_req, 'Content-Length', length(t_request_body));

  /*Put the data in de body of the request*/
 utl_http.write_text(t_http_req, t_request_body);

  /*make the actual request to the webservice en catch the responce in a
    variable*/
  t_http_resp:= utl_http.get_response(t_http_req);

  /*Read the body of the response, so you can find out if the information was
    received ok by the webservice.
    Go to the documentation of the webservice for what kind of responce you
    should expect. In my case it was:
    <responce>
      <status>ok</status>
    </responce>
  */
  utl_http.read_text(t_http_resp, t_respond);
    DBMS_OUTPUT.put_line (t_respond);
  /*Some closing?1 Releasing some memory, i think....*/
  utl_http.end_response(t_http_resp);
  p_response := t_respond;
--    DBMS_OUTPUT.put_line('Response> length: ' || t_respond || '');
Exception
When others then
    DBMS_OUTPUT.put_line ('GET  Rest Web Service Error' || sqlerrm);
end;
Procedure TMCS_GET_REST_W_HEADERS(p_URL VARCHAR2
                                 ,p_response OUT CLOB) As

--    p_URL VARCHAR2(3200) := 'http://10.0.4.110/taservices/rest/emailservices/send?template=APPROVAL_REJECT_EMAIL'||'&'||'to=vamsi.nagavalli@tangoanalytics.com'||'&'||'p_user=vn'||'&'||'p_batchID=141197';
--    p_response CLOB;

t_http_req     utl_http.req;
t_http_resp    utl_http.resp;
l_clob_response  CLOB;
l_raw_data       RAW(30000);
l_buffer_size NUMBER := 25000;
l_client_ID       varchar2(2000);
l_user       varchar2(2000);
l_country_Code       varchar2(2000);
l_client_Code       varchar2(2000);
l_brand_ID       varchar2(2000);
l_bu_ID       varchar2(2000);
l_start      NUMBER DEFAULT DBMS_UTILITY.get_time ;

begin
  /*Construct the information you want to send to the webservice.
    Normally this would be in a xml structure. But for a REST-
    webservice this is not mandatory. The webservice i needed to
    call excepts plain test.*/

   l_clob_response := empty_clob();
   dbms_lob.createtemporary(l_clob_response, true);

   p_response := empty_clob();
   dbms_lob.createtemporary(p_response, true);

    utl_http.set_transfer_timeout(600);
  /*Telling Oracle where the webservice can be found, what kind of request is made
    and the version of the HTTP*/
  t_http_req:= utl_http.begin_request(p_URL
                                     , 'GET'
                                     , 'HTTP/1.1');

  /*In my case the webservice used authentication with a username an password
    that was provided to me. You can skip this line if it's a public webservice.*/
  --utl_http.set_authentication(t_http_req,'username','password');

    l_client_ID := TO_CHAR(TMCS_SEC_CTX.GET_CLIENT_ID);
    l_user := TO_CHAR(TMCS_SEC_CTX.GET_USER);
    l_country_Code := TO_CHAR(TMCS_SEC_CTX.GET_COUNTRY_CODE);
    l_client_Code := TO_CHAR(TMCS_SEC_CTX.GET_CLIENT_CODE(l_user));
    l_brand_ID := TO_CHAR(TMCS_SEC_CTX.get_brand_id);
    l_bu_ID := TO_CHAR(TMCS_SEC_CTX.GET_BU_ID);

    IF l_client_Code is null then

        Select client_code
        into l_client_Code
        from  TMCS_CLIENTS
        where CLIENT_ID = l_client_ID;
    End if;

    dbms_output.put_line('l_client_ID :'||l_client_ID);
    dbms_output.put_line('l_user :'||l_user);
    dbms_output.put_line('l_country_Code :'||l_country_Code);
    dbms_output.put_line('l_client_Code :'||l_client_Code);
    dbms_output.put_line('l_brand_ID :'||l_brand_ID);
    dbms_output.put_line('l_bu_ID :'||l_bu_ID);

  /*Describe in the request-header what kind of data is send*/
    utl_http.set_header(t_http_req, 'Content-Type', 'application/x-www-form-urlencoded');
    utl_http.set_header(t_http_req, 'X-SECRETKEY', '72228c7c-4647-11e7-a919-92ebcb67fe33');
    utl_http.set_header(t_http_req, 'X-SYSTEMID', 'GIS');
    utl_http.set_header(t_http_req, 'X-TA_CLIENT_ID', l_client_ID);
    utl_http.set_header(t_http_req, 'X-TA_USERNAME', l_user);
    utl_http.set_header(t_http_req, 'X-TA_COUNTRY_CD', l_country_Code);
    utl_http.set_header(t_http_req, 'X-TA_CLIENT_CODE', l_client_Code);
    utl_http.set_header(t_http_req, 'X-TA_BRAND_ID', l_brand_ID);
    utl_http.set_header(t_http_req, 'X-TA_BU_ID', l_bu_ID);

     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Rest Webservice with Headsers'
                                            , 'TMCS_GET_REST_W_HEADERS'
                                            , '65'
                                            ,p_URL
                                            , 'l_client_ID :'||l_client_ID ||';l_user:'||l_user||',l_country_Code:'||l_country_Code||';l_client_Code:'||l_client_Code||';l_brand_ID:'||l_brand_ID||';l_bu_ID:'||l_bu_ID
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );


  /*make the actual request to the webservice en catch the responce in a
    variable*/
  t_http_resp:= utl_http.get_response(t_http_req);

  /*Read the body of the response, so you can find out if the information was
    received ok by the webservice.
    Go to the documentation of the webservice for what kind of responce you
    should expect. In my case it was:
    <responce>
      <status>ok</status>
    </responce>
  */
  utl_http.set_transfer_timeout(600);
--  utl_http.read_text(t_http_resp, l_clob_response);

     BEGIN
            <<response_loop>>
            LOOP
                UTL_HTTP.read_raw(t_http_resp, l_raw_data, l_buffer_size);
                 dbms_output.put_line('size4 = ' ||length(l_raw_data));
                l_clob_response := l_clob_response || UTL_RAW.cast_to_varchar2(l_raw_data);
            END LOOP response_loop;

     EXCEPTION
        WHEN UTL_HTTP.end_of_body THEN
        UTL_HTTP.end_response(t_http_resp);
--        dbms_output.put_line('UTL_HTTP.end_of_body = ' ||sqlerrm);
     END;



    dbms_output.put_line('response clob length = ' ||dbms_lob.getlength(l_clob_response));
    dbms_output.put_line('response = ' ||l_clob_response);
    p_response := l_clob_response;
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Rest Webservice with Headsers'
                                            , 'TMCS_GET_REST_W_HEADERS'
                                            , 'Request Received from WebService'
                                            , p_URL
                                            , round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...'
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );

    dbms_lob.freetemporary(l_clob_response);
Exception
    When others then
    DBMS_OUTPUT.PUT_LINE('Webservice Error'|| sqlerrm);
    UTL_HTTP.END_RESPONSE(t_http_resp);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Rest Webservice with Headsers'
                                            , 'TMCS_GET_REST_W_HEADERS'
                                            , '65'
                                            , 'Rest Service Error'
                                            , sqlerrm
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );
end;
Procedure TMC_GET_SALESTRANSFER( p_message out VARCHAR2
                     ,p_brand   IN   VARCHAR2
                     ,p_STOREID    in  NUMBER
                      ,p_user_name in VARCHAR2
                            ) As
    l_package VARCHAR2(32000);
    plsql_block VARCHAR2(500);
    l_TMCbrand  VARCHAR2(10);
    l_Client_ID NUMBER;
    l_StoreNumber Varchar2(50);
 BEGIN

--     tmcs_sec_ctx. set_context(p_user_name);

   BEGIN
    Select G_Client_ID
     into l_Client_ID
     from tmcs_glob_brand_access_tmp
     where G_Brand_ID = p_brand;
      dbms_output.put_line('l_Client_ID  --> ' || l_Client_ID);
   EXCEPTION
        When no_data_found then
         p_message := 15; --User Brand Security Not Set
         dbms_output.put_line('p_message  --> ' || p_message);
   END;

    If p_message is null then
        Begin
            Select TMC_PACKAGE
            into l_package
            from TMCS_GIS_CLIENT_SETUP
            where UPPER(TMC_Brand) =  l_Client_ID
            and UPPER(TMC_Functionality) = 'ST_REPORT';

            plsql_block := 'BEGIN '||l_package||'(:a, :b,:c); END;';

            dbms_output.put_line('plsql_block  --> ' || plsql_block);
             if l_package is not null then
                EXECUTE IMMEDIATE plsql_block using  p_STOREID,p_user_name,OUT p_message;
            End if;

        Exception
            When others then
             dbms_output.put_line('get l_package error  --> ' || sqlerrm);
        End ;
    End if;

 EXCEPTION
        when others then null;
         p_message := 99;
        DBMS_OUTPUT.put_line('sql error: ' || sqlerrm);
 END;
PROCEDURE TMCS_DELETE_DATA_COMMIT(p_table_name VARCHAR2
                                                                ,p_whereClause VARCHAR2)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
l_sqlString VARCHAR2(3200);
BEGIN

    l_sqlString := 'Delete from '||p_table_name|| ' Where '||p_whereClause;
    DBMS_OUTPUT.PUT_LINE('l_sqlString '||l_sqlString);
    Execute Immediate l_sqlString;

    COMMIT;
EXCEPTION
   When others then
   DBMS_OUTPUT.PUT_LINE('TMCS_DELETE_DATA_COMMIT :' ||sqlerrm);
END;
PROCEDURE  TMCS_INSERT_ERROR_LOG(p_ENTITY_TYPE             IN VARCHAR2
                                                            , p_FUNCTIONALITY             IN VARCHAR2
                                                            , p_ERROR_CODE             IN VARCHAR2
                                                            , p_TMC_MESSAGE            IN VARCHAR2
                                                            , p_ERROR_MESSAGE     IN VARCHAR2
                                                            , p_CLIENT_ID                 in NUMBER
                                                            , p_USER_Name                 IN VARCHAR2
                                                            )
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    INSERT INTO  TMCS_GIS_ERROR_LOG
    (
    ERROR_ID
    ,ENTITY_TYPE
    ,FUNCTIONALITY
    ,ERROR_CODE
    ,TMC_MESSAGE
    ,ERROR_MESSAGE
    ,CLIENT_ID
    ,BRAND_ID
    ,CREATION_DATE
    ,CREATED_BY
    ,LAST_UPDATE_DATE
    ,LAST_UPDATED_BY
    ,COUNTRY
    )
    VALUES
    (
    TMCS_GIS_ERR_S.NEXTVAL
    , p_ENTITY_TYPE
    , p_FUNCTIONALITY
    , p_ERROR_CODE
    , p_TMC_MESSAGE
    , p_ERROR_MESSAGE
    , p_CLIENT_ID
    , TMCS_SEC_CTX.GET_BRAND_ID
    , SYSDATE
    , p_USER_Name
    , SYSDATE
    , TMCS_SEC_CTX.GET_USER
    , TMCS_SEC_CTX.GET_COUNTRY_CODE
    );

Commit;

EXCEPTION
    When others THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
End ;
Function tmc_get_demo_table(Client_ID NUMBER) return VARCHAR2 is

 l_demo_table VARCHAR2(32);
Begin
     Begin
            Select DEMOGRAPHICS
            into l_demo_table
            from TMCS_GIS_CLIENT_SETUP
            where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID
            and UPPER(TMC_Functionality) = 'TA_DEMOGRAPHICS';

     Exception
        When no_data_found then
        l_demo_table := 'TMCS_BLK_STI_Q213_DATA';
        When others then
        l_demo_table := 'TMCS_BLK_STI_Q213_DATA';
     End;

    return l_demo_table;
Exception
  When others then return('FALSE');
End;
PROCEDURE TMC_MAINTAIN_MARKETS
                             (p_message OUT VARCHAR2,
                            p_status OUT VARCHAR2,
                            p_geom  IN MDSYS.SDO_GEOMETRY,
                            p_json IN VARCHAR2) AS
    l_start number default dbms_utility.get_time;
    l_package VARCHAR2(32000);
    plsql_block VARCHAR2(500);
    l_TMCbrand  VARCHAR2(10);
    l_Client_ID VARCHAR2(32);
 BEGIN

    BEGIN

        Select G_Client_ID
        into l_Client_ID
        from tmcs_glob_brand_access_tmp
        where G_Brand_ID = json_ext.get_string(JSON(p_json),'p_brand');

    EXCEPTION

        When no_data_found then
         p_message := 15; --User Brand Security Not Set
         p_status := sqlerrm;
         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                            , 'TMC_MAINTAIN_SITES'
                                                            , '15'
                                                            , 'Security Not Set Properly'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            ,  TMCS_SEC_CTX.GET_USER
                                                            );
    END;

    IF l_Client_ID is not null  then

        Begin
            Select TMC_PACKAGE
            into l_package
            from TMCS_GIS_CLIENT_SETUP
            where UPPER(TMC_Brand) =  l_Client_ID
            and UPPER(TMC_Functionality) = 'MAINTAIN_MARKETS';

            plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d ); END;';

            dbms_output.put_line('plsql_block  --> ' || plsql_block);

            EXECUTE IMMEDIATE plsql_block using OUT p_message, OUT p_status,p_geom,p_json;
        Exception
            When others then
            p_message := 9; --User Brand Security Not Set
            p_status := sqlerrm;
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                            , 'TMC_MAINTAIN_MARKETS'
                                                            , '9'
                                                            , 'Setup Not Complete'
                                                            , sqlerrm
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
        End;

    Else

          p_message := 15; --User Brand Security Not Set
         p_status := 'Context not setup properly';
         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                            , 'TMC_MAINTAIN_MARKETS'
                                                            , '15'
                                                            , 'Security Not Set Properly'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            ,  TMCS_SEC_CTX.GET_USER
                                                            );
    END IF;

    If p_message = 1 then
        COMMIT;
    Else
        Rollback;
    End if;
    dbms_output.put_line ('Finished  Running  TMC_MAINTAIN_MARKETS in  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

 Exception
    WHEN OTHERS THEN
    p_message := 99;
    p_status := SQLERRM;
    dbms_output.put_line('TMC_MAINTAIN_MARKETS SQL ERROR ' || sqlerrm);
     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Maintain Markets'
                                                      , 'TMC_MAINTAIN_MARKETS'
                                                      , '99'
                                                      , 'General Error'
                                                      , sqlerrm
                                                      , TMCS_SEC_CTX.GET_CLIENT_ID
                                                      , TMCS_SEC_CTX.GET_USER
                                                      );
 END;
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
                                ) As
l_competitorID NUMBER;
l_StoreNUMBER VARCHAR2(320);
l_geometry MDSYS.SDO_GEOMETRY;
l_Client_ID NUMBER;
l_error VARCHAr2(32000);
l_package VARCHAR2(320);
plsql_block VARCHAR2(420);

Begin

      l_geometry := SDO_GEOMETRY(2001, 8307,SDO_POINT_TYPE(p_longitude,p_latitude,NULL),NULL, NULL);

        Begin
             Select  TMCS_SEC_CTX.GET_CLIENT_ID
             into l_Client_ID
             from dual;

             if l_Client_ID is  null then
                p_message := 15;  -- USER Brand Security is not set
                l_error := sqlerrm;
               TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Competitor'
                                                                    , 'TMC_MAINTAIN_COMPETITORS'
                                                                    , '15'
                                                                    , 'Security Not Set Properly'
                                                                    , SQLERRM
                                                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                    , TMCS_SEC_CTX.GET_USER
                                                                    );
             End if;


        Exception
            when no_data_found then
            p_message := 15;  -- USER Brand Security is not set
            l_error := sqlerrm;
           TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Competitor'
                                                                , 'TMC_MAINTAIN_COMPETITORS'
                                                                , '15'
                                                                , 'Security Not Set Properly'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
        End;

        If p_message is null then

                Begin

                    Select TMCS_ALL_COMPETITORS_S.nextval
                    into l_competitorID
                    from DUAL;

                    INSERT into  TMCS_ALL_COMPETITORS
                    (
                        COMPETITOR_ID
                        ,STORE_NAME
                        ,STORE_NUMBER
                        ,ADDRESS
                        ,CITY
                        ,STATE
                        ,ZIP
                        ,COUNTRY
                        ,CLIENT_ID
                        ,BRAND_ID
                        ,STATUS
                        ,COMP_SOURCE
                        ,GEOMETRY
                        ,LATITUDE
                        ,LONGITUDE
                        ,GROUP_LEVEL1
                        ,GROUP_LEVEL2
                        ,CREATION_DATE
                        ,CREATED_BY
                        ,LAST_UPDATE_DATE
                        ,LAST_UPDATED_BY
                    )
                    VALUES
                    (
                        l_competitorID
                        ,p_Comp_name
                        ,l_competitorID
                        ,p_address
                        ,p_city
                        ,p_state
                        ,p_zip_code
                        ,TMCS_SEC_CTX.GET_COUNTRY_CODE
                        ,TMCS_SEC_CTX.GET_CLIENT_ID
                        ,TMCS_SEC_CTX.GET_BRAND_ID
                        ,TMCS_GET_DEFAULT_STATUS('OP','COMPETITOR')
                        ,'CUSTOM'
                        ,l_geometry
                        ,p_latitude
                        ,p_longitude
                        ,p_level1
                        ,p_level2
                        ,sysdate
                        ,TMCS_SEC_CTX.GET_USER
                        ,sysdate
                        ,TMCS_SEC_CTX.GET_USER
                    );

                Exception
                    When others then
                    p_message := 40; -- This mean there is a violation while creating the target
                    l_error := sqlerrm;
                    dbms_output.put_line('Insert Error :'|| sqlerrm);
                 TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Competitor'
                                                                , 'TMC_MAINTAIN_COMPETITORS'
                                                                , '40'
                                                                ,  'This mean there is a violation while creating the competitor  '
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
                End;

                  if p_message is null then

                     BEGIN
                           TMCS_UPDATE_STD_ATTRIBUTES(p_message
                                                                   ,'COMPETITOR'
                                                                   ,l_competitorID
                                                                   , l_geometry);

                     EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 14; --Error while updating Standard Attributes
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Competitor'
                                                            , 'TMC_MAINTAIN_SITES'
                                                            , '14'
                                                            ,  'STANDARD_ATTR_UPDATE Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
                     END;


                      BEGIN

                            Select TMC_PACKAGE
                            into l_package
                            from TMCS_GIS_CLIENT_SETUP
                            where UPPER(TMC_Brand) = l_Client_ID
                            and UPPER(TMC_Functionality) = 'UPDATE_COMPETITORS';
                            plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d,:e); END;';


                            dbms_output.put_line('l_text  --> ' || plsql_block);

                            if l_package is not null then
                                EXECUTE IMMEDIATE plsql_block using OUT p_message,l_competitorID,p_attr1,p_attr2,p_attr3;
                            Else
                                p_message := 1;
                            End if;

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 41; --Error while updating Standard Attributes
                            l_error := sqlerrm;
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Competitor'
                                                                    , 'TMC_MAINTAIN_COMPETITORS'
                                                                    , '41'
                                                                    ,  'UPDATE_COMPETITORS ' || ' Client Specific Procedure Not Found'
                                                                    , SQLERRM
                                                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                    , TMCS_SEC_CTX.GET_USER
                                                                    );
                      END;

                   End if;

        End if;

        if p_message = 1 then
            Commit;
        Else
            Rollback;
        End if;


Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
End;
Procedure TMCS_MAINTAIN_COMP_EVENTS(P_MESSAGE OUT VARCHAR2
                                    ,P_JSON IN VARCHAR2) AS
l_param1 VARCHAR2(32000);
l_param2 VARCHAR2(32000);
l_param3 VARCHAR2(32000);
l_param4 VARCHAR2(32000);
l_param5 VARCHAR2(32000);

l_eventID     NUMBER;
l_clientID     NUMBER;
l_brand_ID     NUMBER;
l_org_ID    NUMBER;
BEGIN

    -- Getting values from JSON
    l_param1    := json_ext.get_string(JSON(P_JSON),'p_CompID');
    l_param2    := json_ext.get_string(JSON(P_JSON),'p_eventType');


    BEGIN
        -- Getting Basic Client Information from associated Competitor
        BEGIN
            Select CLIENT_ID,BRAND_ID,ORG_ID
            into l_clientID,l_brand_ID,l_org_ID
            from TMCS_ALL_COMPETITORS
            where COMPETITOR_ID = l_param1;
        EXCEPTION
            When others then
            DBMS_OUTPUT.PUT_LINE(sqlerrm);
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Competitor Events'
                                                , 'TMCS_MAINTAIN_COMP_EVENTS'
                                                , '90'
                                                , 'No Associated Competitor found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
            l_clientID := TMCS_SEC_CTX.GET_CLIENT_ID;
            l_brand_ID := TMCS_SEC_CTX.GET_BRAND_ID;
            l_org_ID   := NULL;
        End;

        l_eventID := TMCS_COMPETITOR_EVENTS_S.nextval;

        -- Inserting into table
        Insert into TMCS_COMPETITOR_EVENTS
        (
          EVENT_ID
        , EVENT_TYPE
        , COMPETITOR_ID
        , STATUS
        , ORG_ID
        , CLIENT_ID
        , BRAND_ID
        , CREATED_BY
        , CREATION_DATE
        , LAST_UPDATED_BY
        , LAST_UPDATE_DATE
        )
        VALUES
        (
          l_eventID
        , l_param2
        , l_param1
        , TMCS_GET_DEFAULT_STATUS('AC','COMPETITOREVENT')
        , l_org_ID
        , l_clientID
        , l_brand_ID
        , TMCS_SEC_CTX.GET_USER
        , sysdate
        , TMCS_SEC_CTX.GET_USER
        , sysdate
        );
        P_MESSAGE := 1;

    EXCEPTION
        When others then
        DBMS_OUTPUT.PUT_LINE(sqlerrm);
        P_MESSAGE := 91;
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Competitor Events'
                                            , 'TMCS_MAINTAIN_COMP_EVENTS'
                                            , '91'
                                            ,  'CREATE Competitor Events '
                                            , SQLERRM
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER
                                            );
    END;

EXCEPTION
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    P_MESSAGE := 99;
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Competitor Events'
                                        , 'TMCS_MAINTAIN_COMP_EVENTS'
                                        , '99'
                                        , 'General Error'
                                        , SQLERRM
                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                        , TMCS_SEC_CTX.GET_USER
                                        );
END;
Procedure GEOM_STRING_TO_SDOPOLY(p_geomString IN CLOB
                                ,p_geomStringType IN VARCHAR2
                                ,p_aggPoly OUT SDO_GEOMETRY
                                ,p_stitch IN VARCHAR2 DEFAULT 'TRUE') AS

l_ID VARCHAR2(320) := 'T1';
lageomCol MDSYS.sdoaggrtype;
numPoly NUMBER;
geom  SDO_GEOMETRY;
checkPoly   SDO_GEOMETRY;
checkPolyStatus VARCHAR2(320);
Begin
    NULL;
Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    p_aggPoly := NULL;

End;
PROCEDURE TMC_MAINTAIN_ENTITIES
                             (p_message OUT VARCHAR2,
                            p_status OUT VARCHAR2,
                            p_geom  IN MDSYS.SDO_GEOMETRY,
                            p_json IN VARCHAR2) as
        l_start number default dbms_utility.get_time;

        l_entityID NUMBER;
        l_geom MDSYS.SDO_GEOMETRY;
        l_package VARCHAR2(32000);
        plsql_block VARCHAR2(500);
        l_TMCbrand  VARCHAR2(10);
        l_Client_ID VARCHAR2(32);
        l_entitytype VARCHAr2(3200);
        l_param1 VARCHAR2(32000);
        l_param2 VARCHAR2(32000);
        l_param3 VARCHAR2(32000);
        l_param4 VARCHAR2(32000);
        l_param5 VARCHAR2(32000);
        l_param6 VARCHAR2(32000);
        l_param7 VARCHAR2(32000);
        l_param8 VARCHAR2(32000);
        l_param9 VARCHAR2(32000);
        l_param10 VARCHAR2(32000);
        l_param11 VARCHAR2(32000);
        l_param12 VARCHAR2(32000);
        l_param13 VARCHAR2(32000);
        l_param14 VARCHAR2(32000);
        l_param15 VARCHAR2(32000);
Begin

    l_entitytype    := json_ext.get_string(JSON(p_json),'entitytype');

    case (upper(l_entitytype))
        when 'COMPETITOR' THEN
        l_param1 :=  json_ext.get_string(JSON(p_json),'name'); --p_Comp_name;
        l_param2 := json_ext.get_string(JSON(p_json),'longitude'); --p_longitude;
        l_param3 := json_ext.get_string(JSON(p_json),'latitude'); --p_latitude;
        l_param4 := json_ext.get_string(JSON(p_json),'address'); --p_address;
        l_param5 := json_ext.get_string(JSON(p_json),'city'); --p_city;
        l_param6 := json_ext.get_string(JSON(p_json),'state'); --p_state;
        l_param7 := json_ext.get_string(JSON(p_json),'country'); --p_country;
        l_param8 := json_ext.get_string(JSON(p_json),'zip'); --p_zip_code;
        l_param9 := json_ext.get_string(JSON(p_json),'param1'); --p_attr1;
        l_param10 := json_ext.get_string(JSON(p_json),'param2'); --p_attr2;
        l_param11 := json_ext.get_string(JSON(p_json),'param3'); --p_attr3;
        l_param12 := json_ext.get_string(JSON(p_json),'user'); --p_user_name;

        l_param13 := json_ext.get_string(JSON(p_json),'level1'); -- group level1;
        l_param14 := json_ext.get_string(JSON(p_json),'level2'); --group level 2;

            TMC_MAINTAIN_COMPETITORS
                                (p_message
                                ,l_param1
                                ,l_param2
                                ,l_param3
                                ,l_param4
                                ,l_param5
                                ,l_param6
                                ,l_param7
                                ,l_param8
                                ,l_param9
                                ,l_param10
                                ,l_param11
                                ,l_param12
                                ,l_param13
                                ,l_param14
                                );

        WHEN 'TERRITORY' THEN
            TMC_MAINTAIN_MARKETS
                             (p_message,
                            p_status,
                            p_geom,
                            p_json);

        WHEN 'CUSTOM_TA' THEN
            l_param1 :=  json_ext.get_string(JSON(p_json),'p_site_id'); --p_site_id;
            l_param2 := json_ext.get_string(JSON(p_json),'p_user'); --p_user_name;
            l_param3 := json_ext.get_string(JSON(p_json),'p_trade_area_type'); --p_trade_area_type;
            l_param4 := json_ext.get_string(JSON(p_json),'p_description'); --p_description;
            l_param5 := json_ext.get_string(JSON(p_json),'p_brand'); --p_brand;
                TMC_MAINTAIN_TRADEAREAS
                                    (p_message
                                     ,l_param1
                                     ,l_param2
                                     ,l_param3
                                     ,l_param4
                                     ,l_param5
                                     ,p_geom
                                     );
         WHEN 'STANDARD_TA' THEN
            l_param1 :=  json_ext.get_string(JSON(p_json),'p_site_id'); --p_site_id;
            l_param2 := json_ext.get_string(JSON(p_json),'p_user'); --p_user_name;
            l_param3 := json_ext.get_string(JSON(p_json),'p_trade_area_type'); --p_trade_area_type RING/DRIVETIME;
            l_param4 := json_ext.get_string(JSON(p_json),'p_DTmin'); --p_description;
            l_param5 := json_ext.get_string(JSON(p_json),'p_brand'); --p_brand;
               tmc_DT_SiteTA(   l_param1
                                        , l_param2
                                        , l_param4
                                         ,l_param3
                                        , p_message);
        WHEN 'STD_GEO_ENTITY_TA' THEN
            l_param1 := json_ext.get_string(JSON(p_json),'p_entityType');                        -- p_entityType;
            l_param2 :=  json_ext.get_string(JSON(p_json),'p_site_id');                            -- p_site_id;
            l_param3 := json_ext.get_string(JSON(p_json),'p_user');                                -- p_user_name;
            l_param4 := json_ext.get_string(JSON(p_json),'p_trade_area_type');               -- p_trade_area_type; -- Actual Type of TA that is populate in TA_TYPE in Tradearea Table
            l_param5 := json_ext.get_string(JSON(p_json),'p_description');                       -- p_description;
            l_param6 := json_ext.get_string(JSON(p_json),'p_brand');                              -- p_brand;

--             insert into TEMP_TMCS_TA_SITES (SITE_ID,GEOMETRY,TA_TYPE) values(l_param2,p_geom,'ORGINAL');
--            commit;
--            Begin
--                    Select SDO_GEOM.SDO_SELF_UNION(p_geom,0.05)
--                    into l_geom
--                    from dual;
                     TMCS_UNION_GEOMETRY_ARRAY(l_param2,p_geom,l_geom);
--            Exception
--                    When Others then
--                     Select SDO_GEOM.SDO_UNION(p_geom,p_geom,0.05)
--                    into l_geom
--                    from dual;
--            End;

--            insert into TEMP_TMCS_TA_SITES (SITE_ID,GEOMETRY,TA_TYPE) values(l_param2,l_geom,'After UNION');
--            commit;
           dbms_output.put_line('l_param1  --> ' || l_param1);
            TMC_DRAW_ENTITY_TA( l_param2                    -- p_ENTITYID
                                                , l_param1                   -- P_ENTITYTYPE
                                                , l_param4                   -- P_TA_TYPE
                                                , l_param5                   -- P_DESCRIPTION
                                                , TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(l_geom)                      -- P_GEOMETRY
                                                , l_param6                   -- P_BRAND_ID
                                                , p_message                -- P_MESSAGE
                                                );

        WHEN 'DRAW_ENTITY_TA' THEN

            l_param1 := json_ext.get_string(JSON(p_json),'p_entityType');                        -- p_entityType;
            l_param2 := json_ext.get_string(JSON(p_json),'p_customTAType');                 -- p_customTAType;
            l_param3 :=  json_ext.get_string(JSON(p_json),'p_site_id');                            -- p_site_id;
            l_param4 := json_ext.get_string(JSON(p_json),'p_user');                                -- p_user_name;
            l_param5 := json_ext.get_string(JSON(p_json),'p_trade_area_type');               -- p_trade_area_type; -- Actual Type of TA that is populate in TA_TYPE in Tradearea Table
            l_param6 := json_ext.get_string(JSON(p_json),'p_description');                       -- p_description;
            l_param7 := json_ext.get_string(JSON(p_json),'p_brand');                              -- p_brand;
            l_param8 := json_ext.get_string(JSON(p_json),'p_customTAType');                 -- p_trade_area_type RING/DRIVETIME/CUSTOM;
            l_param9 := json_ext.get_string(JSON(p_json),'p_DTmin');                             -- p_description;

            dbms_output.put_line('l_param2  --> ' || l_param2);

            if Upper(l_param2) in ('CUSTOM') then
                    dbms_output.put_line('l_param1  --> ' || l_param1);
                    TMC_DRAW_ENTITY_TA( l_param3                    -- p_ENTITYID
                                                        , l_param1                   -- P_ENTITYTYPE
                                                        , l_param5                   -- P_TA_TYPE
                                                        , l_param6                   -- P_DESCRIPTION
                                                        , p_geom                     -- P_GEOMETRY
                                                        , l_param7                   -- P_BRAND_ID
                                                        , p_message                -- P_MESSAGE
                                                        );
            ELSif Upper(l_param2) in ('MODEL TA') then
                NULL;

                If UPPER(l_param1) = 'SITE' then
                    TMCS_CREATE_SITE_TA(l_param3                -- p_site_id  IN NUMBER
                                       ,l_param7                -- p_brand IN VARCHAR2
                                       ,TMCS_SEC_CTX.GET_USER   --  p_user_name IN VARCHAR2
                                       ,l_param5                --  p_trade_area_type IN VARCHAR2
                                       ,l_param6                --  p_description IN VARCHAR2
                                       ,NULL                    --  p_ring_miles IN VARCHAR2
                                       ,p_message               --  p_message OUT VARCHAR2
                                       );
                ELSIf UPPER(l_param1) = 'TARGET' then
                    TMCS_CREATE_TARGET_TA(l_param3                  --  p_target_id  IN NUMBER
                                           ,l_param7                --  p_brand IN VARCHAR2
                                           ,NULL                    --  p_ring_miles IN VARCHAR2
                                           ,TMCS_SEC_CTX.GET_USER   --  p_user_name IN VARCHAR2
                                           ,p_message               --  p_message OUT VARCHAR2
                                           );
                ELSIf UPPER(l_param1) = 'STORE' then
                    NULL;
                END IF;


            Else

                    dbms_output.put_line('l_param1  --> ' || l_param1);
                       tmc_DT_SiteTA(   l_param3
                                                , l_param4
                                                , l_param9
                                                 ,l_param8
                                                , p_message
                                                , l_param5  -- TA_TYPE
                                                , l_param1  --  Entity_type
                                                );

            End if;
        WHEN 'TRUNCATE_ENTITY_TA' THEN

            l_param1 := json_ext.get_string(JSON(p_json),'p_entityType');                 --p_entityType;

            TMCS_TRUNCATE_TRADEAREAS(p_message
                                     ,p_geom
                                     ,p_json
                                     );


          WHEN 'RESTORE_ENTITY_TA' THEN

             l_param1 := json_ext.get_string(JSON(p_json),'p_entityType');                 --p_entityType;

                 if Upper(l_param1) = 'SITE' then

                      BEGIN
                            l_param1 :=  json_ext.get_string(JSON(p_json),'p_oldTAId');                    --entitytype;
                            l_param2 := json_ext.get_string(JSON(p_json),'p_entity_id');                      --p_site_id;

                            TMC_VERSION_TRADEAREA(p_message,l_param2,l_param1,TMCS_SEC_CTX.GET_BRAND_ID);

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 42; --Error while updating Standard Attributes
                            p_status := sqlerrm;
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('RESTORE_ENTITY_TA'
                                                                , 'RESTORE_ENTITY_TA'
                                                                , p_message
                                                                ,  'Configuration Not set for this client'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
                      END;

                 Elsif Upper(l_param1) = 'TARGET' then

                      BEGIN

                               TMC_VERSION_TARGET_TRADEAREA(p_message,p_json);

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 42; --Error while updating Standard Attributes
                            p_status := sqlerrm;
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('RESTORE_ENTITY_TA'
                                                                , 'RESTORE_ENTITY_TA'
                                                                , p_message
                                                                ,  'Configuration Not set for this client'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
                      END;
                 Elsif Upper(l_param1) = 'STORE' then

                       BEGIN

                           TMC_VERSION_STORE_TRADEAREA(p_message,p_json);

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 42; --Error while updating Standard Attributes
                            p_status := sqlerrm;
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('RESTORE_ENTITY_TA'
                                                                , 'RESTORE_ENTITY_TA'
                                                                , p_message
                                                                ,  'Configuration Not set for this client'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
                      END;

                 End if;
         WHEN 'EDIT_ENTITY_TA' THEN

            l_param1 := json_ext.get_string(JSON(p_json),'p_entityType');  --p_entityType;
            l_param2 :=  json_ext.get_string(JSON(p_json),'p_entity_id'); --p_site_id;
            l_param3 := json_ext.get_string(JSON(p_json),'p_user'); --p_user_name;
            l_param4 := json_ext.get_string(JSON(p_json),'p_trade_area_type'); --p_trade_area_type;
            l_param5 := json_ext.get_string(JSON(p_json),'p_description'); --p_description;
            l_param6 := json_ext.get_string(JSON(p_json),'p_brand'); --p_brand;
            l_param7 := json_ext.get_string(JSON(p_json),'p_tatype'); --p_brand;
            if l_param7 is null then
                 l_param7 := 'RETAIL';
            End if;
             dbms_output.put_line('l_param7  --> ' || l_param7);
                 if Upper(l_param1) = 'SITE' then

                      BEGIN

                                Select TMC_PACKAGE
                                into l_package
                                from TMCS_GIS_CLIENT_SETUP
                                where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID()
                                and UPPER(TMC_Functionality) = 'EDIT_SITE_TA';

                                dbms_output.put_line('l_text  --> ' || l_package);
                               IF l_package is not null then
                                       plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f, :g,:h,:i); END;';
                                       EXECUTE IMMEDIATE plsql_block using OUT p_message, l_param2,l_param3,l_param4,l_param5,l_param6,p_geom,l_param7,'TRUE';
                               Else
                                     p_message := 14;
                                End if;

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 42; --Error while updating Standard Attributes
                            p_status := sqlerrm;
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TRUNCATE_TA'
                                                                , 'TRUNCATE_TA'
                                                                , p_message
                                                                ,  'Configuration Not set for this client'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
                      END;

                 Elsif Upper(l_param1) = 'TARGET' then

                      BEGIN

                                Select TMC_PACKAGE
                                into l_package
                                from TMCS_GIS_CLIENT_SETUP
                                where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID()
                                and UPPER(TMC_Functionality) = 'EDIT_TARGET_TA';

                                dbms_output.put_line('l_text  --> ' || l_package);
                                IF l_package is not null then
                                     plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f, :g,:h,:i); END;';
                                       EXECUTE IMMEDIATE plsql_block using OUT p_message, l_param2,l_param6,l_param3,'',l_param5,p_geom,l_param7,'TRUE';
                               Else
                                     p_message := 14;
                                End if;

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 42; --Error while updating Standard Attributes
                            p_status := sqlerrm;
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TRUNCATE_TA'
                                                                , 'TRUNCATE_TA'
                                                                , p_message
                                                                ,  'Configuration Not set for this client'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
                      END;

                 Elsif UPPER(l_param1) = 'STORE' then
                      BEGIN

                                Select TMC_PACKAGE
                                into l_package
                                from TMCS_GIS_CLIENT_SETUP
                                where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID()
                                and UPPER(TMC_Functionality) = 'EDIT_STORE_TA';

                                IF l_package is not null then
                                       plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f, :g,:h,:i); END;';
                                       EXECUTE IMMEDIATE plsql_block using OUT p_message, l_param2,l_param3,l_param4,l_param5,l_param6,p_geom,l_param7,'TRUE';
                                End if;

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 42; --Error while updating Standard Attributes
                            p_status := sqlerrm;
                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('MAINTAIN_STORE_TA'
                                                                , 'EDIT_STORE_TA'
                                                                , '42'
                                                                ,  'Configuration Not set for this client to edit Store TA'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
                      END;
                 End if;
        WHEN 'EDIT_TA' THEN
            l_param1 :=  json_ext.get_string(JSON(p_json),'p_site_id'); --p_site_id;
            l_param2 := json_ext.get_string(JSON(p_json),'p_user'); --p_user_name;
            l_param3 := json_ext.get_string(JSON(p_json),'p_trade_area_type'); --p_trade_area_type;
            l_param4 := json_ext.get_string(JSON(p_json),'p_description'); --p_description;
            l_param5 := json_ext.get_string(JSON(p_json),'p_brand'); --p_brand;

              BEGIN

                        Select TMC_PACKAGE
                        into l_package
                        from TMCS_GIS_CLIENT_SETUP
                        where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID()
                        and UPPER(TMC_Functionality) = 'EDIT_TRADEAREA';

                        IF l_package is not null then
                               plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f, :g); END;';
                               dbms_output.put_line('l_text  --> ' || plsql_block);
                               EXECUTE IMMEDIATE plsql_block using OUT p_message, l_param1,l_param2,l_param3,l_param4,l_param5,p_geom;
                        End if;

              EXCEPTION
                    when others then null;
                    dbms_output.put_line('SQL ERROR ' || sqlerrm);
                    p_message := 42; --Error while updating Standard Attributes
                    p_status := sqlerrm;
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('MAINTAIN_SITE_TA'
                                                        , 'TMC_MAINTAIN_ENTITIES'
                                                        , '42'
                                                        ,  'Configuration Not set for this client'
                                                        , SQLERRM
                                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                                        , TMCS_SEC_CTX.GET_USER
                                                        );
              END;
        WHEN 'MAINTAIN_SITE_TA' THEN

            l_param1 :=  json_ext.get_string(JSON(p_json),'p_site_id'); --p_site_id;
            l_param2 := json_ext.get_string(JSON(p_json),'p_user'); --p_user_name;
            l_param3 := json_ext.get_string(JSON(p_json),'p_trade_area_type'); --p_trade_area_type;
            l_param4 := json_ext.get_string(JSON(p_json),'p_description'); --p_description;
            l_param5 := json_ext.get_string(JSON(p_json),'p_brand'); --p_brand;

              BEGIN

                        Select TMC_PACKAGE
                        into l_package
                        from TMCS_GIS_CLIENT_SETUP
                        where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID()
                        and UPPER(TMC_Functionality) = 'EDIT_TRADEAREA';

                        IF l_package is not null then
                               plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f, :g); END;';
                               dbms_output.put_line('l_text  --> ' || plsql_block);
                               EXECUTE IMMEDIATE plsql_block using OUT p_message, l_param1,l_param2,l_param3,l_param4,l_param5,p_geom;
                        End if;

              EXCEPTION
                    when others then null;
                    dbms_output.put_line('SQL ERROR ' || sqlerrm);
                    p_message := 42; --Error while updating Standard Attributes
                    p_status := sqlerrm;
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('MAINTAIN_SITE_TA'
                                                        , 'TMC_MAINTAIN_ENTITIES'
                                                        , '42'
                                                        ,  'Configuration Not set for this client'
                                                        , SQLERRM
                                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                                        , TMCS_SEC_CTX.GET_USER
                                                        );
              END;

          WHEN 'MOVE_ENTITY' THEN
                l_param1 :=  json_ext.get_string(JSON(p_json),'p_entityType');  --  Entity type;
                l_param2 := json_ext.get_string(JSON(p_json),'p_entityID');      -- Entity  ID;
                l_param3 := json_ext.get_string(JSON(p_json),'p_newLong');     -- p_newLongitude;
                l_param4 := json_ext.get_string(JSON(p_json),'p_newLat');        --p_newLatitude;

--                TMC_Move_Entity(l_param1,
--                                        l_param2,
--                                        l_param3,
--                                        l_param4,
--                                        p_message
--                                        );


          WHEN 'CREATE_TERRITORY' THEN
                TMC_MAINTAIN_MARKETS
                                 (p_message,
                                p_status,
                                p_geom,
                                p_json);
         WHEN 'CREATE_STORE' THEN

                l_param1 := json_ext.get_string(JSON(p_json),'p_storeName'); --p_siteName;
                l_param2 := json_ext.get_string(JSON(p_json),'p_longitude'); -- p_longitude;
                l_param3 := json_ext.get_string(JSON(p_json),'p_latitude'); --p_latitude;
                l_param4 := json_ext.get_string(JSON(p_json),'p_address'); --p_address;
                l_param5 := json_ext.get_string(JSON(p_json),'p_city'); --p_city;
                l_param6 := json_ext.get_string(JSON(p_json),'p_state'); --p_state;
                l_param7 := json_ext.get_string(JSON(p_json),'p_country'); --p_country;
                l_param8 := json_ext.get_string(JSON(p_json),'p_zipCode'); --p_zip_code;
                l_param9 := json_ext.get_string(JSON(p_json),'p_brand'); --p_brand;
                l_param10 := json_ext.get_string(JSON(p_json),'p_scID'); --p_scID;


                TMC_CREATE_STORES(p_message => p_message
                                ,p_Store_name => l_param1
                                ,p_longitude =>l_param2
                                ,p_latitude =>  l_param3
                                ,p_address =>   l_param4
                                ,p_city =>  l_param5
                                ,p_state => l_param6
                                ,p_country =>   l_param7
                                ,p_zip_code =>  l_param8
                                ,p_brand => l_param9
                                ,p_storeID => l_entityID
                                ,p_CustomJson => p_json
                                ) ;

         WHEN 'CREATE_SITE' THEN

                l_param1 :=  json_ext.get_string(JSON(p_json),'p_dma'); --  DMA name;
                l_param2 := json_ext.get_string(JSON(p_json),'p_targetId'); --target ID;
                l_param3 := json_ext.get_string(JSON(p_json),'p_longitude'); -- p_longitude;
                l_param4 := json_ext.get_string(JSON(p_json),'p_latitude'); --p_latitude;
                l_param5 := json_ext.get_string(JSON(p_json),'p_address'); --p_address;
                l_param6 := json_ext.get_string(JSON(p_json),'p_city'); --p_city;
                l_param7 := json_ext.get_string(JSON(p_json),'p_state'); --p_state;
                l_param8 := json_ext.get_string(JSON(p_json),'p_country'); --p_country;
                l_param9 := json_ext.get_string(JSON(p_json),'p_zipCode'); --p_zip_code;
                l_param10 := json_ext.get_string(JSON(p_json),'p_brand'); --p_brand;
                l_param15 := json_ext.get_string(JSON(p_json),'p_userName'); --p_user_name;


                l_param11 := json_ext.get_string(JSON(p_json),'p_siteName'); --p_siteName;
                l_param12 := json_ext.get_string(JSON(p_json),'p_StoreType'); --p_StoreType;
                l_param13 := json_ext.get_string(JSON(p_json),'p_driveThru'); --p_drive_thru;
                l_param14 := json_ext.get_string(JSON(p_json),'p_scID'); --p_scID;


                TMC_CREATE_SITES
                                (p_message => p_message
                                ,p_dma => l_param1
                                ,p_target_id => l_param2
                                ,p_site_name => l_param11
                                ,p_longitude =>l_param3
                                ,p_latitude =>  l_param4
                                ,p_address =>   l_param5
                                ,p_city =>  l_param6
                                ,p_state => l_param7
                                ,p_country =>   l_param8
                                ,p_zip_code =>  l_param9
                                ,p_trade_area_type => 'PREDEFINED_RING'
                                ,p_ring_miles => '3'
                                ,p_description => 'Model Tradearea'
                                ,p_StoreType =>  l_param12
                                ,p_drive_thru => l_param13
                                ,p_brand => l_param10
                                ,p_user_name => l_param15
                                ,p_siteID => l_entityID
                                ,p_scID =>l_param14
                                ,p_BatchID => NULL
                                ,p_BatchDetailID => NULL
                                ,p_CustomJson => p_json
                                ) ;

         When 'CREATE_TARGET' THEN


                l_param1 :=  json_ext.get_string(JSON(p_json),'p_dma'); --  DMA name;
                l_param2 := json_ext.get_string(JSON(p_json),'p_targetName'); --target name;
                l_param3 := json_ext.get_string(JSON(p_json),'p_longitude'); -- p_longitude;
                l_param4 := json_ext.get_string(JSON(p_json),'p_latitude'); --p_latitude;
                l_param5 := json_ext.get_string(JSON(p_json),'p_address'); --p_address;
                l_param6 := json_ext.get_string(JSON(p_json),'p_city'); --p_city;
                l_param7 := json_ext.get_string(JSON(p_json),'p_state'); --p_state;
                l_param8 := json_ext.get_string(JSON(p_json),'p_country'); --p_country;
                l_param9 := json_ext.get_string(JSON(p_json),'p_zipCode'); --p_zip_code;
                l_param10 := json_ext.get_string(JSON(p_json),'p_brand'); --p_brand;
                l_param11 := json_ext.get_string(JSON(p_json),'p_userName'); --p_user_name;

                        TMC_CREATE_Targets(
                                    p_message => p_message
                                    ,p_dma => l_param1
                                    ,p_target_name  => l_param2
                                    ,p_longitude => l_param3
                                    ,p_latitude => l_param4
                                    ,p_address => l_param5
                                    ,p_city => l_param6
                                    ,p_state => l_param7
                                    ,p_country => l_param8
                                    ,p_zip_code => l_param9
                                    ,p_ring_miles => '3'
                                    ,p_description => 'Standard TA'
                                    ,p_brand => l_param10
                                    ,p_user_name => l_param11
                                    ,p_seedID => null
                                    ,p_targetID => l_entityID
                                    ,p_CustomJson => p_json
                                );
         When 'CREATE_PROSPECT' THEN
                JSON(p_json).print;

                l_param3 := json_ext.get_string(JSON(p_json),'p_longitude'); -- p_longitude;
                l_param4 := json_ext.get_string(JSON(p_json),'p_latitude'); --p_latitude;
                l_param5 := json_ext.get_string(JSON(p_json),'p_address'); --p_address;
                l_param6 := json_ext.get_string(JSON(p_json),'p_city'); --p_city;
                l_param7 := json_ext.get_string(JSON(p_json),'p_state'); --p_state;
                l_param8 := json_ext.get_string(JSON(p_json),'p_country'); --p_country;
                l_param9 := json_ext.get_string(JSON(p_json),'p_zipCode'); --p_zip_code;
                l_param10 := json_ext.get_string(JSON(p_json),'p_brand'); --p_brand;
                l_param11 := json_ext.get_string(JSON(p_json),'p_userName'); --p_user_name;

                l_param12 := json_ext.get_string(JSON(p_json),'p_prospectName'); --p_prospect_name;
                l_param13 := json_ext.get_string(JSON(p_json),'p_StoreType'); --p_StoreType;
                l_param14 := json_ext.get_string(JSON(p_json),'p_driveThru'); --p_drive_thru;

                DBMS_OUTPUT.PUT_LINE('l_param3: '|| l_param3);
                DBMS_OUTPUT.PUT_LINE('l_param4: '|| l_param4);
                DBMS_OUTPUT.PUT_LINE('l_param5: '|| l_param5);
                DBMS_OUTPUT.PUT_LINE('l_param6: '|| l_param6);
                DBMS_OUTPUT.PUT_LINE('l_param7: '|| l_param7);
                DBMS_OUTPUT.PUT_LINE('l_param8: '|| l_param8);
                DBMS_OUTPUT.PUT_LINE('l_param9: '|| l_param9);
                DBMS_OUTPUT.PUT_LINE('l_param10: '|| l_param10);
                DBMS_OUTPUT.PUT_LINE('l_param11: '|| l_param11);
                DBMS_OUTPUT.PUT_LINE('l_param12: '|| l_param12);
                DBMS_OUTPUT.PUT_LINE('l_param13: '|| l_param13);
                DBMS_OUTPUT.PUT_LINE('l_param14: '|| l_param14);
--

                TMC_MAINTAIN_PROSPECTS(
                                p_message => p_message
                                ,p_prospect_name => l_param12
                                ,p_longitude => l_param3
                                ,p_latitude =>l_param4
                                ,p_address =>l_param5
                                ,p_city       => l_param6
                                ,p_state    => l_param7
                                ,p_zip_code  => l_param9
                                ,p_StoreType => l_param13
                                ,p_drive_thru  => l_param14
                                ,p_trade_area_type => 'PREDEFINED_RING'
                                ,p_ring_miles  => '3'
                                ,p_description  =>  'Model Tradearea'
                                ,p_brand  => l_param10
                                ,p_user_name  => l_param11
                                ,p_insert => 'TRUE'
                                ,p_prospectID =>  NULL
                                ,p_drive_time_coordinates =>  NULL
                                ,p_CustomJson => p_json
                                );

         When 'CREATE_SHOPPINGCENTER' THEN
            l_param1 :=  json_ext.get_string(JSON(p_json),'p_scName'); --p_SC_name;
            l_param2 := json_ext.get_string(JSON(p_json),'p_longitude'); --p_longitude;
            l_param3 := json_ext.get_string(JSON(p_json),'p_latitude'); --p_latitude;
            l_param4 := json_ext.get_string(JSON(p_json),'p_address'); --p_address;
            l_param5 := json_ext.get_string(JSON(p_json),'p_city'); --p_city;
            l_param6 := json_ext.get_string(JSON(p_json),'p_state'); --p_state;
            l_param7 := json_ext.get_string(JSON(p_json),'p_country'); --p_country;
            l_param8 := json_ext.get_string(JSON(p_json),'p_zipCode'); --p_zip_code;
            l_param9 := json_ext.get_string(JSON(p_json),'p_param1'); --p_attr1;
            l_param10 := json_ext.get_string(JSON(p_json),'p_param2'); --p_attr2;
            l_param11 := json_ext.get_string(JSON(p_json),'p_param3'); --p_attr3;
            l_param12 := json_ext.get_string(JSON(p_json),'p_userName'); --p_user_name;

            l_param13 := json_ext.get_string(JSON(p_json),'p_gla'); --p_GLA;
            l_param14 := json_ext.get_string(JSON(p_json),'p_mallCode'); -- p_SC_CODE;

            TMC_CREATE_SC(p_message => p_message
                        ,p_sc_name => l_param1
                        ,p_mallCode => l_param14
                        ,p_longitude => l_param2
                        ,p_latitude => l_param3
                        ,p_address => l_param4
                        ,p_city => l_param5
                        ,p_state => l_param6
                        ,p_zipcode  => l_param8
                        ,p_userName => l_param12
                        ,p_gla => l_param13
                        ,p_attr1 => l_param9
                        ,p_attr2 => l_param10
                        ,p_attr3 => l_param11
                        );

         when 'CREATE_COMPETITOR' THEN
            l_param1 :=  json_ext.get_string(JSON(p_json),'p_Comp_name'); --p_Comp_name;
            l_param2 := json_ext.get_string(JSON(p_json),'p_longitude'); --p_longitude;
            l_param3 := json_ext.get_string(JSON(p_json),'p_latitude'); --p_latitude;
            l_param4 := json_ext.get_string(JSON(p_json),'p_address'); --p_address;
            l_param5 := json_ext.get_string(JSON(p_json),'p_city'); --p_city;
            l_param6 := json_ext.get_string(JSON(p_json),'p_state'); --p_state;
            l_param7 := json_ext.get_string(JSON(p_json),'p_country'); --p_country;
            l_param8 := json_ext.get_string(JSON(p_json),'p_zipCode'); --p_zip_code;
            l_param9 := json_ext.get_string(JSON(p_json),'p_param1'); --p_attr1;
            l_param10 := json_ext.get_string(JSON(p_json),'p_param2'); --p_attr2;
            l_param11 := json_ext.get_string(JSON(p_json),'p_param3'); --p_attr3;
            l_param12 := json_ext.get_string(JSON(p_json),'p_userName'); --p_user_name;

            l_param13 := json_ext.get_string(JSON(p_json),'p_lov1'); --p_level1;
            l_param14 := json_ext.get_string(JSON(p_json),'p_lov2'); --p_level2;

            TMC_MAINTAIN_COMPETITORS
                                (p_message => p_message
                                ,p_Comp_name => l_param1
                                ,p_longitude => l_param2
                                ,p_latitude => l_param3
                                ,p_address => l_param4
                                ,p_city => l_param5
                                ,p_state => l_param6
                                ,p_country => l_param7
                                ,p_zip_code => l_param8
                                ,p_attr1 => l_param9
                                ,p_attr2 => l_param10
                                ,p_attr3 => l_param11
                                ,p_user_name => l_param12
                                ,p_level1 => l_param13
                                ,p_level2 => l_param14
                                );
        when 'CREATE_COMP_EVENT' THEN
            TMCS_MAINTAIN_COMP_EVENTS(P_MESSAGE => p_message
                                      ,P_JSON => p_json
                                      );
    End case;

    if p_message = '1' then

        if p_status is null then
            p_status := 'Created Successfully';
        End if;

    Elsif p_message in ('8','9') then
        if p_status is null then
            p_status := 'You can only create entities within the country you are logged into. Please choose the relevant country to proceed';
        End if;
    Elsif p_message = '60' then
        if p_status is null then
            p_status := 'The Entity has been created, but Tradeareas are getting generated. The site will be visible on the map  after the TA is generated ';
        End if;

    Elsif p_message in ( '2','10') then
        if p_status is null then
            p_status := 'The TA Doesnt Encomposess the  Entity. ';
        End if;
    Elsif p_message = '56' then
        if p_status is null then
            p_status := 'The Entity Cannot be truncated  against choosen Sister Entity. ';
        End if;
    Elsif p_message = '51' then

        if p_status is null then
            p_status := 'Please select a brand that is licensed to use this functionality.';
        End if;
        NULL;
   ELSIF p_message in ('81') then

        if p_status is null then
            p_status := 'The entity move request has been sent to your administrator. The administrator will review and approve.';
        End if;
        NULL;
    End IF;

Exception
    When others then
    p_message := 99;
    p_status := SQLERRM;
    dbms_output.put_line('TMC_MAINTAIN_MARKETS SQL ERROR ' || sqlerrm);
     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Maintain Entities'
                                                      , 'TMC_MAINTAIN_ENTITIES'
                                                      , '99'
                                                      , 'General Error'
                                                      , sqlerrm
                                                      , TMCS_SEC_CTX.GET_CLIENT_ID
                                                      , TMCS_SEC_CTX.GET_USER
                                                      );
End;
Function TMCS_GET_DEFAULT_STATUS(p_entityType varchar2) Return VARCHAR2 IS

p_status VARCHAR2(320);
Begin
         p_status := TMCS_GET_DEFAULT_STATUS('AC',p_entityType);

--    If Upper(p_entityType) = 'SITE' then
--
--          Begin
--
--            Select GET_STATUS
--            into p_status
--            from TMCS_GIS_CLIENT_SETUP
--            where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID
--            and UPPER(TMC_Functionality) = 'GET_SITE_TRADEAREA';
--
--          Exception
--            When no_data_found then
--            p_status := 'UN';
--            When others then
--            p_status := '';
--          End;
--
--
--    ElsIF UPPER(p_entityType) = 'TARGET' then
--
--         Begin
--
--            Select GET_STATUS
--            into p_status
--            from TMCS_GIS_CLIENT_SETUP
--            where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID
--            and UPPER(TMC_Functionality) = 'GET_TARGET_TRADEAREA';
--
--         Exception
--            When no_data_found then
--            p_status := 'UNASSIGNED';
--            When others then
--            p_status := '';
--         End;
--
--    End if;

     DBMS_OUTPUT.PUT_LINE('Default '||p_entityType|| ' is '||p_status);
    return p_status;
Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Get Default Status'
                                                      , 'TMCS_GET_DEFAULT_STATUS'
                                                      , '99'
                                                      , 'General Error'
                                                      , sqlerrm
                                                      , TMCS_SEC_CTX.GET_CLIENT_ID
                                                      , TMCS_SEC_CTX.GET_USER
                                                      );
End;
Function TMCS_GET_DEFAULT_STATUS(P_STATUS_TYPE VARCHAR2
														   ,P_ENTITY_TYPE VARCHAR2
														 ) Return VARCHAR2 IS
p_status VARCHAR2(320);

Begin

           Begin
               Select STATUS_CODE
               into p_status
               from TMCS_ENTITY_STATUSES
               where UPPER(ENTITY_TYPE) = UPPER(P_ENTITY_TYPE)
                and UPPER(STATUS_TYPE) = UPPER(P_STATUS_TYPE)
				and DEFAULT_STATUS = 'Y'
				and ENABLED_FLAG = 'Y';

           Exception
                  when no_data_found then
				  Begin
--				       DBMS_OUTPUT.PUT_LINE('Default '||P_ENTITY_TYPE|| ' is '||P_STATUS_TYPE || '-- '|| sqlerrm);
                          If Upper(P_ENTITY_TYPE) = 'SITE'  and  UPPER(P_STATUS_TYPE) = 'AC' then
--                            DBMS_OUTPUT.PUT_LINE(P_ENTITY_TYPE);
                                  Begin

                                    Select GET_STATUS
                                    into p_status
                                    from TMCS_GIS_CLIENT_SETUP
                                    where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID
                                    and UPPER(TMC_Functionality) = 'GET_SITE_TRADEAREA';
--                                   DBMS_OUTPUT.PUT_LINE('Default no_data_found'||P_ENTITY_TYPE|| ' is '||P_STATUS_TYPE || '-- '|| p_status);
                                  Exception
                                    When no_data_found then
--									DBMS_OUTPUT.PUT_LINE('Default '||P_ENTITY_TYPE|| ' is '||P_STATUS_TYPE || '-- '|| sqlerrm);
                                    p_status := 'UN';
                                    When others then
--									DBMS_OUTPUT.PUT_LINE('Default '||P_ENTITY_TYPE|| ' is '||P_STATUS_TYPE || '-- '|| sqlerrm);
                                    p_status := '';
                                  End;
                          ElsIF UPPER(P_ENTITY_TYPE) = 'TARGET' and  UPPER(P_STATUS_TYPE) = 'AC'  then
                                 Begin

                                    Select GET_STATUS
                                    into p_status
                                    from TMCS_GIS_CLIENT_SETUP
                                    where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID
                                    and UPPER(TMC_Functionality) = 'GET_TARGET_TRADEAREA';
--                                    DBMS_OUTPUT.PUT_LINE('Default '||P_ENTITY_TYPE|| ' is '||P_STATUS_TYPE || '-- '|| p_status);
                                 Exception
                                    When no_data_found then
--									DBMS_OUTPUT.PUT_LINE('Default '||P_ENTITY_TYPE|| ' is '||P_STATUS_TYPE || '-- '|| sqlerrm);
                                    p_status := 'UNASSIGNED';
                                    When others then
--									DBMS_OUTPUT.PUT_LINE('Default '||P_ENTITY_TYPE|| ' is '||P_STATUS_TYPE || '-- '|| sqlerrm);
                                    p_status := '';
                                 End;
                          ElsIF UPPER(P_ENTITY_TYPE) = 'STORE' and  UPPER(P_STATUS_TYPE) = 'OP'  then
                                p_status := 'OPEN';
--								DBMS_OUTPUT.PUT_LINE('Default '||P_ENTITY_TYPE|| ' is '||P_STATUS_TYPE || '-- '|| p_status);
						 ElsIF UPPER(P_ENTITY_TYPE) = 'STORE' and  UPPER(P_STATUS_TYPE) = 'IN'  then
                                p_status := 'C';
--                                DBMS_OUTPUT.PUT_LINE('Default '||P_ENTITY_TYPE|| ' is '||P_STATUS_TYPE || '-- '|| p_status);
                         ElsIF UPPER(P_ENTITY_TYPE) = 'SC' and  UPPER(P_STATUS_TYPE) = 'OP'  then
                                p_status := 'OPEN';
--                                DBMS_OUTPUT.PUT_LINE('Default '||P_ENTITY_TYPE|| ' is '||P_STATUS_TYPE || '-- '|| p_status);
                         ElsIF UPPER(P_ENTITY_TYPE) = 'COMPETITOR' and  UPPER(P_STATUS_TYPE) = 'OP'  then
                                p_status := 'OPEN';
--                                DBMS_OUTPUT.PUT_LINE('Default '||P_ENTITY_TYPE|| ' is '||P_STATUS_TYPE || '-- '|| p_status);
						 ELSE
						         p_status := 'IN';
                          End if;
		          END;
                 When others then
                        p_status := '';
                        DBMS_OUTPUT.PUT_LINE(sqlerrm);
                        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Get Default Status'
                                                                          , 'TMCS_GET_DEFAULT_STATUS'
                                                                          , '99'
                                                                          , 'Default Staus not found'
                                                                          , sqlerrm
                                                                          , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                          , TMCS_SEC_CTX.GET_USER
                                                                          );
           End;
		   DBMS_OUTPUT.PUT_LINE('Return Status : '||p_status);
           Return p_status;
Exception
       When others then
       DBMS_OUTPUT.PUT_LINE(sqlerrm);
       TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Get Default Status'
                                                          , 'TMCS_GET_DEFAULT_STATUS'
                                                          , '99'
                                                          , 'General Error'
                                                          , sqlerrm
                                                          , TMCS_SEC_CTX.GET_CLIENT_ID
                                                          , TMCS_SEC_CTX.GET_USER
                                                          );
End;
FUNCTION TMCS_GET_GEOMETRY(p_tableName VARCHAR2,
                                                    p_geomName VARCHAR2,
                                                    p_IDName VARCHAR2,
                                                    p_ID  VARCHAR2,
                                                    p_longitude NUMBER,
                                                    p_latitude NUMBER,
                                                    p_srid NUMBER)  Return MDSYS.SDO_GEOMETRY as

l_geometry MDSYS.SDO_GEOMETRY;
l_returnGeom MDSYS.SDO_GEOMETRY;
l_sql VARCHAR2(320);
l_numElements NUMBER := 0;
l_numRings NUMBER := 0;
l_point MDSYS.SDO_GEOMETRY;
l_extractPoly MDSYS.SDO_GEOMETRY;
l_extractRing  MDSYS.SDO_GEOMETRY;
l_message VARCHAR2(200);
l_elemIDx NUMBER;
l_ringIDX NUMBER;
l_count NUMBER;

Begin

    NULL;

  return l_returnGeom;

Exception
    When others then
    DBMS_OUTPUT.PUT_line(sqlerrm);
     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Get Selected Geometry'
                                                      , 'TMCS_GET_GEOMETRY'
                                                      , '99'
                                                      , 'General Error'
                                                      , sqlerrm
                                                      , TMCS_SEC_CTX.GET_CLIENT_ID
                                                      , TMCS_SEC_CTX.GET_USER
                                                      );
return null;
End;
FUNCTION TMCS_GET_GEOMETRY(p_JSON VARCHAR2)  Return MDSYS.SDO_GEOMETRY as

l_geometry MDSYS.SDO_GEOMETRY;
l_returnGeom MDSYS.SDO_GEOMETRY;
l_returnGeom1 MDSYS.SDO_GEOMETRY;
l_sql VARCHAR2(320);
l_numElements NUMBER := 0;
l_numRings NUMBER := 0;
l_point MDSYS.SDO_GEOMETRY;
l_extractPoly MDSYS.SDO_GEOMETRY;
l_extractRing  MDSYS.SDO_GEOMETRY;
l_message VARCHAR2(200);
l_elemIDx NUMBER;
l_ringIDX NUMBER;
l_count NUMBER;
l_param1 VARCHAR2(32000);
l_param2 VARCHAR2(32000);
l_param3 VARCHAR2(32000);
l_param4 VARCHAR2(32000);
l_param5 VARCHAR2(32000);
l_param6 VARCHAR2(32000);
l_param7 VARCHAR2(32000);
l_param8 VARCHAR2(32000);

Begin

--JSON: '{
--p_tableName VARCHAR2,
--p_geomName VARCHAR2,
--p_IDName VARCHAR2,
--p_ID  VARCHAR2,
--p_longitude NUMBER,
--p_latitude NUMBER,
--p_srid NUMBER,
--P_taType VARCHAR2
--}'
NULL;
  return l_returnGeom;

Exception
    When others then
    DBMS_OUTPUT.PUT_line(sqlerrm);
     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Get Selected Geometry'
                                                      , 'TMCS_GET_GEOMETRY'
                                                      , '99'
                                                      , 'General Error'
                                                      , sqlerrm
                                                      , TMCS_SEC_CTX.GET_CLIENT_ID
                                                      , TMCS_SEC_CTX.GET_USER
                                                      );
return null;
End;
Procedure TMCS_Query_geometry(p_ID IN VARCHAR2
                                                   ,p_point IN MDSYS.SDO_GEOMETRY
                                                   , p_geometry OUT MDSYS.SDO_GEOMETRY
                                                   ,p_elementIDX OUT NUMBER
                                                   ,p_ringIDX OUT NUMBER
                                                    ,p_message OUT VARCHAR2 ) As

Begin

    NULL;

Exception
    When others then
    DBMS_OUTPUT.PUT_line(sqlerrm);
     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Query to get the correct  ring geoemtry'
                                                      , 'TMCS_Query_geometry'
                                                      , '99'
                                                      , 'General Error'
                                                      , sqlerrm
                                                      , TMCS_SEC_CTX.GET_CLIENT_ID
                                                      , TMCS_SEC_CTX.GET_USER
                                                      );
End;
FUNCTION TMCS_update_Direction(STR_LONG    NUMBER,
                              STR_LAT     NUMBER,
                              BG_GEOM     MDSYS.SDO_GEOMETRY)
      RETURN VARCHAR2

   AS
      ratio       NUMBER (22, 4);
      tempDir     VARCHAR2 (2);
      BG_LONG     NUMBER (22, 6);
      BG_LAT      NUMBER (22, 6);
      DIR_UP      BOOLEAN;
      DIR_RIGHT   BOOLEAN;

BEGIN
  BG_LONG := BG_GEOM.SDO_POINT.X;
  --dbms_output.put_line ('BG_LONG : ' || BG_LONG );
  BG_LAT := BG_GEOM.SDO_POINT.Y;

  --dbms_output.put_line ('BG_LAT : ' || BG_LAT );


      IF BG_LONG - STR_LONG != 0
      THEN
         ratio := ROUND ( (BG_LAT - STR_LAT) / (BG_LONG - STR_LONG), 3);
      ELSE
         ratio := 0;
      END IF;

      IF BG_LONG > STR_LONG
      THEN
         DIR_RIGHT := TRUE;
      ELSE
         DIR_RIGHT := FALSE;
      END IF;

      IF BG_LAT > STR_LAT
      THEN
         DIR_UP := TRUE;
      ELSE
         DIR_UP := FALSE;
      END IF;



      IF DIR_RIGHT AND DIR_UP
      THEN
         IF ratio >= 0.5 AND ratio < 2
         THEN
            Tempdir := 'NE';
         ELSIF ratio < 0.5
         THEN
            Tempdir := 'E';
         ELSIF ratio >= 2
         THEN
            Tempdir := 'N';
         END IF;
      ELSIF NOT DIR_RIGHT AND DIR_UP
      THEN
         IF ratio <= -2
         THEN
            Tempdir := 'N';
         ELSIF ratio > -2 AND ratio <= -0.5
         THEN
            Tempdir := 'NW';
         ELSIF ratio > -0.5
         THEN
            Tempdir := 'W';
         END IF;
      ELSIF NOT DIR_RIGHT AND NOT DIR_UP
      THEN
         IF ratio >= 0.5 AND ratio < 2
         THEN
            Tempdir := 'SW';
         ELSIF ratio < 0.5
         THEN
            Tempdir := 'W';
         ELSIF ratio >= 2
         THEN
            Tempdir := 'S';
         END IF;
      ELSE
         IF ratio <= -2
         THEN
            Tempdir := 'S';
         ELSIF ratio > -2 AND ratio <= -0.5
         THEN
            Tempdir := 'SE';
         ELSIF ratio > -0.5
         THEN
            Tempdir := 'E';
         END IF;
      END IF;


      IF STR_LONG = BG_LONG AND STR_LAT = BG_LAT
      THEN
         Tempdir := '1';
      END IF;

      IF STR_LONG = BG_LONG AND BG_LAT > STR_LAT
      THEN
         Tempdir := 'N';
      END IF;

      IF STR_LONG = BG_LONG AND BG_LAT < STR_LAT
      THEN
         Tempdir := 'S';
      END IF;

      IF STR_LAT = BG_LAT AND BG_LONG > STR_LONG
      THEN
         Tempdir := 'E';
      END IF;

      IF STR_LAT = BG_LAT AND BG_LONG < STR_LONG
      THEN
         Tempdir := 'W';
      END IF;


  RETURN (Tempdir);
EXCEPTION
  WHEN OTHERS
  THEN
     NULL;

     DBMS_OUTPUT.put_line ('Error : ' || SQLERRM);
END;
Procedure TMCS_CUSTOM_POLY_DEMO_RPT (P_result OUT style
                                    ,p_template   IN VARCHAR2
                                    ,p_geometry  IN MDSYS.SDO_GEOMETRY
                                    ,p_CorelationID IN VARCHAR2 DEFAULT NULL
                                    ) as
l_Client_ID NUMBER;
l_package VARCHAR2(32000);
plsql_block   VARCHAR2(32000);
l_error VARCHAR2(3200);
l_message  VARCHAR2(3200);
BEgin


   BEGIN
    Select Distinct(G_Client_ID)
     into l_Client_ID
     from tmcs_glob_brand_access_tmp;
   EXCEPTION
       when no_data_found then
       l_message := 15;  -- USER Brand Security is not set
       l_error := sqlerrm;
       TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Lasso Tool'
                                                , 'TMCS_CUSTOM_POLY_DEMO_RPT'
                                                , '15'
                                                , 'Security Not Set Properly'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
   END;

  dbms_output.put_line('l_TMCbrand: '||l_Client_ID);

  If l_message is null then

     BEGIN

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) =  l_Client_ID
        and UPPER(TMC_Functionality) = 'LASSO_REPORT';
        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d); END;';


        dbms_output.put_line(l_package||'l_text  --> ' || plsql_block);

        EXECUTE IMMEDIATE plsql_block using p_geometry,p_template,p_CorelationID,out P_result;

     EXCEPTION
        when others then null;
        dbms_output.put_line('CUSTOM_POLY_DEMO_RPT SQL ERROR  --> '|| sqlerrm);
     END;

  End IF;


Exception
    When others then
    l_message := 99;
    DBMS_OUTPUT.PUT_LINE( 'TMCS_CUSTOM_POLY_DEMO_REPORT Error :'|| sqlerrm);
     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Lasso Tool'
                                                , 'TMCS_CUSTOM_POLY_DEMO_RPT'
                                                , l_message
                                                , 'General Error'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
End;
Function TMC_GET_P2P( p_geom1 MDSYS.SDO_GEOMETRY,
                  p_geom2 MDSYS.SDO_GEOMETRY)return VARCHAR2 is

-- SL_DISTANCE, Drive Distance,Drive Minutes

p_output VARCHAR2(320);
l_instance VARCHAR2(3200);
l_env  VARCHAR2(3200);
l_Domain VARCHAR2(3200);
l_response json;
value1 VARCHAR2(1024);
t_http_req     utl_http.req;
t_http_resp    utl_http.resp;
t_request_body varchar2(30000);
t_respond      varchar2(30000);
l_country VARCHAr2(32);

Begin

--    p_geom1 := SDO_GEOMETRY(2001,8307,SDO_POINT_TYPE(-96.814957,32.731841,NULL),NULL, NULL);
--    p_geom2 := SDO_GEOMETRY(2001,8307,SDO_POINT_TYPE(-96.964469,32.885245,NULL),NULL, NULL);


    Select NVL(lower(TMCS_SEC_CTX.GET_COUNTRY_CODE),'usa')
    into l_country
    from dual;

    BEGIN

        select SYS_CONTEXT('USERENV','SERVER_HOST')
         into l_instance
        from dual;

        if   l_instance = 'ip-10-0-0-133' then -- DEV
            l_env := 'DEV';
        Elsif l_instance =  'ip-10-0-3-105' then -- TADEV VPN
            l_env := 'DEV';
        Elsif l_instance =  'ip-10-0-0-142' then -- PROD
            l_env := 'PROD';
        Elsif l_instance = 'ip-10-0-0-154' then -- TEST
            l_env := 'TEST';
        Elsif l_instance = 'ip-10-0-3-114' then -- TEST VPN
                 l_env := 'TEST';
        Elsif l_instance = 'ip-10-0-0-158' then  -- DD UAT
            l_env := 'TEST';
        Elsif l_instance = 'ip-10-0-0-109' then -- DD PROD
            l_env := 'PROD';
        Elsif l_instance = 'ip-10-0-0-165' then -- STAGE
            l_env := 'PROD';
        Else
            l_env := 'PROD';
        End if;

    EXCEPTION
        WHEN no_data_found then null;
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                                , 'TMC_GET_P2P'
                                                , '15'
                                                , 'Configuration not set for this DB Server'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );

    END;



    If UPPER(l_env) = 'DEV' then
        l_Domain := '10.0.3.106:8080'; -- Dev
    ELSIf UPPER(l_env) = 'TEST' then
        l_Domain := '54.221.227.144:8080'; -- Dev
    Elsif UPPER(l_env) = 'PROD' then
        l_Domain := '54.225.87.135:8080';
    End if;

    t_request_body := 'lat1='||p_geom1.SDO_POINT.Y||'&'||'lon1='||p_geom1.SDO_POINT.X||'&'||'lat2='||p_geom2.SDO_POINT.Y||'&'||'lon2='||p_geom1.SDO_POINT.X||'&'||'cn='||l_country||'&'||'apikey=1157c634-d7b1-4769-b997-6712e7b6bde5';
--    dbms_output.Put_line(t_request_body);

    dbms_output.Put_line('http://'||l_Domain||'/tango.com.routing.websvc/rest/p2p?'||t_request_body);

    /*Telling Oracle where the webservice can be found, what kind of request is made
    and the version of the HTTP*/
    t_http_req:= utl_http.begin_request( 'http://'||l_Domain||'/tango.com.routing.websvc/rest/p2p?'||t_request_body);
    /*make the actual request to the webservice en catch the responce in a
    variable*/
    t_http_resp:= utl_http.get_response(t_http_req);

    BEGIN

        LOOP
            utl_http.READ_LINE(t_http_resp, value1, FALSE);
            DBMS_OUTPUT.PUT_LINE(value1);

            if value1 is not null then
--                    DBMS_OUTPUT.PUT_LINE(value1);
                l_response := JSON(value1);
--                    l_response.print;
                p_output := '';
                p_output := p_output||  json_ext.get_number(l_response,'points');

                DBMS_OUTPUT.PUT_LINE('Straignt line Distance : '||p_output);

                if l_country = 'usa' then
                    DBMS_OUTPUT.PUT_LINE('Drive Distance : '||json_ext.get_number(l_response,'mi'));
                    p_output := p_output || '|' ||json_ext.get_number(l_response,'mi');
                else
                    DBMS_OUTPUT.PUT_LINE('Drive Distance : '||json_ext.get_number(l_response,'km'));
                    p_output := p_output || '|' ||json_ext.get_number(l_response,'km');
                End if;

                DBMS_OUTPUT.PUT_LINE('Drive Minutes : '||json_ext.get_number(l_response,'time_min'));
                p_output := p_output || '|' ||json_ext.get_number(l_response,'time_min');

            End if;

        END LOOP;

        DBMS_OUTPUT.PUT_LINE('Final Output : '||p_output);

    EXCEPTION
        WHEN UTL_HTTP.end_of_body THEN
        UTL_HTTP.end_response(t_http_resp);
    END;

    return p_output;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(Sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                            , 'TMC_GET_P2P'
                                            , '99'
                                            , 'General error'
                                            , SQLERRM
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER
                                            );

    p_output:=  SQLERRM;
    return p_output;
End;
FUNCTION TMCS_BATCH_P2P(p_longitude Number,
                                            p_latitude NUMBER,
                                            p_json JSON) return json as
l_Domain VARCHAR2(320);
l_env VARCHAR2(320);
l_instance  VARCHAR2(320);
l_SEND_REQUEST CLOB;
l_URL VARCHAR2(32767);
l_RESPONSE CLOB;
l_json JSON;
l_start      NUMBER DEFAULT DBMS_UTILITY.get_time ;

Begin

    l_json := TMCS_BATCH_P2P_SF(p_longitude,
                        p_latitude,
                        p_json,
                        null
                        );

    return l_json;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
End;
FUNCTION TMCS_BATCH_P2P_SF(p_longitude Number,
                                            p_latitude NUMBER,
                                            p_json JSON,
                                            p_version VARCHAR2 DEFAULT null
                                            ) return json as
l_Domain VARCHAR2(320);
l_env VARCHAR2(320);
l_instance  VARCHAR2(320);
l_SEND_REQUEST CLOB;
l_URL VARCHAR2(32767);
l_RESPONSE CLOB;
l_json JSON;
l_start      NUMBER DEFAULT DBMS_UTILITY.get_time ;
l_version VARCHAR2(320);
Begin
    Begin

        BEGIN
            SELECT  DOMAIN,WIZARD_NAME
            INTO l_URL,l_version
            FROM TMCS_GIS_FUNCTIONALITY_SETUP
            WHERE CLIENT_ID   =  TMCS_SEC_CTX.GET_CLIENT_ID
            AND TMC_FUNCTIONALITY = UPPER('P2P');

        EXCEPTION
            WHEN no_data_found then null;
            BEGIN
                SELECT  DOMAIN,WIZARD_NAME
                INTO l_URL,l_version
                FROM TMCS_GIS_FUNCTIONALITY_SETUP
                WHERE CLIENT_ID  =  0
                AND TMC_FUNCTIONALITY = UPPER('P2P');

            EXCEPTION
                WHEN no_data_found then null;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                                    , 'TMC_GET_P2P'
                                                    , '15'
                                                    , 'Configuration not set for this DB Server'
                                                    , SQLERRM
                                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                                    , TMCS_SEC_CTX.GET_USER
                                                    );
            END;
            WHEN others then null;
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                    , 'TMC_GET_P2P'
                                    , '15'
                                    , 'Configuration not set for this  DB Server'
                                    , SQLERRM
                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                    , TMCS_SEC_CTX.GET_USER
                                    );
        END;


        dbms_output.put_line ('Starting P2P calculations ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

        l_SEND_REQUEST := empty_clob();
        dbms_lob.createtemporary(l_SEND_REQUEST, true);
        JSON.to_clob(p_json,l_SEND_REQUEST);
        l_URL := l_URL || '?lat='||p_latitude||'&'||'lon='||p_longitude||'&'||'cn='||lower(TMCS_SEC_CTX.GET_COUNTRY_CODE())||'&'||'apikey=1157c634-d7b1-4769-b997-6712e7b6bde5';


        if l_version is null then
            l_URL := l_URL;
        Else
            l_URL := l_URL ||'&ver='||l_version;
        End if;

        l_RESPONSE := NULL;

        dbms_output.put_line('P_URL = ' ||l_URL);

        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                                , 'TMC_GET_P2P'
                                                , 'Webservice  Request Initiated : ' ||round((dbms_utility.get_time-l_start)/100, 2)  || 'Seconds..'
                                                , 'P2P'
                                                , l_URL
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
        -- Converting responce to  JSON
        -- Calling Rest Service

         TMCS_GIS_SLM_PKG_VN.TMCS_CALL_POST_REST_WEBSERVICE ( l_SEND_REQUEST, l_URL, l_RESPONSE );

        dbms_output.put_line ('Finished P2P calculations ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                                , 'TMC_GET_P2P'
                                                , 'Webservice  Request Finished : ' ||round((dbms_utility.get_time-l_start)/100, 2)  || 'Seconds..'
                                                , 'P2P'
                                                , DBMS_LOB.SUBSTR(l_RESPONSE,200,1)
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
        -- Converting responce to  JSON
        -- Converting responce to  JSON
        l_json := JSON(l_RESPONSE);


    Exception
        When others then
         DBMS_OUTPUT.PUT_LINE('Error running P2P service : '||sqlerrm);
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                                , 'TMC_GET_P2P'
                                                , 'Erroring after ' ||round((dbms_utility.get_time-l_start)/100, 2)  || 'Seconds..'
                                                , 'P2P Error'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
        DBMS_OUTPUT.PUT_LINE('Error : '|| SUBSTR(l_RESPONSE,0,1000));

    End;

    dbms_lob.freetemporary(l_SEND_REQUEST);
    dbms_lob.freetemporary(l_RESPONSE);
    return l_json;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
End;
FUNCTION TMCS_BATCH_P2P_SF(p_longitude Number,
                                            p_latitude NUMBER,
                                            p_clob CLOB,
                                            p_version VARCHAR2 DEFAULT null) return json as
l_Domain VARCHAR2(320);
l_env VARCHAR2(320);
l_instance  VARCHAR2(320);
l_SEND_REQUEST CLOB;
l_URL VARCHAR2(32767);
l_RESPONSE CLOB;
l_json JSON;
l_start      NUMBER DEFAULT DBMS_UTILITY.get_time ;
l_version VARCHAR2(320);

Begin

    Begin

        BEGIN
            SELECT  DOMAIN,WIZARD_NAME
            INTO l_URL,l_version
            FROM TMCS_GIS_FUNCTIONALITY_SETUP
            WHERE CLIENT_ID   =  TMCS_SEC_CTX.GET_CLIENT_ID
            AND TMC_FUNCTIONALITY = UPPER('P2P');

        EXCEPTION
            WHEN no_data_found then null;
            BEGIN
                SELECT  DOMAIN,WIZARD_NAME
                INTO l_URL,l_version
                FROM TMCS_GIS_FUNCTIONALITY_SETUP
                WHERE CLIENT_ID  =  0
                AND TMC_FUNCTIONALITY = UPPER('P2P');

            EXCEPTION
                WHEN no_data_found then null;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                                    , 'TMC_GET_P2P'
                                                    , '15'
                                                    , 'Configuration not set for this DB Server'
                                                    , SQLERRM
                                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                                    , TMCS_SEC_CTX.GET_USER
                                                    );
            END;
            WHEN others then null;
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                    , 'TMC_GET_P2P'
                                    , '15'
                                    , 'Configuration not set for this  DB Server'
                                    , SQLERRM
                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                    , TMCS_SEC_CTX.GET_USER
                                    );
        END;


        dbms_output.put_line ('Starting P2P calculations ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

        l_SEND_REQUEST :=p_clob;
        l_URL := l_URL || '?lat='||p_latitude||'&'||'lon='||p_longitude||'&'||'cn='||lower(TMCS_SEC_CTX.GET_COUNTRY_CODE())||'&'||'apikey=1157c634-d7b1-4769-b997-6712e7b6bde5';


        if l_version is null then
            l_URL := l_URL;
        Else
            l_URL := l_URL ||'&ver='||l_version;
        End if;

        l_RESPONSE := NULL;

        dbms_output.put_line('P_URL = ' ||l_URL);
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                                , 'TMC_GET_P2P'
                                                , 'Webservice  Request Initiated : ' ||round((dbms_utility.get_time-l_start)/100, 2)  || 'Seconds..'
                                                , 'P2P'
                                                , l_URL
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
        -- Calling Rest Service
          TMCS_GIS_SLM_PKG_VN.TMCS_CALL_POST_REST_WEBSERVICE ( l_SEND_REQUEST, l_URL, l_RESPONSE );
        dbms_output.put_line ('Finished P2P calculations ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                                , 'TMC_GET_P2P'
                                                , 'Webservice  Request Finished : ' ||round((dbms_utility.get_time-l_start)/100, 2)  || 'Seconds..'
                                                , 'P2P'
                                                , DBMS_LOB.SUBSTR(l_RESPONSE,200,1)
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
        -- Converting responce to  JSON
        l_json := JSON(l_RESPONSE);
        dbms_output.put_line ('Finished converting CLOB to JSON  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );


    Exception
        When others then
        DBMS_OUTPUT.PUT_LINE('Error running P2P service : '||sqlerrm);
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                                , 'TMC_GET_P2P'
                                                , 'Erroring after ' ||round((dbms_utility.get_time-l_start)/100, 2)  || 'Seconds..'
                                                , 'P2P Error'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
        DBMS_OUTPUT.PUT_LINE('Error : '|| SUBSTR(l_RESPONSE,0,1000));
--        l_SEND_REQUEST.print();
    End;

    dbms_lob.freetemporary(l_SEND_REQUEST);
    dbms_lob.freetemporary(l_RESPONSE);
    return l_json;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    dbms_lob.freetemporary(l_SEND_REQUEST);
    dbms_lob.freetemporary(l_RESPONSE);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                                , 'TMC_GET_P2P'
                                                , '99'
                                                , 'P2P General Error'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
End;
PROCEDURE TMCS_INTERNAL_SERVICE_GET(p_params VARCHAR2 Default NULL
                                                                  ,p_process VARCHAR2 Default NULL
                                                                  ,p_message OUT VARCHAR2) As


l_url VARCHAR2(3200);
l_instance VARCHAR2(100);
l_ALTX_name VARCHAR2(500);
l_Adomain VARCHAR2(3200);
t_http_req     UTL_HTTP.req;
t_http_resp    UTL_HTTP.resp;
t_request_body VARCHAR2(30000);
t_respond      VARCHAR2(30000);
t_start_pos    INTEGER := 1;
t_output       VARCHAR2(2000);
l_raw_data       RAW(4000);
l_clob_response  CLOB;
l_buffer_size    NUMBER(10) := 100;
value1 VARCHAR2(1024);
l_message  VARCHAR2(1024);
l_json JSON;
Begin

  /*Construct the information you want to send to the webservice.
    Normally this would be in a xml structure. But for a REST-
    webservice this is not mandatory. The webservice i needed to
    call excepts plain test.*/

    BEGIN
        SELECT DOMAIN, WIZARD_NAME
        INTO l_Adomain,
          l_ALTX_name
        FROM TMCS_GIS_FUNCTIONALITY_SETUP
        WHERE CLIENT_ID       =  0
--        AND COUNTRY           = TMCS_SEC_CTX.GET_COUNTRY_CODE
        AND TMC_FUNCTIONALITY = UPPER(p_process);

    EXCEPTION
        WHEN no_data_found THEN
        NULL;
        p_message := 15; --User Brand Security Not Set
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Internal Service Get Request'
                                        , 'TMCS_INTERNAL_SERVICE_GET'
                                        , p_message
                                        , 'No Setup for process '||UPPER(p_process)
                                        , sqlerrm
                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                        , TMCS_SEC_CTX.GET_USER );
    END;

--
--    BEGIN
--        select SYS_CONTEXT('USERENV','SERVER_HOST') --utl_inaddr.get_host_name
--         into l_instance
--        from dual;
--
--         if l_instance =  'ip-10-0-3-105' then -- TADEV VPN
--            l_Adomain     := '127.0.0.1';
--         Elsif l_instance =  'ip-10-0-0-142' then -- PROD
--            l_Adomain     := '10.0.0.145';
--         Elsif l_instance = 'ip-10-0-3-114' then -- TEST VPN
--            l_Adomain     := '10.0.3.110';
--         Elsif l_instance = 'ip-10-0-0-158' then  -- DD UAT
--              l_Adomain     := '127.0.0.1:9753';
--         Elsif l_instance = 'ip-10-0-0-109' then -- DD PROD
--            l_Adomain     := '10.0.0.161';
--         Elsif l_instance = 'ip-10-0-0-165' then -- STAGE
--            l_Adomain     := '10.0.0.132';
--
--         End if;
--
--    EXCEPTION
--        WHEN no_data_found then null;
--        p_message := 15; --User Brand Security Not Set
--    END;
--
    IF l_Adomain is not null then

            l_url := l_Adomain||'?'||p_params;
            dbms_output.Put_line(l_url);

            Begin
                TMCS_call_GET_rest_webservice(l_url
                                                           ,l_clob_response
                                                           );
                dbms_output.Put_line('l_clob_response :'|| TO_CHAR(l_clob_response));

                Begin
                    select EXTRACTVALUE(xmltype(l_clob_response), '/caluclateDTResponse/status')
                    into l_message
                    from dual;
                Exception
                    When others then
                    l_json := JSON(l_clob_response);
                    l_json.print;
                    l_message := json_ext.get_number(l_json,'status');

                End;

                dbms_output.Put_line('l_message :'|| TO_CHAR(l_message));

                if   l_message = '0' then
                     p_message := 1;
                else
                     p_message := l_message;
                End if;

            Exception
                when others then
                 NULL;
                p_message := 15; --User Brand Security Not Set
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Internal Service Get Request'
                                                , 'TMCS_INTERNAL_SERVICE_GET'
                                                , l_url
                                                , 'Web service error for  '||UPPER(p_process)
                                                , sqlerrm
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER );
            End;


    End if;
      dbms_output.Put_line('p_message :'|| p_message);

Exception
When others then
 DBMS_OUTPUT.PUT_LINE('OSM Webservice Drive Time Error :' || sqlerrm);
 p_message := sqlerrm;
End;
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
                        ) AS
l_TMCbrand VARCHAR2(320);
l_SC_ID NUMBER;
l_package   VARCHAR2(3200);
plsql_block VARCHAR2(3200);
l_SC_GEOM MDSYS.SDO_GEOMETRY;

begin

    Begin



        Select CLIENT_CODE
        into l_TMCbrand
        from TMCS_CLIENTS
        where CLIENT_ID = TMCS_SEC_CTX.GET_CLIENT_ID;

        dbms_output.put_line('l_TMCbrand:'|| l_TMCbrand);


    Exception
        when others then
        p_message := 15;  -- USER Brand Security is not set
        dbms_output.put_line('p_message:'|| sqlerrm);
       TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('SC Creation'
                                                , 'TMC_CREATE_SC'
                                                , '15'
                                                , 'Security Not Set Properly'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
    End;

    if l_TMCbrand is not null then

        l_SC_ID := TMCS_SHOPPING_CENTERS_S.nextval;
        l_SC_GEOM := SDO_GEOMETRY(2001,8307,SDO_POINT_TYPE(p_longitude,p_latitude,null),null,null);

        dbms_output.put_line('l_SC_ID:'|| l_SC_ID);

        Begin
            insert into TMCS_SHOPPING_CENTERS_CUSTOM
            (
             OBJECTID
            ,MALLCODE
            ,MALLNAME
            ,MALLLOCA
            ,MALLCITY
            ,MALLSTATE
            ,MALLZIP
            ,COUNTRY
            ,LATITUDE
            ,LONGITUDE
            ,GLA
            ,SHOPPING_CENTER_SRC_CODE
            ,GEOMETRY
            ,SHOPPING_CENTER_ID
            ,CLIENT_ID
            ,BRAND_ID
            ,STATUS
            )
            VALUES
            (
             l_SC_ID
            ,p_mallCode
            ,p_sc_name
            ,p_address
            ,p_city
            ,p_state
            ,p_zipcode
            ,TMCS_SEC_CTX.GET_COUNTRY_CODE
            ,p_latitude
            ,p_longitude
            ,p_gla
            ,l_TMCbrand
            ,l_SC_GEOM
            ,l_SC_ID
            ,TMCS_SEC_CTX.GET_CLIENT_ID
            ,TMCS_SEC_CTX.GET_BRAND_ID
            ,TMCS_GET_DEFAULT_STATUS('OP','SC')
            );

        Exception
            When others then
            p_message := 9;  --     Policy violation error
            dbms_output.put_line('p_message:'|| sqlerrm);
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Create SC'
                                                    , 'TMC_CREATE_SC'
                                                    , p_message
                                                    , 'Error Inserting the SC'
                                                    , SQLERRM
                                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                                    , TMCS_SEC_CTX.GET_USER
                                                    );
            rollback;


        End;

        If p_message is null then

            BEGIN
               TMCS_UPDATE_STD_ATTRIBUTES(p_message
                                                                   ,'SC_CUST'
                                                                   ,l_SC_ID
                                                                   , l_SC_GEOM);

            EXCEPTION
                when others then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                p_message := 14; --Error while updating Standard Attributes
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                , 'TMC_CREATE_SC'
                                                , '14'
                                                ,  'STANDARD_ATTR_UPDATE Client Specific Procedure Not Found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
            END;

        End if;


        If p_message is null then

            BEGIN

                Select TMC_PACKAGE
                into l_package
                from TMCS_GIS_CLIENT_SETUP
                where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID
                and UPPER(TMC_Functionality) = 'UPDATE_SC';
                plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d,:e); END;';


                dbms_output.put_line('l_text  --> ' || plsql_block);

                if l_package is not null then
                    EXECUTE IMMEDIATE plsql_block using OUT p_message,l_SC_ID,p_attr1,p_attr2,p_attr3;
                Else
                    p_message := 1;
                End if;

            EXCEPTION
                when others then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                p_message := 45; --Error while updating Standard Attributes
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Update SC'
                                                        , 'TMC_CREATE_SC'
                                                        , p_message
                                                        , 'UPDATE_SC Client Specific Procedure Not Found'
                                                        , SQLERRM
                                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                                        , TMCS_SEC_CTX.GET_USER
                                                        );
            END;

        End if;




    End if;


Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(Sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                            , 'TMC_GET_P2P'
                                            , '99'
                                            , 'General error'
                                            , SQLERRM
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER
                                            );
End;

PROCEDURE TMCS_STD_ATTRIBUTES_US(P_TYPE     IN  VARCHAR2
                                                            ,P_ID         IN    NUMBER
                                                            ,P_ENTITY_GEOM  IN MDSYS.SDO_GEOMETRY
                                                            ,P_MESSAGE  OUT VARCHAR2) AS

l_distance NUMBER;
L_COUNTY_FIPS NUMBER;
L_COUNTY_NAME VARCHAR2(32000);
L_DMA NUMBER;
L_DMA_NAME  VARCHAR2(32000);
l_MSA NUMBER;
l_MSA_NAME  VARCHAR2(32000);
l_CBSA NUMBER;
l_CBSA_NAME  VARCHAR2(32000);
l_CENSUSREGION  VARCHAR2(32000);
l_CENSUSDIVISION VARCHAR2(32000);
Begin

    -- GET COUNTY


      -- GET DMA
      Begin
            SELECT DMA_ID,    NAME
            INTO L_DMA,    L_DMA_NAME
            FROM TMCS_DESIGNATEDMARKETAREAS
            WHERE SDO_CONTAINS(GEOMETRY ,P_ENTITY_GEOM) = 'TRUE';
      EXCEPTION
            When too_many_rows then
                SELECT DMA_ID,    NAME
                INTO L_DMA,    L_DMA_NAME
                FROM TMCS_DESIGNATEDMARKETAREAS
                WHERE SDO_ANYINTERACT(GEOMETRY ,P_ENTITY_GEOM) = 'TRUE'
                and rownum < 2;

            WHEN no_data_found THEN
                Begin
                    Select SDO_NN_DISTANCE(1), DMA_ID, NAME
                    into l_distance,L_DMA,L_DMA_NAME
                    from TMCS_DESIGNATEDMARKETAREAS
                    where SDO_NN(geometry,P_ENTITY_GEOM,'distance = 10 unit = mile',1) = 'TRUE'
                    and UPPER(COUNTRY) = UPPER(TMCS_SEC_CTX.GET_COUNTRY_CODE);

                    if l_distance <= 20 then
                        NUll;
                    Else
                        L_DMA      := 0;
                        L_DMA_NAME := 'N/A';
                    End if;

                Exception
                    When others then
                        L_DMA      := 0;
                        L_DMA_NAME := 'N/A';
                End;
             WHEN others THEN
                 L_DMA      := 0;
                 L_DMA_NAME := 'N/A';
      END;
      -- GET CBSA


    -- GET MSA


     -- GET Census Regions
      BEGIN
            SELECT NVL(CENSUS_REGION,''),      NVL(CENSUS_DIVISION,'')
            INTO l_CENSUSREGION,      l_CENSUSDIVISION
            FROM TMCS_US_CENSUS_REGIONS
            WHERE SDO_CONTAINS(GEOMETRY ,P_ENTITY_GEOM) = 'TRUE';
      EXCEPTION
         When too_many_rows then
         SELECT NVL(CENSUS_REGION,''),      NVL(CENSUS_DIVISION,'')
            INTO l_CENSUSREGION,      l_CENSUSDIVISION
            FROM TMCS_US_CENSUS_REGIONS
            WHERE SDO_ANYINTERACT(GEOMETRY ,P_ENTITY_GEOM) = 'TRUE'
            and rownum < 2;

      WHEN no_data_found THEN
        l_CENSUSREGION      := 0;
        l_CENSUSDIVISION    := 'N/A';
      END;

    Case UPPER(P_TYPE)

        when 'SITE' then

            update TMCS_SITES_B
            set
              CBSA_ID     = l_CBSA        -- CBSA_ID
            , CBSA_NAME   = l_CBSA_NAME   -- CBSA_NAME
            , MSA_ID      = l_MSA         -- MSA_ID
            , MSA_NAME    = l_MSA_NAME    -- MSA_NAME
            , DMA_ID      = L_DMA         -- DMA_ID
            , DMA_NAME    = L_DMA_NAME    -- DMA_NAME
            , COUNTY_FIPS = L_COUNTY_FIPS -- COUNTY_FIPS
            , COUNTY      = L_COUNTY_NAME -- COUNTY
            , CENSUS_REGION  = l_CENSUSREGION -- Census Region
            , CENSUS_DIVISION = l_CENSUSDIVISION -- Census Division
            where SITE_ID = P_ID;

        when 'TARGET' then

            update TMCS_TARGETS_B
            set
              CBSA_ID     = l_CBSA        -- CBSA_ID
            , CBSA_NAME   = l_CBSA_NAME   -- CBSA_NAME
            , MSA_ID      = l_MSA         -- MSA_ID
            , MSA_NAME    = l_MSA_NAME    -- MSA_NAME
            , DMA_ID      = L_DMA         -- DMA_ID
            , DMA_NAME    = L_DMA_NAME    -- DMA_NAME
            , COUNTY_FIPS = L_COUNTY_FIPS -- COUNTY_FIPS
            , COUNTY      = L_COUNTY_NAME -- COUNTY
            , CENSUS_REGION  = l_CENSUSREGION -- Census Region
            , CENSUS_DIVISION = l_CENSUSDIVISION -- Census Division
            where TARGET_ID = P_ID;

        when 'STORE' then

            update TMCS_ALL_STORES
            set
              CBSA_ID     = l_CBSA        -- CBSA_ID
            , CBSA_NAME   = l_CBSA_NAME   -- CBSA_NAME
            , MSA_ID      = l_MSA         -- MSA_ID
            , MSA_NAME    = l_MSA_NAME    -- MSA_NAME
            , DMA_ID      = L_DMA         -- DMA_ID
            , DMA_NAME    = L_DMA_NAME    -- DMA_NAME
            , COUNTY_FIPS = L_COUNTY_FIPS -- COUNTY_FIPS
            , COUNTY      = L_COUNTY_NAME -- COUNTY
            , CENSUS_REGION  = l_CENSUSREGION -- Census Region
            , CENSUS_DIVISION = l_CENSUSDIVISION -- Census Division
            where STORE_ID = P_ID;

        when 'PROSPECT' then

            update TMCS_PROSPECTS
            set
              CBSA_ID     = l_CBSA        -- CBSA_ID
            , CBSA_NAME   = l_CBSA_NAME   -- CBSA_NAME
            , MSA_ID      = l_MSA         -- MSA_ID
            , MSA_NAME    = l_MSA_NAME    -- MSA_NAME
            , DMA_ID      = L_DMA         -- DMA_ID
            , DMA_NAME    = L_DMA_NAME    -- DMA_NAME
            , COUNTY_FIPS = L_COUNTY_FIPS -- COUNTY_FIPS
            , COUNTY      = L_COUNTY_NAME -- COUNTY
            , CENSUS_REGION  = l_CENSUSREGION -- Census Region
            , CENSUS_DIVISION = l_CENSUSDIVISION -- Census Division
            where PROSPECT_ID = P_ID;

        when 'COMPETITOR' then

            update TMCS_ALL_COMPETITORS
            set
              CBSA_ID     = l_CBSA        -- CBSA_ID
            , CBSA_NAME   = l_CBSA_NAME   -- CBSA_NAME
            , MSA_ID      = l_MSA         -- MSA_ID
            , MSA_NAME    = l_MSA_NAME    -- MSA_NAME
            , DMA_ID      = L_DMA         -- DMA_ID
            , DMA_NAME    = L_DMA_NAME    -- DMA_NAME
            , COUNTY_FIPS = L_COUNTY_FIPS -- COUNTY_FIPS
            , COUNTY      = L_COUNTY_NAME -- COUNTY
            where COMPETITOR_ID = P_ID;

        when 'SC' then

            update TMCS_SHOPPING_CENTERS_STD
            set
              CBSA           = l_CBSA        -- CBSA_ID
            , CBSA_NAME   = l_CBSA_NAME   -- CBSA_NAME
            , MSA_ID      = l_MSA         -- MSA_ID
            , MSA_NAME    = l_MSA_NAME    -- MSA_NAME
            , DMA_ID      = L_DMA         -- DMA_ID
            , DMA_NAME    = L_DMA_NAME    -- DMA_NAME
            , COUNTY_FIPS = L_COUNTY_FIPS -- COUNTY_FIPS
            , COUNTY_NAME      = L_COUNTY_NAME -- COUNTY
            where SHOPPING_CENTER_ID = P_ID;

         when 'SC_CUST' then

            update TMCS_SHOPPING_CENTERS_CUSTOM
            set
              CBSA           = l_CBSA        -- CBSA_ID
            , CBSA_NAME   = l_CBSA_NAME   -- CBSA_NAME
            , MSA_ID      = l_MSA         -- MSA_ID
            , MSA_NAME    = l_MSA_NAME    -- MSA_NAME
            , DMA_ID      = L_DMA         -- DMA_ID
            , DMA_NAME    = L_DMA_NAME    -- DMA_NAME
            , COUNTY_FIPS = L_COUNTY_FIPS -- COUNTY_FIPS
            , COUNTY_NAME      = L_COUNTY_NAME -- COUNTY
            where SHOPPING_CENTER_ID = P_ID;

    End case;

    P_MESSAGE := NULL ;
Exception
    When others then

    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    P_MESSAGE := 14; -- Error while getting Standard Attributes

    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Standard Attributes'
                                            , 'TMCS_STD_ATTRIBUTES_US'
                                            , P_MESSAGE
                                            , 'General Standard Attributes Error  '
                                            , sqlerrm
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );
End;
Function TMCS_P2P_JSON (p_sql VARCHAR2,
                        p_siteID NUMBER,
                        p_GEOMETRY MDSYS.SDO_GEOMETRY) RETURN json  IS

l_json json; -- Output
v_json  json;
l_json_list json_list;


TYPE REFCUR IS REF CURSOR;
V_CUR REFCUR;
V_COUNT NUMBER:=0;
V_COUNT1 NUMBER:=0;
V1 VARCHAR2(4000);
V2 VARCHAR2(4000);
V_DESC DBMS_SQL.DESC_TAB;
V_ID NUMBER;
l_num_value NUMBER;
l_str_value VARCHAR2(3200);
l_date_value  DATE;

begin

    DBMS_OUTPUT.PUT_LINE('sql :'||p_sql);

    -- The below select statement takes a long time to build the JSON list. So replacing it with the ref cursor approach.
--        Select JSON_UTIL_PKG.sql_to_json(p_sql)
--        into l_json_list
--        from dual;


    -- Optimised code for  creating a JSON list from a aselect statement.
      l_json_list := json_list();
      OPEN V_CUR FOR p_sql;

      V_ID:= DBMS_SQL.to_cursor_number(V_CUR);
      DBMS_SQL.DESCRIBE_COLUMNS(V_ID, V_COUNT, V_DESC);

--    DBMS_OUTPUT.PUT_LINE(V_COUNT);

         FOR i IN 1 .. V_COUNT LOOP
    --                DBMS_OUTPUT.put_line(V_DESC(i).col_name|| ' -->' ||V_DESC(i).col_type);

              case TO_NUMBER(V_DESC(i).col_type)
                when 2 then
                    dbms_sql.define_column(V_ID, i, l_num_value);
                when 12 then
                     dbms_sql.define_column(V_ID, i, l_date_value);
                else
                      dbms_sql.define_column(V_ID, i, l_str_value,4000);
             End case;

        END LOOP;


        WHILE DBMS_SQL.FETCH_ROWS(V_ID) > 0 LOOP
             v_json := json();
             FOR i IN 1 .. V_COUNT LOOP
    --                DBMS_OUTPUT.put_line(V_DESC(i).col_name|| ' -->' ||V_DESC(i).col_type);
                      case TO_NUMBER(V_DESC(i).col_type)

                        when 12 then
                            dbms_sql.column_value(V_ID, i, l_date_value);
    --                        DBMS_OUTPUT.put_line(V_DESC(i).col_name|| ' -->' || l_date_value);
                             v_json.put(V_DESC(i).col_name,l_date_value );
                        when 2 then
                            dbms_sql.column_value(V_ID, i, l_num_value);
    --                        DBMS_OUTPUT.put_line(V_DESC(i).col_name|| ' -->' || l_num_value);
                             v_json.put(V_DESC(i).col_name,l_num_value );
                        else
                            dbms_sql.column_value(V_ID, i, l_str_value);
    --                        DBMS_OUTPUT.put_line(V_DESC(i).col_name|| ' -->' || l_str_value);
                             v_json.put(V_DESC(i).col_name,l_str_value );
                     End case;

             END LOOP;
            l_json_list.append(v_json.to_json_value);
        End loop;



--    l_json_list.print;

        l_json := json();

     -- add some members
     l_json.put('UID',p_siteID);
     l_json.path_put('points',l_json_list);

--    l_json.print;
    return l_json;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
End;
Function TMCS_GET_P2P_CLOB(p_longitude Number
                                            ,p_latitude NUMBER
                                            ,P_RADIUS number
                                            ,p_censusType VARCHAR2
                                            ,P_geomtype varchar2
                                            ,p_id number
                                             ) return CLOB AS

--p_longitude Number := -97.3289;
--p_latitude NUMBER := 32.8975;
--P_RADIUS number:= 60;
--P_geomtype varchar2(320):= 'popw';
--p_id number:= '45896';
p_CLOB CLOB;
l_Domain VARCHAR2(320);
l_env VARCHAR2(320);
l_instance  VARCHAR2(320);
l_SEND_REQUEST CLOB;
l_URL VARCHAR2(32767);
l_RESPONSE CLOB;
l_json JSON;
l_start      NUMBER DEFAULT DBMS_UTILITY.get_time ;

Begin
     Begin

        BEGIN

            select SYS_CONTEXT('USERENV','SERVER_HOST')
            into l_instance
            from dual;

            if   l_instance = 'ip-10-0-0-133' then -- DEV
                l_env := 'PROD';
            Elsif l_instance =  'ip-10-0-3-105' then -- TADEV VPN
                l_env := 'PROD';
            Elsif l_instance =  'ip-10-0-0-142' then -- PROD
                l_env := 'PROD';
            Elsif l_instance = 'ip-10-0-0-154' then -- TEST
                l_env := 'PROD';
           Elsif l_instance = 'ip-10-0-3-114' then -- TEST VPN
                 l_env := 'PROD';
            Elsif l_instance = 'ip-10-0-0-158' then  -- DD UAT
                l_env := 'PROD';
            Elsif l_instance = 'ip-10-0-0-109' then -- DD PROD
                l_env := 'PROD';
            Elsif l_instance = 'ip-10-0-0-165' then -- STAGE
                l_env := 'PROD';
            End if;

        EXCEPTION
            WHEN no_data_found then null;
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('P2P Service'
                                                    , 'TMC_GET_P2P'
                                                    , '15'
                                                    , 'Configuration not set for this DB Server'
                                                    , SQLERRM
                                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                                    , TMCS_SEC_CTX.GET_USER
                                                    );

        END;

         DBMS_OUTPUT.PUT_LINE('l_env :'||l_env);

        If UPPER(l_env) = 'DEV' then
            l_Domain := '10.0.3.106:8080'; -- Dev
        ELSIf UPPER(l_env) = 'TEST' then
            l_Domain := '54.221.227.144:8080'; -- Test
        Elsif UPPER(l_env) = 'PROD' then
            l_Domain := '54.225.87.135:8080';
        End if;

        dbms_output.put_line ('Starting P2P calculations ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );

        l_URL := 'http://'||l_Domain||'/BulkP2PWebservice/rest/blkgrp/block?lat='||p_latitude||'&'||'lon='||p_longitude||'&'||'radius='||P_RADIUS||'&'||'data='||p_censusType||'&'||'type='||P_geomtype||'&'||'uid='||p_id||'&'||'cn='||lower(TMCS_SEC_CTX.GET_COUNTRY_CODE())||'&'||'apikey=1157c634-d7b1-4769-b997-6712e7b6bde5';

        l_RESPONSE := NULL;
        dbms_output.put_line('P_URL = ' ||l_URL);

        -- Calling Rest Service
          TMCS_GIS_SLM_PKG_VN.TMCS_CALL_GET_REST_WEBSERVICE (  l_URL, l_RESPONSE );
        dbms_output.put_line ('Finished P2P calculations ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );
        p_CLOB := l_RESPONSE;
        dbms_lob.freetemporary(l_RESPONSE);
    Exception
        When others then
        DBMS_OUTPUT.PUT_LINE('Error running P2P service : '||sqlerrm);

    End;
--       l_json.PRINT();
    return p_CLOB;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
End;
Function TMCS_REMOVE_ISLAND_AND_HOLE(p_siteID NUMBER
                            ,p_srid NUMBER
                            ,p_geom SDO_GEOMETRY
                            ,p_subject SDO_GEOMETRY)  Return MDSYS.SDO_GEOMETRY as

l_returnGeom MDSYS.SDO_GEOMETRY;
l_sql VARCHAR2(320);
l_numElements NUMBER := 0;
l_numRings NUMBER := 0;
l_point MDSYS.SDO_GEOMETRY;
l_extractPoly MDSYS.SDO_GEOMETRY;
l_extractRing  MDSYS.SDO_GEOMETRY;
l_message VARCHAR2(200);
l_elemIDx NUMBER;
l_ringIDX NUMBER;
l_count NUMBER;

Begin

    NULL;

  return l_returnGeom;


Exception
    When others then
    DBMS_OUTPUT.PUT_LINE('Error removing holes :'|| sqlerrm);
      return p_geom;
End;
PROCEDURE TMCS_CREATEJOB(p_jobName VARCHAR2,
                                                p_jobAction VARCHAR2,
                                                p_autoDrop BOOLEAN,
                                                p_params VARCHAR2,
                                                p_message OUT VARCHAR2 ) as

l_array TMCS_GIS_SLM_PKG_VN.l_array;

BEGIN

    DBMS_OUTPUT.PUT_LINE('Begin');
    l_array := TMCS_GIS_SLM_PKG_VN.SPLIT_STRING(p_params,'|');
    DBMS_OUTPUT.PUT_LINE('2');
    DBMS_SCHEDULER.CREATE_JOB (job_name            =>  p_jobName,
                                                           job_type            =>  'STORED_PROCEDURE',
                                                           job_action          =>  p_jobAction,
                                                           number_of_arguments =>  l_array.count,
                                                           start_date          =>  NULL,
                                                           repeat_interval     =>  NULL,
                                                           end_date           =>   sysdate+1,
                                                           auto_drop          =>   p_autoDrop,
                                                           job_class          =>  'DEFAULT_JOB_CLASS',
                                                           comments           =>  p_jobName);
    DBMS_OUTPUT.PUT_LINE('3');

    for l in 1..l_array.count loop

        DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE (
                       job_name                => p_jobName,
                       argument_position       => l,
                       argument_value          => l_array(l));

    End loop;
    p_message := '1';
Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    p_message := '99';
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Create Job'
                                            , 'TMCS_CREATEJOB'
                                            , '99'
                                            , 'Error While creating a job'
                                            , sqlerrm
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );

END;
Procedure TMCS_UPDATE_DEMOGRAPHICS(p_siteID        IN     NUMBER
                                                         ,p_coordinates   IN     MDSYS.SDO_GEOMETRY
                                                         ,p_update        IN     VARCHAR2 DEFAULT NULL
                                                         ,p_entityType  IN VARCHAR2 DEFAULT NULL
                                                         ,p_brand IN NUMBER
                                                         ,p_output        OUT    VARCHAR2
                                                         ) AS

  l_TABLENAME VARCHAR2(32767);
  l_Client_ID NUMBER;
  l_COORDINATES  MDSYS.SDO_GEOMETRY;
  l_package VARCHAR2(3200);
  plsql_block VARCHAR2(32000);
BEGIN

    BEGIN

        Select G_Client_ID
        into l_Client_ID
        from tmcs_glob_brand_access_tmp
        where G_Brand_ID = p_brand;

    EXCEPTION

        When no_data_found then
         p_output := 15; --User Brand Security Not Set
         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG( p_entityType
                                                            , 'TMCS_UPDATE_DEMOGRAPHICS'
                                                            , '15'
                                                            , 'Security Not Set Properly'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
    END;

    if l_Client_ID is not null then

          l_COORDINATES := TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(P_COORDINATES);  --Modify the code to initialize this parameter

          P_OUTPUT := NULL;

            BEGIN

               Select TMC_PACKAGE,DEMOGRAPHICS
               into l_package,l_TABLENAME
               from TMCS_GIS_CLIENT_SETUP
               where UPPER(TMC_Brand) =  l_Client_ID
               and UPPER(TMC_Functionality) = 'GET_DEMOGRAPHICS';

               if l_TABLENAME is null then
                l_TABLENAME := 'TMCS_BG_STI_Q213_DATA';
               End IF;

               IF l_package is not null then
                    plsql_block := 'BEGIN '||l_package||'(:a, :b, :c,:d,:e,:f); END;';
                    dbms_output.put_line(l_package||'l_package  --> ' || plsql_block);
                    EXECUTE IMMEDIATE plsql_block using P_SITEID, l_COORDINATES, P_UPDATE, P_ENTITYTYPE, l_TABLENAME,  out P_OUTPUT ;
               End if;

               --dbms_output.put_line(l_package||'l_text  --> ' || plsql_block);

            EXCEPTION
               when others then null;
               dbms_output.put_line('GET_DEMOGRAPHICS  SQL ERROR  --> '|| sqlerrm);
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(P_ENTITYTYPE
                                                                , 'TMCS_UPDATE_DEMOGRAPHICS'
                                                                , 47
                                                                ,  'GET_DEMOGRAPHICS  ' || ' Client Specific Procedure Not Found'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
            END;

          If P_OUTPUT = 1 then
            COMMIT;
          Else
            DBMS_OUTPUT.PUT_LINE('Error while running Demographics for : '||P_SITEID);
          End if;


    End if;

EXCEPTION
    When others then
       p_output := 99;   -- General ERROR
        rollback;
     dbms_output.put_line('SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(P_ENTITYTYPE
                                                            , 'TMCS_UPDATE_DEMOGRAPHICS'
                                                            , '99'
                                                            ,  'General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
END;
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
                                     ) AS
   l_trade_area_exists VARCHAR2(10);
   l_site_exists VARCHAR2(10);
   l_tradearea_id  NUMBER;
   l_site_name VARCHAR2(256);
   l_forcast_model NUMBER;
   p_coordinates1 MDSYS.SDO_GEOMETRY;
   p_coordinates MDSYS.SDO_GEOMETRY;
   l_TMCbrand   VARCHAR2(10);
   plsql_block  VARCHAR2(500);
   l_package     VARCHAR2(500);
   l_Client_ID   varchar2(50);
   l_regionID NUMBER;
   l_error VARCHAR2(32000);
   l_storeNUmber  VARCHAR2(32000);
 BEGIN
-- dbms_output.put_line('l_SITE_ID: '||p_site_id);

--     tmcs_sec_ctx.set_context(p_user_name);
 dbms_output.put_line('p_user_name:'|| p_user_name);

         Begin
                Select G_Client_ID
                into l_Client_ID
                from tmcs_glob_brand_access_tmp
                where G_Brand_ID = p_brand;

                l_TMCbrand := l_Client_ID;
                dbms_output.put_line('l_TMCbrand:'|| l_TMCbrand);
         Exception
            when others then
            p_message := 15;  -- USER Brand Security is not set
            l_error := sqlerrm;
            dbms_output.put_line('p_message:'|| sqlerrm);
           TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store TA'
                                                                , 'TMCS_MAINTAIN_STORE_TRADEAREAS'
                                                                , '15'
                                                                , 'Security Not Set Properly'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
         End;


        if p_message is null then

                  BEGIN
                       select TMCS_RECTIFY_POLY(p_geom)
                       into p_coordinates1
                       FROM DUAL;
                       dbms_output.put_line('RECTIFIED GEOMETRY:');
                  EXCEPTION
                       when others then
                       dbms_output.put_line('RECTIFIED SQL ERROR ' || sqlerrm);

                       Select SDO_GEOM.SDO_UNION(p_geom,p_geom,0.001)
                        into p_coordinates1
                        from DUAL;
                  END;

              If p_coordinates1 is null then
                 dbms_output.put_line('p_coordinates1 is null');

              End if;
                dbms_output.put_line('p_coordinates1.sdo_srid()  = '|| p_coordinates1.sdo_srid );
               if p_coordinates1.sdo_srid  != 8307 then

                    Begin
                        Select TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(SDO_CS.TRANSFORM(p_coordinates,8307))
                        into p_coordinates
                        from dual;
                    Exception
                        When others then
                        DBMS_OUTPUT.PUT_LINE('GEOMETRY SRID transformation : '||sqlerrm);
                         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store TA'
                                                                  , 'TMCS_MAINTAIN_STORE_TRADEAREAS'
                                                                  , ''
                                                                  , 'GEOMETRY SRID transformation'
                                                                  , sqlerrm
                                                                  , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                  , TMCS_SEC_CTX.GET_USER
                                                                  );
                    End;

               Else
                 p_coordinates := p_coordinates1;--TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(p_coordinates1);
                End if;

                   If p_coordinates is null then
                 dbms_output.put_line('p_coordinates is null');

              End if;

--              dbms_output.put_line('Validate Geometry : '|| SDO_GEOM.VALIDATE_GEOMETRY(p_coordinates,0.001));

              BEGIN
                     dbms_output.put_line('p_site_id: '||p_site_id);
                   SELECT b.store_name,ORG_ID,STORE_NUMBER
                   INTO l_site_name,l_regionID,l_storeNUmber
                   FROM TMCS_ALL_STORES b
                   WHERE b.STORE_ID= p_site_id
                   and  sdo_relate(b.geometry,p_coordinates,'mask=INSIDE')='TRUE';
                   dbms_output.put_line('STORE_NAME: '||l_site_name);

              EXCEPTION

                   when no_data_found then NULL;
                   DBMS_OUTPUT.put_line('sql error: ' || sqlerrm);
                   when too_many_rows then l_trade_area_exists := 1;

                   DBMS_OUTPUT.put_line('sql error: ' || sqlerrm);
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store TA'
                                                                , 'TMCS_MAINTAIN_STORE_TRADEAREAS'
                                                                , '2'
                                                                , 'Store TA Doesn''t encompass the Store - '|| p_site_id
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
              END;

                  IF l_site_name is not null THEN

                           BEGIN
                                select 1
                                into  l_trade_area_exists
                                from  TMCS_ALL_STORES_TA
                                where STORE_ID = p_site_id
                                and TA_TYPE = p_TA_TYPE;

                           EXCEPTION
                                when no_data_found then NULL;
                                when too_many_rows then l_trade_area_exists := 1;

                           END;



                            BEGIN
                                select 1
                                into  l_site_exists
                                from  TMCS_ALL_STORES
                                where STORE_ID = p_site_id;

                           EXCEPTION
                                when no_data_found then NULL;
                                when too_many_rows then l_site_exists := 1;
                           END;

                  --     dbms_output.put_line('l_site_exists: '||l_site_exists);

                           l_tradearea_id := TMCS_TRADEAREA_STORE.nextval;
                  --    dbms_output.put_line('l_tradearea_id: '||l_tradearea_id);

                          IF NVL(l_site_exists,-1) = 1 AND NVL(l_trade_area_exists,-1) = 1 THEN

                                UPDATE  TMCS_ALL_STORES_TA
                                SET     current_status = 'FALSE'
                                ,PRIMARY_FLAG = 'N'
                                ,last_updated_by = p_user_name
                                ,last_update_Date = SYSDATE
                                WHERE   STORE_ID = p_site_id
                                and TA_TYPE = p_TA_TYPE
                                and (
                                         (UPPER(p_TA_STATUS) = 'TRUE'  and current_status= 'TRUE')
                                        or  (UPPER(p_TA_STATUS) = 'FALSE'  and current_status= 'FALSE')
                                      );


                          ELSIF l_site_exists IS NULL THEN
                                  NULL;
            --                   DELETE FROM TMCS_TRADEAREAS_SITES
            --                   WHERE   site_id = p_site_id;
            --                --   dbms_output.put_line('Sucessfully DELETED: ');
                          END IF;


                            IF  NVL(l_site_exists,-1) = 1 THEN

                                    begin
                                                 dbms_output.put_line('BEGIN Inserted: ');
                                            INSERT INTO TMCS_ALL_STORES_TA
                                                                (tradearea_id
                                                                 ,STORE_ID
                                                                 ,STORE_NUMBER
                                                                 ,BRAND_ID
                                                                 ,geometry
                                                                 ,description
                                                                 ,current_status
                                                                 ,created_by
                                                                 ,creation_Date
                                                                 ,last_updated_by
                                                                 ,last_update_Date
--                                                                 ,approved_by
--                                                                 ,approved_on
                                                                 ,org_ID
                                                                 ,Client_ID
                                                                 ,TA_TYPE
                                                                 ,PRIMARY_FLAG
                                                                )
                                            VALUES
                                                                  (l_tradearea_id
                                                                 ,p_site_id
                                                                 ,l_storeNUmber
                                                                 ,p_brand
                                                                 ,p_coordinates
                                                                 ,p_description
                                                                 ,p_TA_STATUS --'TRUE'
                                                                 ,p_user_name
                                                                 ,sysdate
                                                                ,p_user_name
                                                                 ,sysdate
--                                                                 ,NULL
--                                                                 ,NULL
                                                                 ,l_regionID
                                                                 ,l_Client_ID
                                                                 ,p_TA_TYPE
                                                                 ,'Y'
                                                                 );


                                                Begin
                                                        Select TMC_PACKAGE
                                                        into l_package
                                                        from TMCS_GIS_CLIENT_SETUP
                                                        where UPPER(TMC_Brand) =  l_Client_ID
                                                        and UPPER(TMC_Functionality) = 'TA_DEMOGRAPHICS';

                                                        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f ); END;';
                                                        dbms_output.put_line(l_tradearea_id||'plsql_block  --> ' || plsql_block);

                                                        if l_package is not null then
                                                            EXECUTE IMMEDIATE plsql_block using l_tradearea_id,p_coordinates,'TRUE','STORE',tmc_get_demo_table(TMCS_SEC_CTX.GET_CLIENT_ID),OUT p_message;
                                                        End if;

                                                        if p_message != 1 then

                                                            p_message := 5; -- TA Demographics Error
                                                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store TA'
                                                                                                , 'TMCS_MAINTAIN_STORE_TRADEAREAS'
                                                                                                , '5'
                                                                                                ,  'Store Tradearea Demographics Error  '
                                                                                                , SQLERRM
                                                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                                                , p_user_name
                                                                                                );
                                                        END IF;

                                                Exception
                                                  when others then

                                                  dbms_output.put_line('Demographics SQL ERROR  ' || sqlerrm);
                                                   p_message := 5; -- TA Demographics Error
                                                   TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store TA'
                                                                                            , 'TMCS_MAINTAIN_STORE_TRADEAREAS'
                                                                                            , '5'
                                                                                            ,  'Store Tradearea Demographics Error  '
                                                                                            , SQLERRM
                                                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                                            , p_user_name
                                                                                            );
                                                End;

                                                Begin
                                                        l_package := null;
                                                        Select TMC_PACKAGE
                                                        into l_package
                                                        from TMCS_GIS_CLIENT_SETUP
                                                        where UPPER(TMC_Brand) =  l_Client_ID
                                                        and UPPER(TMC_Functionality) = 'GET_TA_SCORE';

                                                        plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d ); END;';

                                                        dbms_output.put_line(l_tradearea_id||'plsql_block  --> ' || plsql_block);

                                                        if l_package is not null then
                                                            EXECUTE IMMEDIATE plsql_block using l_tradearea_id,p_site_id,'STORE',OUT p_message;
                                                        Else
                                                            p_message := 1; -- TA Score Error
                                                        End if;

                                                        if p_message != 1 then

                                                            p_message := 23; -- TA Score Error

                                                        END IF;

                                                Exception
                                                  when others then
                                                  dbms_output.put_line('TA Score SQL ERROR  ' || sqlerrm);
                                                  l_error := sqlerrm;
                                                 TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store TA'
                                                                                            , 'TMCS_MAINTAIN_STORE_TRADEAREAS'
                                                                                            , '23'
                                                                                            ,  'GET_TA_SCORE'||' TA Score Error '
                                                                                            , SQLERRM
                                                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                                            , p_user_name
                                                                                            );
                                                End;


                                    Exception
                                        WHEN OTHERS THEN
                                        p_message := 4;   -- INSERT TA ERROR
                                        rollback;
                                --        dbms_output.put_line('p_message ' || p_message);
                               --         dbms_output.put_line('SQL ERROR ' || sqlerrm);
                                        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store TA'
                                                                                    , 'TMCS_MAINTAIN_STORE_TRADEAREAS'
                                                                                    , '4'
                                                                                    ,  'INSERT TradeArea  '
                                                                                    , SQLERRM
                                                                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                                    , p_user_name
                                                                                    );
                                    End;

                            END IF;
                       --p_message := 1;

                   dbms_output.put_line('TradeArea Insert: '||p_message);
                  ELSE
                       p_message := 2; -- Site Name is Null
                      --  dbms_output.put_line('TradeArea Insert: '||p_message);
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store TA'
                                                                    , 'TMCS_MAINTAIN_STORE_TRADEAREAS'
                                                                    , '2'
                                                                    , 'Site TA Doesn''t encompass the Site - '|| p_site_id
                                                                    , SQLERRM
                                                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                    , p_user_name
                                                                    );
                  END IF;

        Else
         p_message := 15;
         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store TA'
                                                                , 'TMCS_MAINTAIN_STORE_TRADEAREAS'
                                                                , '15'
                                                                , 'Security Not Set Properly'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
        End If;

     If p_message in (1,23) then
       COMMIT;
     ELSE
       rollback;
       -- null;
     END IF;

 -- dbms_output.put_line('p_message' || p_message);


 EXCEPTION
     WHEN OTHERS THEN
        p_message := 3; --|| p_brand;    -- Trade Area Insert Error
        rollback;
        dbms_output.put_line('p_message ' || p_message);
 --    dbms_output.put_line('FINAL SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store TA'
                                                            , 'TMCS_MAINTAIN_STORE_TRADEAREAS'
                                                            , '3'
                                                            ,  'Insert Store TA General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
 END;
PROCEDURE TMCS_UPDATE_MARKETS
                                    (p_message OUT VARCHAR2
                                     ,p_site_id IN NUMBER
                                     ,p_user_name varchar2
                                     ,p_trade_area_type IN VARCHAR2
                                     ,p_description IN VARCHAR2
                                     ,p_brand in VARCHAR2
                                     ,p_geom IN MDSYS.SDO_GEOMETRY
                                     ,p_type IN VARCHAR2
                                     ) AS
   l_trade_area_exists VARCHAR2(10);
   l_site_exists VARCHAR2(10);
   l_tradearea_id  NUMBER;
   l_site_name VARCHAR2(256);
   l_forcast_model NUMBER;
   p_coordinates1 MDSYS.SDO_GEOMETRY;
   p_coordinates MDSYS.SDO_GEOMETRY;
   l_TMCbrand   VARCHAR2(10);
   plsql_block  VARCHAR2(500);
   l_package     VARCHAR2(500);
   l_Client_ID   varchar2(50);
   l_regionID NUMBER;
   l_error VARCHAR2(32000);
   l_storeNUmber  VARCHAR2(32000);
 BEGIN
-- dbms_output.put_line('l_SITE_ID: '||p_site_id);

--     tmcs_sec_ctx.set_context(p_user_name);
 dbms_output.put_line('p_user_name:'|| p_user_name);

         Begin
                Select G_Client_ID
                into l_Client_ID
                from tmcs_glob_brand_access_tmp
                where G_Brand_ID = p_brand;

                l_TMCbrand := l_Client_ID;
                dbms_output.put_line('l_TMCbrand:'|| l_TMCbrand);
         Exception
            when others then
            p_message := 15;  -- USER Brand Security is not set
            l_error := sqlerrm;
            dbms_output.put_line('p_message:'|| sqlerrm);
           TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_type
                                                                , 'TMCS_UPDATE_MARKETS'
                                                                , '15'
                                                                , 'Security Not Set Properly'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , p_user_name
                                                                );
         End;


--        if p_message is null then
--
--                  BEGIN
--                       select TMCS_RECTIFY_POLY(p_geom)
--                       into p_coordinates1
--                       FROM DUAL;
--                       dbms_output.put_line('RECTIFIED GEOMETRY:');
--                  EXCEPTION
--                       when others then
--                       dbms_output.put_line('RECTIFIED SQL ERROR ' || sqlerrm);
--
--                       Select SDO_GEOM.SDO_UNION(p_geom,p_geom,0.001)
--                        into p_coordinates1
--                        from DUAL;
--                  END;
--
--                  If p_coordinates1 is null then
--                     dbms_output.put_line('p_coordinates1 is null');
--
--                  End if;
--
--                    dbms_output.put_line('p_coordinates1.sdo_srid()  = '|| p_coordinates1.sdo_srid );
--
--                   if p_coordinates1.sdo_srid  != 8307 then
--
--                        Begin
--                            Select TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(SDO_CS.TRANSFORM(p_coordinates,8307))
--                            into p_coordinates
--                            from dual;
--                        Exception
--                            When others then
--                            DBMS_OUTPUT.PUT_LINE('GEOMETRY SRID transformation : '||sqlerrm);
--                             TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_type
--                                                                      , 'TMCS_UPDATE_MARKETS'
--                                                                      , NULL
--                                                                      , 'GEOMETRY SRID transformation'
--                                                                      , sqlerrm
--                                                                      , TMCS_SEC_CTX.GET_CLIENT_ID
--                                                                      , TMCS_SEC_CTX.GET_USER
--                                                                      );
--                        End;
--
--                   Else
--                        p_coordinates := p_coordinates1;--TMCS_GIS_SLM_PKG_VN.TMCS_RECTIFY_POLY(p_coordinates1);
--                   End if;
--
--                  If p_coordinates is null then
--                     dbms_output.put_line('p_coordinates is null');
--                  End if;
--
--
--                    BEGIN
--
--                            IF  UPPER(p_type) = 'TERRITORY'  THEN
--
--                                    Update TMCS_TERRITORIES
--                                    set
--                                    LAST_UPDATED_BY   = TMCS_SEC_CTX.GET_USER
--                                    , LAST_UPDATE_DATE   = sysdate
--                                    , GEOMETRY              =  p_coordinates
--                                    where ID = p_site_id;
--
--                            ELSIF  UPPER(p_type) = 'MINIMARKET'  THEN
--
--                                Update TMCS_DUKB_MINIMARKET
--                                set
--                                LAST_UPDATED_BY   = TMCS_SEC_CTX.GET_USER
--                                , LAST_UPDATE_DATE   = sysdate
--                                , GEOMETRY              =  p_coordinates
--                                where ID = p_site_id;
--
--                            END IF;
--
--                    Exception
--                            WHEN OTHERS THEN
--                            p_message := 4;   -- INSERT TA ERROR
--                            rollback;
--                            --        dbms_output.put_line('p_message ' || p_message);
--                            --         dbms_output.put_line('SQL ERROR ' || sqlerrm);
--                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_type
--                                                            , 'TMCS_UPDATE_MARKETS'
--                                                            , '4'
--                                                            , 'UPDATE '|| p_type ||'  TradeArea  '
--                                                            , SQLERRM
--                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
--                                                            , p_user_name
--                                                            );
--                    End;
--
--
--
--                   If  p_message is  null then
--
--                            Begin
--                                    Select TMC_PACKAGE
--                                    into l_package
--                                    from TMCS_GIS_CLIENT_SETUP
--                                    where UPPER(TMC_Brand) =  l_Client_ID
--                                    and UPPER(TMC_Functionality) = 'TA_DEMOGRAPHICS';
--
--                                    plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f ); END;';
--                                    dbms_output.put_line(l_tradearea_id||'plsql_block  --> ' || plsql_block);
--
--                                    if l_package is not null then
--                                        EXECUTE IMMEDIATE plsql_block using p_site_id,p_coordinates,'TRUE',p_type,tmc_get_demo_table(TMCS_SEC_CTX.GET_CLIENT_ID),OUT p_message;
--                                    End if;
--
--                                    if p_message != 1 then
--
--                                        p_message := 5; -- TA Demographics Error
--                                        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_type
--                                                                            , 'TMCS_UPDATE_MARKETS'
--                                                                            , '5'
--                                                                            ,  'Demographics Error  '
--                                                                            , SQLERRM
--                                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
--                                                                            , p_user_name
--                                                                            );
--                                    END IF;
--
--                            Exception
--                              when others then
--
--                              dbms_output.put_line('Demographics SQL ERROR  ' || sqlerrm);
--                               p_message := 5; -- TA Demographics Error
--                               TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_type
--                                                                        , 'TMCS_UPDATE_MARKETS'
--                                                                        , '5'
--                                                                        ,  ' Demographics Error  '
--                                                                        , SQLERRM
--                                                                        , TMCS_SEC_CTX.GET_CLIENT_ID
--                                                                        , p_user_name
--                                                                        );
--                            End;
--
--                   Else
--                         p_message := 2; -- Site Name is Null
--                      --  dbms_output.put_line('TradeArea Insert: '||p_message);
--                        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_type
--                                                                        , 'TMCS_UPDATE_MARKETS'
--                                                                        , '2'
--                                                                        , 'Site TA Doesn''t encompass the Site - '|| p_site_id
--                                                                        , SQLERRM
--                                                                        , TMCS_SEC_CTX.GET_CLIENT_ID
--                                                                        , p_user_name
--                                                                        );
--                   End if;
--
--
--        Else
--         p_message := 15;
--         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_type
--                                                                , 'TMCS_UPDATE_MARKETS'
--                                                                , '15'
--                                                                , 'Security Not Set Properly'
--                                                                , SQLERRM
--                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
--                                                                , p_user_name
--                                                                );
--        End If;

     If p_message in (1,23) then
       COMMIT;
     ELSE
       rollback;
       -- null;
     END IF;

 -- dbms_output.put_line('p_message' || p_message);


 EXCEPTION
     WHEN OTHERS THEN
        p_message := 3; --|| p_brand;    -- Trade Area Insert Error
        rollback;
        dbms_output.put_line('p_message ' || p_message);
 --    dbms_output.put_line('FINAL SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_type
                                                            , 'TMCS_UPDATE_MARKETS'
                                                            , '3'
                                                            ,  'Update '|| p_type ||'  General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );
 END;
function TMCS_GET_MODEL_RAT(P_VAL NUMBER
                                                        ,P_STRING VARCHAR2)
RETURN NUMBER
IS
PRED_VAL NUMBER;
l_MAX_UNIT number;
l_c0 number;
l_b1 number;
l_b2 number;
l_switch number;
l_multi number;
l_b3 number;
l_b4 number;
l_b5 number;
l_b6 number;
l_Max_Flat_val number;
l_min_unit number;
l_CENSUS_DIVISION VARCHAR2(30);
l_CBSA_CLASS number;
l_STORE_CLASS number;
l_sql varchar2(32000);
l_MIN_FLAT_VAL VARCHAR2(320);
BEGIN

    l_sql:= 'select b.MAX_UNIT,b.c0,b.b1,b.b2,b.switch,b.multi,b.b3,b.b4,b.b5,b.b6,b.Max_Flat_val,b.min_unit,b.CENSUS_DIVISION,b.CBSA_CLASS,b.STORE_CLASS,MIN_FLAT_VAL
                                              from TMCS_SF_DECAY_CURVES b
                                              where CLIENT_ID = ' || TMCS_SEC_CTX.GET_CLIENT_ID || ' and COUNTRY= ''' || TMCS_SEC_CTX.GET_COUNTRY_CODE || ''' and ' || P_STRING;


    --dbms_output.put_line(l_sql);

      EXECUTE IMMEDIATE l_sql into l_MAX_UNIT,l_c0,l_b1,l_b2,l_switch,l_multi,l_b3,l_b4,l_b5,l_b6,l_Max_Flat_val,l_min_unit,l_CENSUS_DIVISION,l_CBSA_CLASS,l_STORE_CLASS,l_MIN_FLAT_VAL;

    IF P_VAL<l_MAX_UNIT and P_VAL>l_MIN_UNIT THEN
                                  PRED_VAL:=  (l_c0+(l_b1*p_val)+
                                                                        (l_b2 * POWER((P_VAL-(l_switch)/l_multi), 2))+
                                    (l_b3 * POWER((p_val-(l_switch)/l_multi), 3))+
                                    (l_b4 * POWER((p_val -(l_switch)/l_multi), 4)) +
                                    (l_b5 * POWER((p_val-(l_switch)/l_multi), 5)) +
                                    (l_b6 * POWER((p_val -(l_switch)/l_multi), 6)) )/ l_multi;
    elsif P_VAL >= l_MAX_UNIT Then
        PRED_VAL :=   l_Max_Flat_val;
    elsif P_VAL<= l_MIN_UNIT then
        PRED_VAL :=   l_MIN_FLAT_VAL;
    end if;


    RETURN PRED_VAL;
Exception
    When others then
        DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;
Procedure TMCS_SITE_SCORE(p_message OUT VARCHAR2
                                           ,p_SiteScore out NUMBER
                                           ,p_SiteForecast out NUMBER
                                           ,p_entityID IN NUMBER
                                           ,p_demoScore IN NUMBER
                                           ,p_user_name IN VARCHAR2
                                           ,P_ENTITY_TYPE IN VARCHAR2
                                           ) As
l_package VARCHAR2(320);
plsql_block VARCHAR2(320);

Begin

        Begin

            l_package := null;

            Select TMC_PACKAGE
            into l_package
            from TMCS_GIS_CLIENT_SETUP
            where UPPER(TMC_Brand) =  TMCS_SEC_CTX.GET_CLIENT_ID
            and UPPER(TMC_Functionality) = 'GET_SITE_SCORE';

            plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d , :e, :f, :g); END;';

            dbms_output.put_line('plsql_block  --> ' || plsql_block);

            if l_package is not null then
                EXECUTE IMMEDIATE plsql_block using OUT p_message, OUT p_SiteScore,OUT p_SiteForecast, p_entityID,p_demoScore,p_user_name,P_ENTITY_TYPE;
            Else
                p_message := 1; -- TA Score Error
            End if;

        Exception
          when others then
          dbms_output.put_line('TA Score SQL ERROR  ' || sqlerrm);
          p_message := 1;
         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site TA'
                                                    , 'TMC_MAINTAIN_TRADEAREAS'
                                                    , '48'
                                                    ,   'GET_SITE_SCORE  ' || ' Client Specific Procedure Not Found'
                                                    , SQLERRM
                                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                                    , p_user_name
                                                    );
        End;


Exception
    When others then
     p_message := 99; --|| p_brand;    -- Trade Area Insert Error
        rollback;
        dbms_output.put_line('p_message ' || p_message);
 --    dbms_output.put_line('FINAL SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site Score Calcuolations'
                                                            , 'TMCS_SITE_SCORE'
                                                            , '99'
                                                            ,  'Site Score Calculations General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , p_user_name
                                                            );

End;
Procedure TMCS_UPDATE_STD_ATTRIBUTES(p_message OUT VARCHAR2
                                                                   ,p_entity_type in  VARCHAR2
                                                                   ,p_entityID IN NUMBER
                                                                   ,p_geometry MDSYS.SDO_GEOMETRY) AS


l_package VARCHAR2(320);
plsql_block  VARCHAR2(320);
l_error VARCHAR2(320);
Begin

        BEGIN
                Select TMC_PACKAGE
                into l_package
                from TMCS_GIS_CLIENT_SETUP
                where UPPER(TMC_Brand) =  TMCS_SEC_CTX.GET_CLIENT_ID
                and UPPER(TMC_Functionality) = 'STANDARD_ATTR_UPDATE';

               plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d); END;';
               dbms_output.put_line('l_text  --> ' || plsql_block);

               IF l_package is not null then
                  EXECUTE IMMEDIATE plsql_block using p_entity_type,p_entityID, p_geometry,OUT p_message;
               Else
                  p_message := 1;
                  TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
                                                , 'TMCS_UPDATE_STD_ATTRIBUTES'
                                                , p_message
                                                ,  'STANDARD_ATTR_UPDATE ' || ' Client Specific Procedure Not Set'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
               End if;

        EXCEPTION
                when others then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                p_message := 14; --Error while updating Standard Attributes
                l_error := sqlerrm;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
                                                , 'TMCS_UPDATE_STD_ATTRIBUTES'
                                                , '14'
                                                ,  'STANDARD_ATTR_UPDATE ' || ' Client Specific Procedure Not Found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
        END;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    p_message := 99; --Error while updating Standard Attributes
    l_error := sqlerrm;
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
                            , 'TMCS_UPDATE_STD_ATTRIBUTES'
                            , '99'
                            ,  'General Error'
                            , SQLERRM
                            , TMCS_SEC_CTX.GET_CLIENT_ID
                            , TMCS_SEC_CTX.GET_USER
                            );
End;
Procedure TMCS_SET_ENTITY_DEFAULTS(p_message OUT VARCHAR2
                                                                   ,p_entity_type in  VARCHAR2
                                                                   ,p_entityID IN NUMBER
                                                                  ) AS


l_package VARCHAR2(320);
plsql_block  VARCHAR2(320);
l_error VARCHAR2(320);
Begin

        BEGIN
                Select TMC_PACKAGE
                into l_package
                from TMCS_GIS_CLIENT_SETUP
                where UPPER(TMC_Brand) =  TMCS_SEC_CTX.GET_CLIENT_ID
                and UPPER(TMC_Functionality) = 'SET_ATTR_DEFAULT';

               plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';
               dbms_output.put_line('l_text  --> ' || plsql_block);

               IF l_package is not null then
                  EXECUTE IMMEDIATE plsql_block using p_entity_type,p_entityID, OUT p_message;
               Else
                  p_message := 1;
--                  TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
--                                                , 'TMCS_SET_ENTITY_DEFAULTS'
--                                                , p_message
--                                                ,  'Set Default Attribute   ' || ' Client Specific Procedure Not Set'
--                                                , SQLERRM
--                                                , TMCS_SEC_CTX.GET_CLIENT_ID
--                                                , TMCS_SEC_CTX.GET_USER
--                                                );
               End if;

        EXCEPTION
            when no_data_found then null;
            p_message := null; --Error while updating Standard Attributes
            l_error := sqlerrm;

            when others then null;
            dbms_output.put_line('SQL ERROR ' || sqlerrm);
            p_message := null; --Error while updating Standard Attributes
            l_error := sqlerrm;
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
                                            , 'TMCS_SET_ENTITY_DEFAULTS'
                                            , '14'
                                            ,  'Set Default Attribute  ' || ' Client Specific Procedure Not Found'
                                            , SQLERRM
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER
                                            );
        END;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    p_message := 99; --Error while updating Standard Attributes
    l_error := sqlerrm;
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
                            , 'TMCS_SET_ENTITY_DEFAULTS'
                            , '99'
                            ,  'General Error'
                            , SQLERRM
                            , TMCS_SEC_CTX.GET_CLIENT_ID
                            , TMCS_SEC_CTX.GET_USER
                            );
End;
Procedure TMCS_UPDATE_CUST_ATTR(p_message OUT VARCHAR2
                                                                   ,p_entity_type in  VARCHAR2
                                                                   ,p_entityID IN NUMBER
                                                                   ,p_Json in VARCHAR2
                                                                  ) AS
l_package VARCHAR2(320);
plsql_block  VARCHAR2(320);
l_error VARCHAR2(320);
Begin

        BEGIN
                Select TMC_PACKAGE
                into l_package
                from TMCS_GIS_CLIENT_SETUP
                where UPPER(TMC_Brand) =  TMCS_SEC_CTX.GET_CLIENT_ID
                and UPPER(TMC_Functionality) = 'CUSTOM_ATTR_UPDATE';

               plsql_block := 'BEGIN '||l_package||'(:a, :b, :c,:d); END;';
               dbms_output.put_line('l_text  --> ' || plsql_block);

               IF l_package is not null then
                  EXECUTE IMMEDIATE plsql_block using OUT p_message,p_entity_type,p_Json,p_entityID;
               Else
                  p_message := 1;
--                  TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
--                                                , 'CUSTOM_ATTR_UPDATE'
--                                                , p_message
--                                                ,  'CUSTOM_ATTR_UPDATE   ' || ' Client Specific Procedure Not Set'
--                                                , SQLERRM
--                                                , TMCS_SEC_CTX.GET_CLIENT_ID
--                                                , TMCS_SEC_CTX.GET_USER
--                                                );
               End if;

        EXCEPTION
            when no_data_found then null;
            p_message := null; --Error while updating Standard Attributes
            l_error := sqlerrm;

            when others then null;
            dbms_output.put_line('SQL ERROR ' || sqlerrm);
            p_message := null; --Error while updating Standard Attributes
            l_error := sqlerrm;
            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
                                            , 'TMCS_UPDATE_CUSTOM_ATTRIBUTES'
                                            , '13'
                                            ,  'CUSTOM_ATTR_UPDATE  ' || ' Client Specific Procedure Not Found'
                                            , SQLERRM
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER
                                            );
        END;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    p_message := 99; --Error while updating Standard Attributes
    l_error := sqlerrm;
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
                            , 'TMCS_UPDATE_CUSTOM_ATTRIBUTES'
                            , '99'
                            ,  'General Error'
                            , SQLERRM
                            , TMCS_SEC_CTX.GET_CLIENT_ID
                            , TMCS_SEC_CTX.GET_USER
                            );
End;
Procedure TMCS_CREATE_SITE_TA(p_site_id  IN NUMBER
                                                   ,p_brand IN VARCHAR2
                                                   ,p_user_name IN VARCHAR2
                                                   ,p_trade_area_type IN VARCHAR2
                                                   ,p_description IN VARCHAR2
                                                   ,p_ring_miles IN VARCHAR2
                                                   ,p_message OUT VARCHAR2) AS


plsql_block  VARCHAR2(320);
l_package VARCHAR2(320);
l_error VARCHAR2(320);
Begin


        BEGIN
                Select TMC_PACKAGE
                into l_package
                from TMCS_GIS_CLIENT_SETUP
                where UPPER(TMC_Brand) =  TMCS_SEC_CTX.GET_CLIENT_ID
                and UPPER(TMC_Functionality) = 'GET_SITE_TRADEAREA';

               plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f, :g); END;';
               dbms_output.put_line('l_text  --> ' || plsql_block);

               IF l_package is not null then
                  EXECUTE IMMEDIATE plsql_block using p_site_id,p_brand, p_user_name, p_trade_area_type,p_description,p_ring_miles,OUT p_message;
               ELSE
                    p_message := 1;
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('SITE'
                                                , 'TMCS_CREATE_SITE_TA'
                                                , p_message
                                                ,  'Create Site TA ' || ' Client Specific Procedure Not Set'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
               End if;
           dbms_output.put_line('p_message  ' || p_message);
        EXCEPTION
                when others then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                p_message := 14; --Error while updating Standard Attributes
                l_error := sqlerrm;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('SITE'
                                                , 'TMCS_CREATE_SITE_TA'
                                                , '14'
                                                ,  'Create Site TA ' || ' Client Specific Procedure Not Found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
        END;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    p_message := 99; --Error while updating Standard Attributes
    l_error := sqlerrm;
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('SITE'
                            , 'TMCS_CREATE_SITE_TA'
                            , '99'
                            ,  'General Error'
                            , SQLERRM
                            , TMCS_SEC_CTX.GET_CLIENT_ID
                            , TMCS_SEC_CTX.GET_USER
                            );
End;
Procedure TMCS_CREATE_TARGET_TA(p_target_id  IN NUMBER
                                                   ,p_brand IN VARCHAR2
                                                   ,p_ring_miles IN VARCHAR2
                                                   ,p_user_name IN VARCHAR2
                                                   ,p_message OUT VARCHAR2) AS


plsql_block  VARCHAR2(320);
l_package VARCHAR2(320);
l_error VARCHAR2(320);
Begin


        BEGIN
                Select TMC_PACKAGE
                into l_package
                from TMCS_GIS_CLIENT_SETUP
                where UPPER(TMC_Brand) =  TMCS_SEC_CTX.GET_CLIENT_ID
                and UPPER(TMC_Functionality) = 'GET_TARGET_TRADEAREA';

               plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d,:e); END;';
               dbms_output.put_line('l_text  --> ' || plsql_block);

               IF l_package is not null then
                   EXECUTE IMMEDIATE plsql_block using p_target_id,p_brand,p_ring_miles,p_user_name,OUT p_message;
               ELSE
                    p_message := 1;
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TARGET'
                                                , 'TMCS_CREATE_TARGET_TA'
                                                , p_message
                                                ,  'Create TARGET TA ' || ' Client Specific Procedure Not Set'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
               End if;
           dbms_output.put_line('p_message  ' || p_message);

        EXCEPTION
                when others then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                p_message := 14; --Error while updating Standard Attributes
                l_error := sqlerrm;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TARGET'
                                                , 'TMCS_CREATE_TARGET_TA'
                                                , '14'
                                                ,  'Create TARGET TA ' || ' Client Specific Procedure Not Found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
        END;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    p_message := 99; --Error while updating Standard Attributes
    l_error := sqlerrm;
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TARGET'
                            , 'TMCS_CREATE_TARGET_TA'
                            , '99'
                            ,  'General Error'
                            , SQLERRM
                            , TMCS_SEC_CTX.GET_CLIENT_ID
                            , TMCS_SEC_CTX.GET_USER
                            );
End;
Procedure TMCS_GET_SET_CLASS(p_geometry IN MDSYS.SDO_GEOMETRY
                                                   ,p_entity_type in  VARCHAR2
                                                   ,p_entityID IN NUMBER
                                                   ,P_UPDATE IN VARCHAR2
                                                   ,P_STORE OUT NUMBER
                                                   ,P_CBSA OUT NUMBER
                                                   ) AS


l_package VARCHAR2(320);
plsql_block  VARCHAR2(320);
l_error VARCHAR2(320);
Begin


        BEGIN
                Select TMC_PACKAGE
                into l_package
                from TMCS_GIS_CLIENT_SETUP
                where UPPER(TMC_Brand) =  TMCS_SEC_CTX.GET_CLIENT_ID
                and UPPER(TMC_Functionality) = 'GET_CLASS';

               plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';
               dbms_output.put_line('l_text  --> ' || plsql_block);

               IF l_package is not null then
                  EXECUTE IMMEDIATE plsql_block using p_geometry,OUT P_CBSA,OUT P_STORE;
               End if;

        EXCEPTION
                when others then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                l_error := sqlerrm;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
                                                , 'TMCS_GET_SET_CLASS'
                                                , '14'
                                                ,  'STANDARD_ATTR_UPDATE ' || ' Client Specific Procedure Not Found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
        END;

        if UPPER(P_UPDATE) = 'TRUE' then

            CASE UPPER(p_entity_type)
                WHEN 'SITE' THEN

                    Update TMCS_SITES_B
                    set STORE_CLASS = P_STORE
                    , CBSA_CLASS = P_CBSA
                    where SITE_ID =  p_entityID;

                WHEN 'STORE' THEN

                    Update TMCS_ALL_STORES
                    set STORE_CLASS = P_STORE
                    , CBSA_CLASS = P_CBSA
                    where STORE_ID =  p_entityID;

                WHEN 'TARGET' THEN

                    Update TMCS_TARGETS_B
                    set STORE_CLASS = P_STORE
                    , CBSA_CLASS = P_CBSA
                    where TARGET_ID =  p_entityID;

            End case;

        End IF;


Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    l_error := sqlerrm;
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
                            , 'TMCS_GET_SET_CLASS'
                            , '99'
                            ,  'General Error'
                            , SQLERRM
                            , TMCS_SEC_CTX.GET_CLIENT_ID
                            , TMCS_SEC_CTX.GET_USER
                            );
End;
Procedure TMCS_UPDATE_ENCROACHMENT(p_message OUT VARCHAR2
                                                                 ,p_status OUT VARCHAR2
                                                                 ,p_entity_type in  VARCHAR2
                                                                 ,p_entityID IN NUMBER
                                                                   ) AS
l_functionality_type VARCHAR2(32);
l_package VARCHAR2(320);
plsql_block  VARCHAR2(320);
l_error VARCHAR2(320);
Begin

        BEGIN

                 If UPPER(p_entity_type) = 'SITE' then
                        l_functionality_type := 'SITE_ENCROACHMENT';
                 ElsIf UPPER(p_entity_type) = 'TARGET' then
                        l_functionality_type := 'TGT_ENCROACHMENT';
                 ElsIf UPPER(p_entity_type) = 'STORE' then
                        l_functionality_type := 'STORE_ENCROACHMENT';
                 End if;

                Select TMC_PACKAGE
                into l_package
                from TMCS_GIS_CLIENT_SETUP
                where UPPER(TMC_Brand) =  TMCS_SEC_CTX.GET_CLIENT_ID
                and UPPER(TMC_Functionality) = UPPER(l_functionality_type);

               plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';
               dbms_output.put_line('l_text  --> ' || plsql_block);

               IF l_package is not null then
                  EXECUTE IMMEDIATE plsql_block using  p_entityID,p_entity_type,OUT p_message;
               Else
                    p_message := 1;
--                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
--                                                , 'TMCS_UPDATE_ENCROACHMENT'
--                                                , p_message
--                                                ,  'STANDARD_ATTR_UPDATE ' || ' Client Specific Procedure Not Found'
--                                                , SQLERRM
--                                                , TMCS_SEC_CTX.GET_CLIENT_ID
--                                                , TMCS_SEC_CTX.GET_USER
--                                                );
               End if;

        EXCEPTION
                when no_data_found then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                p_message := 1;
                l_error := sqlerrm;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
                                                , 'TMCS_UPDATE_ENCROACHMENT'
                                                , p_message
                                                , 'No Enchroachments configuration found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );

                when others then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                l_error := sqlerrm;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
                                                , 'TMCS_UPDATE_ENCROACHMENT'
                                                , '14'
                                                ,  'STANDARD_ATTR_UPDATE Client Specific Procedure Not Found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
        END;

        if p_message = 1 then
                p_status := 'Successfully Re-Calculated';
        End if;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entity_type
                                                , 'TMCS_UPDATE_ENCROACHMENT'
                                                , 99
                                                ,  'STANDARD_ATTR_UPDATE ' || ' Client Specific Procedure Not Found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
End;
PROCEDURE TMC_VERSION_TARGET_TRADEAREA
                                (p_message OUT NUMBER
                                ,p_json IN VARCHAR2
                                )AS
l_tatype  VARCHAR2(32000);
l_param1 VARCHAR2(32000):= '';
l_param2 VARCHAR2(32000):= '';
l_param3 VARCHAR2(32000):= '';
l_param4 VARCHAR2(32000):= '';
l_param5 VARCHAR2(32000):= '';
l_param6 VARCHAR2(32000):= '';
l_param7 VARCHAR2(32000):= '';
l_param8 VARCHAR2(32000):= '';
l_param9 VARCHAR2(32000) := '';
l_param10 VARCHAR2(32000):= '';
l_param11 VARCHAR2(32000):= '';
l_param12 VARCHAR2(32000):= '';
l_param13 VARCHAR2(32000):= '';
l_param14 VARCHAR2(32000):= '';
l_param15 VARCHAR2(32000):= '';
 BEGIN

        l_param1 :=  json_ext.get_string(JSON(p_json),'p_oldTAId');                    --entitytype;
        l_param2 := json_ext.get_string(JSON(p_json),'p_entity_id');                      --p_site_id;

        Select TA_TYPE
        into l_tatype
        from tmcs_tradeareas_targets
        where tradearea_id = l_param1
        and  target_ID = l_param2 ;


       UPDATE  tmcs_tradeareas_targets
       SET current_status='FALSE'
       , Last_Update_Date = sysdate
       , Last_Updated_By = TMCS_SEC_CTX.GET_USER
       , PRIMARY_FLAG = 'N'
       WHERE target_ID = l_param2
       AND current_status = 'TRUE'
       and TA_TYPE = l_tatype;

       UPDATE  tmcs_tradeareas_targets
       SET current_status='TRUE'
       , Last_Update_Date = sysdate
       , Last_Updated_By = TMCS_SEC_CTX.GET_USER
       , PRIMARY_FLAG = 'Y'
       WHERE tradearea_id = l_param1
       and target_ID = l_param2;

       COMMIT;
       p_message := 1;

 EXCEPTION
     WHEN OTHERS THEN
        p_message := 99;
        rollback;
 END;
 PROCEDURE TMC_VERSION_STORE_TRADEAREA
                                (p_message OUT NUMBER
                                ,p_json IN VARCHAR2
                                )AS
l_tatype  VARCHAR2(32000);
l_param1 VARCHAR2(32000):= '';
l_param2 VARCHAR2(32000):= '';
l_param3 VARCHAR2(32000):= '';
l_param4 VARCHAR2(32000):= '';
l_param5 VARCHAR2(32000):= '';
l_param6 VARCHAR2(32000):= '';
l_param7 VARCHAR2(32000):= '';
l_param8 VARCHAR2(32000):= '';
l_param9 VARCHAR2(32000) := '';
l_param10 VARCHAR2(32000):= '';
l_param11 VARCHAR2(32000):= '';
l_param12 VARCHAR2(32000):= '';
l_param13 VARCHAR2(32000):= '';
l_param14 VARCHAR2(32000):= '';
l_param15 VARCHAR2(32000):= '';
 BEGIN

        l_param1 :=  json_ext.get_string(JSON(p_json),'p_oldTAId');                    --entitytype;
        l_param2 := json_ext.get_string(JSON(p_json),'p_entity_id');                      --p_site_id;

        Select TA_TYPE
        into l_tatype
        from TMCS_ALL_STORES_TA
        where STORE_ID = l_param2
        and tradearea_id = l_param1;


       UPDATE  TMCS_ALL_STORES_TA
       SET current_status='FALSE'
       , Last_Update_Date = sysdate
       , Last_Updated_By = TMCS_SEC_CTX.GET_USER
       , PRIMARY_FLAG = 'N'
       WHERE STORE_ID = l_param2
       AND current_status = 'TRUE'
       and TA_TYPE = l_tatype;

       UPDATE  TMCS_ALL_STORES_TA
       SET current_status='TRUE'
       , Last_Update_Date = sysdate
       , Last_Updated_By = TMCS_SEC_CTX.GET_USER
       , PRIMARY_FLAG = 'Y'
       WHERE tradearea_id = l_param1
       and STORE_ID = l_param2;

       COMMIT;
       p_message := 1;

 EXCEPTION
     WHEN OTHERS THEN
        p_message := 2;
        rollback;
 END;
PROCEDURE TMCS_UNION_GEOMETRY_ARRAY(p_ID IN NUMBER
                                                            ,p_geoemtry IN MDSYS.SDO_GEOMETRY
                                                            ,p_finalPoly OUT  MDSYS.SDO_GEOMETRY )AS

l_finalPoly MDSYS.SDO_GEOMETRY;
l_extractPoly  MDSYS.SDO_GEOMETRY;
l_numElements NUMBER;

Begin
--        TMCS_GIS_SLM_PKG_VN.TMCS_DELETE_DATA_COMMIT('TEMP_TERR_POLYGON',' ID  = '||''''||p_ID||'''');
--        l_numElements := SDO_UTIL.GETNUMELEM(p_geoemtry);
--        DBMS_OUTPUT.PUT_LINE('l_numElements :'||l_numElements);
--
--        For l in 1..l_numElements loop
--            l_extractPoly := SDO_UTIL.EXTRACT( p_geoemtry,l);
--            insert into TEMP_TERR_POLYGON
--            (ID,ELEMENT_IDX,GEOMETRY)
--            VALUES (p_ID,l,l_extractPoly);
--        End loop;
--        DBMS_OUTPUT.PUT_LINE('l_numElements :'||l_numElements);
--        Select SDO_AGGR_UNION(SDOAGGRTYPE(GEOMETRY,0.05))
--        into p_finalPoly
--        from TEMP_TERR_POLYGON
--        where ID = TO_CHAR(p_ID);

--    insert into TEMP_TMCS_TA_SITES (SITE_ID,GEOMETRY,TA_TYPE) values(p_ID,l_finalPoly,'AGG UNION');
--    commit;
    NULL;
Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
End;
Procedure TMCS_UPDATE_IDX_RPT_DEMOGS(p_TAID      IN NUMBER ,
                                                            p_update      IN VARCHAR2 DEFAULT NULL ,
                                                            p_entityType  IN VARCHAR2 DEFAULT NULL ,
                                                            p_output OUT VARCHAR2
                                                         ) AS

  l_TABLENAME VARCHAR2(32767);
  l_Client_ID NUMBER;
  l_COORDINATES  MDSYS.SDO_GEOMETRY;
  l_package VARCHAR2(3200);
  plsql_block VARCHAR2(32000);
BEGIN

    BEGIN

        Select G_Client_ID
        into l_Client_ID
        from tmcs_glob_brand_access_tmp
        where G_Brand_ID = TMCS_SEC_CTX.GET_BRAND_ID;

    EXCEPTION

        When no_data_found then
         p_output := 15; --User Brand Security Not Set
         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG( p_entityType
                                                            , 'TMCS_UPDATE_IDX_RPT_DEMOGS'
                                                            , '15'
                                                            , 'Security Not Set Properly'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
    END;

    if l_Client_ID is not null then


            BEGIN

               Select TMC_PACKAGE,DEMOGRAPHICS
               into l_package,l_TABLENAME
               from TMCS_GIS_CLIENT_SETUP
               where UPPER(TMC_Brand) =  l_Client_ID
               and UPPER(TMC_Functionality) = 'IDX_REPORT';

               IF l_package is not null then
                    plsql_block := 'BEGIN '||l_package||'(:a, :b, :c,:d); END;';
                    dbms_output.put_line(l_package||'l_package  --> ' || plsql_block);
                    EXECUTE IMMEDIATE plsql_block using p_TAID,  P_UPDATE, P_ENTITYTYPE,  out P_OUTPUT ;
               End if;

               --dbms_output.put_line(l_package||'l_text  --> ' || plsql_block);

            EXCEPTION
               when others then null;
               dbms_output.put_line('GET_IDX_RPT_DEMOGRAPHICS  SQL ERROR  --> '|| sqlerrm);
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(P_ENTITYTYPE
                                                                , 'TMCS_UPDATE_IDX_RPT_DEMOGS'
                                                                , 47
                                                                ,  'GET_IDX_RPT_DEMOGRAPHICS  ' || ' Client Specific Procedure Not Found'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
            END;

          If P_OUTPUT = 1 then
            COMMIT;
          End if;


    End if;

EXCEPTION
    When others then
       p_output := 99;   -- General ERROR
        rollback;
     dbms_output.put_line('SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(P_ENTITYTYPE
                                                            , 'TMCS_UPDATE_IDX_RPT_DEMOGS'
                                                            , '99'
                                                            ,  'General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
END;
--Procedure TMC_Move_Entity(p_entityType VARCHAR2,
--                                        p_entityID VARCHAR2,
--                                        p_newLong NUMBER,
--                                        p_newLat NUMBER,
--                                        p_message OUT VARCHAR2
--                                        ) As
--
--l_entityNumber VARCHAr2(320);
--l_email VARCHAR2(32000);
--l_subj VARCHAR2(3200);
--l_body VARCHAR2(3200);
--l_orgID NUMBER;
--l_oldLong NUMBER;
--l_oldLat NUMBER;
--
----Cursor c1 is
----select EMAIL
----from tmcs_resource_boundaries a, tmcs_resource_boundaries_dtl b
----where a.resource_boundry_id = b.resource_boundry_id
----and UPPER(RESOURCE_ROLE) = 'MOVE_ADMIN'
---- and SDO_CONTAINS(a.geometry,
----                  SDO_GEOMETRY(2001,8307,SDO_POINT_TYPE(p_newLong,p_newLat,NULL),NULL,NULL)) = 'TRUE';
--
--l_moveID NUMBER;
--l_URL  VARCHAR2(32000);
--l_template VARCHAR2(32000);
--l_response CLOB;
--Cursor c1 is
--select DISTINCT(Email)  from TMCS_MOVE_ADMINS_V;
--
--Begin
--     Begin
--        Case upper(p_entityType)
--
--            When 'STORE' then
--                Select LONGITUDE,LATITUDE,ORG_ID,STORE_NUMBER
--                into l_oldLong,l_oldLat,l_orgID,l_entityNumber
--                from TMCS_ALL_STORES
--                where STORE_ID = p_entityID;
--            When 'SITE' then
--                Select LONGITUDE,LATITUDE,ORG_ID,SITE_NUMBER
--                into l_oldLong,l_oldLat,l_orgID,l_entityNumber
--                from TMCS_SITES_B
--                where SITE_ID = p_entityID;
--            When 'TARGET' then
--                Select LONGITUDE,LATITUDE,ORG_ID,TARGET_NUMBER
--                into l_oldLong,l_oldLat,l_orgID,l_entityNumber
--                from TMCS_TARGETS_B
--                where TARGET_ID = p_entityID;
--            When 'COMPETITOR' then
--                Select LONGITUDE,LATITUDE,ORG_ID,STORE_NUMBER
--                into l_oldLong,l_oldLat,l_orgID,l_entityNumber
--                from TMCS_ALL_COMPETITORS
--                where COMPETITOR_ID = p_entityID;
--            When 'SC' then
--                Select LONGITUDE,LATITUDE,ORG_ID,MALLCODE
--                into l_oldLong,l_oldLat,l_orgID,l_entityNumber
--                from TMCS_SHOPPING_CENTERS
--                where SHOPPING_CENTER_ID = p_entityID;
--
--        End Case;
--
--        dbms_output.put_line(p_entityType || ' -->  '|| p_entityID || ' -->  '||  l_oldLong|| ' ;  '  || l_oldLat);
--
--        l_moveID := TMCS_MOVE_ENTITY_S.nextval;
--
--        Insert into TMCS_MOVE_ENTITY
--        (
--             MOVE_ID
--            ,ENTITY_TYPE
--            ,ENTITY_ID
--            ,ENTITY_NUMBER
--            ,OLD_LONGITUDE
--            ,OLD_LATITUDE
--            ,NEW_LONGITUDE
--            ,NEW_LATITUDE
--            ,STATUS
--            ,ORG_ID
--            ,CLIENT_ID
--            ,BRAND_ID
--            ,CREATION_DATE
--            ,CREATED_BY
--            ,LAST_UPDATE_DATE
--            ,LAST_UPDATED_BY
--            ,COUNTRY
--        )
--        Values
--        (
--            l_moveID
--            ,p_entityType
--            ,p_entityID
--            ,l_entityNumber
--            ,l_oldLong
--            ,l_oldLat
--            ,p_newLong
--            ,p_newLat
--            ,'Pending'
--            ,NULL
--            ,TMCS_SEC_CTX.GET_CLIENT_ID
--            ,TMCS_SEC_CTX.GET_BRAND_ID
--            ,sysdate
--            ,TMCS_SEC_CTX.GET_USER
--            ,sysdate
--            ,TMCS_SEC_CTX.GET_USER
--            ,TMCS_SEC_CTX.GET_COUNTRY_CODE
--        );
--
--        Commit;
--
--        -- Sending notification to Admin User
--
--            l_email := null;
--
--            For r1 in c1 loop
--            l_email :=  r1.EMAIL || ',' || l_email;
--
--            End loop;
--
--            DBMS_OUTPUT.PUT_LINE('l_email '||l_email);
--
--
--            Begin
--                SELECT  DOMAIN,WIZARD_NAME
--                INTO l_URL,l_template
--                FROM TMCS_GIS_FUNCTIONALITY_SETUP
--                WHERE CLIENT_ID       =  0
--                AND TMC_FUNCTIONALITY = UPPER('INITIATION');
--
--            Exception
--                When others then
--                DBMS_OUTPUT.PUT_LINE(sqlerrm);
--                --l_URL := 'http://10.0.3.155:8080/transformation/';
--            End;
--
--
--
--            Begin
--                l_url :=  l_url || '?template=' ||l_template ||'&'||'to='||l_email||'&'||'p_moveID='||l_moveID;
--
--                dbms_lob.createtemporary(l_response, true);
--                TMCS_GET_REST_W_HEADERS(l_url,l_response);
--
--                DBMS_OUTPUT.PUT_LINE('l_url '||l_url);
--
--                if UPPER(json_ext.get_string(JSON(l_response),'statusmessage')) = 'SUCCESS' then
--                   p_message := 81;
--                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entityType
--                                        , 'TMC_Move_Entity'
--                                        , 'Request Received from WebService'
--                                        , l_URL
--                                        , SUBSTR(l_response,0,500)
--                                        , TMCS_SEC_CTX.GET_CLIENT_ID
--                                        , TMCS_SEC_CTX.GET_USER );
--                Else
--                    p_message := '64';
--                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entityType
--                                        , 'TMC_Move_Entity'
--                                        , '64'
--                                        , 'Kettle  Transformation error'
--                                        , SUBSTR(l_response,0,500)
--                                        , TMCS_SEC_CTX.GET_CLIENT_ID
--                                        , TMCS_SEC_CTX.GET_USER );
--                End if;
--
--
--            Exception
--                When no_data_found then
--                p_message := '83';
--                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entityType
--                                                    , 'TMC_Move_Entity'
--                                                    , p_message
--                                                    , 'Admin User has not been set for this client  '
--                                                    , SQLERRM
--                                                    , TMCS_SEC_CTX.GET_CLIENT_ID
--                                                    , TMCS_SEC_CTX.GET_USER
--                                                    );
--            End ;
--
--
--     Exception
--        When no_data_found then
--        p_message := '82';
--        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entityType
--                                            , 'TMC_Move Entity'
--                                            , p_message
--                                            , ' User doesnt have permission  to move the specified '|| p_entityType
--                                            , SQLERRM
--                                            , TMCS_SEC_CTX.GET_CLIENT_ID
--                                            , TMCS_SEC_CTX.GET_USER
--                                            );
--
--     End;
--
--Exception
--    When others then
--    p_message := 99;
--    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(p_entityType
--                                        , 'TMC_Move Entity'
--                                        , p_message
--                                        ,  'General Error '
--                                        , SQLERRM
--                                        , TMCS_SEC_CTX.GET_CLIENT_ID
--                                        , TMCS_SEC_CTX.GET_USER
--                                        );
--End;
FUNCTION TMC_Move_Entity_Email( p_batchID NUMBER
                                , p_BATCH_STATUS VARCHAR2 ) RETURN VARCHAR2 AS

Cursor c1 is
Select UPPER(Status) as STATUS,CREATED_BY
from TMCS_MOVE_ENTITY
where BATCH_ID = p_batchID
and UPPER(Status) = p_BATCH_STATUS
group by  UPPER(Status),CREATED_BY;

l_message VARCHAR2(3200);
l_entityNumber VARCHAr2(320);
l_subj VARCHAR2(3200);
l_email VARCHAR2(3200);
l_response  CLOB;
l_URL VARCHAR2(3200);
l_template VARCHAR2(3200);

Begin


        For r1 in c1 loop

            if p_BATCH_STATUS in ('APPROVED','FIXED') then
                Begin

                    SELECT  DOMAIN,WIZARD_NAME
                    INTO l_URL,l_template
                    FROM TMCS_GIS_FUNCTIONALITY_SETUP
                    WHERE CLIENT_ID       =  0
                    AND TMC_FUNCTIONALITY = UPPER('APPROVE/REJECT EMAIL');

                Exception
                    When others then
                    DBMS_OUTPUT.PUT_LINE(sqlerrm);
                    --l_URL := 'http://10.0.3.155:8080/transformation/';
                End;

            ELSIF p_BATCH_STATUS in ('FAILED') then

                Begin

                    SELECT  DOMAIN,WIZARD_NAME
                    INTO l_URL,l_template
                    FROM TMCS_GIS_FUNCTIONALITY_SETUP
                    WHERE CLIENT_ID       =  0
                    AND TMC_FUNCTIONALITY = UPPER('FAILED EMAIL');

                Exception
                    When others then
                    DBMS_OUTPUT.PUT_LINE(sqlerrm);
                    --l_URL := 'http://10.0.3.155:8080/transformation/';
                End;

            ELSIF p_BATCH_STATUS in ('REJECTED','FAILED') then

                Begin

                    SELECT  DOMAIN,WIZARD_NAME
                    INTO l_URL,l_template
                    FROM TMCS_GIS_FUNCTIONALITY_SETUP
                    WHERE CLIENT_ID       =  0
                    AND TMC_FUNCTIONALITY = UPPER('APPROVE/REJECT EMAIL');

                Exception
                    When others then
                    DBMS_OUTPUT.PUT_LINE(sqlerrm);
                    --l_URL := 'http://10.0.3.155:8080/transformation/';
                End;

            End if;


            Begin

                Select EMAIL_ADDRESS
                into l_email
                from TMCS_USERS
                where upper(user_name) = upper(r1.CREATED_BY)
                and rownum < 2;

                DBMS_OUTPUT.PUT_LINE('l_email '||l_email);


                l_url :=  l_url || '?template=' ||l_template ||'&'||'to='||l_email||'&'||'p_user='||r1.CREATED_BY||'&'||'p_batchID=' ||p_batchID;

                dbms_lob.createtemporary(l_response, true);
                TMCS_GET_REST_W_HEADERS(l_url,l_response);

                DBMS_OUTPUT.PUT_LINE('l_url '||l_url);

                if UPPER(json_ext.get_string(JSON(l_response),'statusmessage')) = 'SUCCESS' then
                    l_message := '1';
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Rest Webservice with Headsers'
                                        , 'TMCS_GET_REST_W_HEADERS'
                                        , 'Request Received from WebService'
                                        , l_URL
                                        , SUBSTR(l_response,0,500)
                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                        , TMCS_SEC_CTX.GET_USER );
                Else
                    l_message := '64';
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Rest Webservice with Headsers'
                                        , 'TMCS_GET_REST_W_HEADERS'
                                        , '64'
                                        , 'Kettle  Transformation error'
                                        , SUBSTR(l_response,0,500)
                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                        , TMCS_SEC_CTX.GET_USER );
                End if;

            Exception
                When no_data_found then
                l_message := '83';
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(' Move Entity Email'
                                                        , 'TMC_Move_Entity_Email'
                                                        , l_message
                                                        , 'Created by  User has not been set for this batch :  ' || p_batchID
                                                        , SQLERRM
                                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                                        , TMCS_SEC_CTX.GET_USER
                                                        );

            End ;

        End loop;
    dbms_lob.freetemporary(l_response);
    return l_message;

Exception
     When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    l_MESSAGE := 99;
    dbms_lob.freetemporary(l_response);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(' Move Entity Email'
                                                            , 'TMC_Move_Entity_Email'
                                                            , l_MESSAGE
                                                            ,  'General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
End;
Procedure TMC_Approved_Move_Entity ( p_batchID NUMBER ) AS


p_message  VARCHAR2(32000);
l_jobName VARCHAR2(320);
l_message VARCHAR2(320);

Cursor c1 is
Select UPPER(Status) as STATUS,CREATED_BY
from TMCS_MOVE_ENTITY
where BATCH_ID = p_batchID
group by  UPPER(Status),CREATED_BY;

Begin

    For r1 in c1 loop

           If r1.STATUS  = 'IN_PROGRESS' then
                    l_jobName:=  'MOVE_ENTITY_BATCH_'||TO_CHAR(p_batchID) ;

                    DBMS_OUTPUT.PUT_LINE('l_jobName '||l_jobName);

                    TMCS_GIS_SLM_PKG_VN.TMCS_CREATEJOB(
                                               l_jobName,
                                                'TMCS_GIS_SLM_PKG_VN.TMCS_Approved_Move_Entity_EJOB',
                                               TRUE,
                                                'p_batchID',
                                                l_message);

                     DBMS_OUTPUT.PUT_LINE('l_message '||l_message);

                     if l_message = '1' then
                            DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE (
                                     job_name            => l_jobName,
                                     argument_position   => 1,
                                     argument_value      => p_batchID);

                          commit;
                          DBMS_SCHEDULER.RUN_JOB (JOB_NAME              => l_jobName,
                                                                         USE_CURRENT_SESSION   => FALSE);

                            l_message := '60';
                     End if;

           ELSIF r1.STATUS  = 'REJECTED' then

                l_message := TMC_Move_Entity_Email( p_batchID, 'REJECTED' );

           End if;

    End Loop;


Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    l_MESSAGE := 99;
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(' Approved Move Entity'
                                                            , 'TMC_Approved_Move_Entity'
                                                            , l_MESSAGE
                                                            ,  'General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
End;
Procedure TMCS_Approved_Move_Entity_EJOB ( p_batchID NUMBER) AS

l_MESSAGE VARCHAR2(320);

Cursor c1 is
Select MOVE_ID,ENTITY_TYPE,ENTITY_ID,NEW_LONGITUDE,NEW_LATITUDE,BRAND_ID,CREATED_BY,CLIENT_ID,COUNTRY
from TMCS_MOVE_ENTITY
where
BATCH_ID = p_batchID
and UPPER(STATUS) = 'IN_PROGRESS' ;
--UPPER(STATUS) = 'PENDING' ;

Begin

         dbms_output.put_line('BATCH_ID : '|| p_batchID);
--         dbms_output.put_line('Count : '|| r1.count );
        For r1 in c1 loop

--                tmcs_general_pkg. TMCS_SEC_CTX_DYNAMIC(r1.CREATED_BY,r1.COUNTRY,r1.CLIENT_ID,r1.BRAND_ID);
                dbms_output.put_line('ENTITY_TYPE : '|| r1.ENTITY_TYPE);

                 Begin

                            Case UPPER(r1.ENTITY_TYPE)

                                When 'SITE' then
                                    Update TMCS_SITES_B
                                    set LONGITUDE = r1.NEW_LONGITUDE
                                    ,LATITUDE = r1.NEW_LATITUDE
                                    , LAST_UPDATED_BY =  TMCS_SEC_CTX.GET_USER
                                    , LAST_UPDATE_DATE = sysdate
                                    where SITE_ID = r1.ENTITY_ID;

                                      TMCS_CREATE_SITE_TA(r1.ENTITY_ID
                                                                       ,r1.BRAND_ID
                                                                       ,r1.CREATED_BY
                                                                       ,NULL
                                                                       ,NULL
                                                                       ,NULL
                                                                       ,l_MESSAGE );

                                When 'TARGET' then
                                    Update TMCS_TARGETS_B
                                    set LONGITUDE = r1.NEW_LONGITUDE
                                    ,LATITUDE = r1.NEW_LATITUDE
                                    , LAST_UPDATED_BY =  TMCS_SEC_CTX.GET_USER
                                    , LAST_UPDATE_DATE = sysdate
                                    where TARGET_ID = r1.ENTITY_ID;

                                        TMCS_CREATE_TARGET_TA(r1.ENTITY_ID
                                                                       ,r1.BRAND_ID
                                                                       ,NULL
                                                                       ,r1.CREATED_BY
                                                                       ,l_MESSAGE);

                                When 'STORE' then
                                    Update TMCS_ALL_STORES
                                    set LONGITUDE = r1.NEW_LONGITUDE
                                    ,LATITUDE = r1.NEW_LATITUDE
                                    , LAST_UPDATED_BY =  TMCS_SEC_CTX.GET_USER
                                    , LAST_UPDATE_DATE = sysdate
                                    where STORE_ID = r1.ENTITY_ID;

                                    l_MESSAGE := 1;

                                When 'COMPETITOR' then
                                    Update TMCS_ALL_COMPETITORS
                                    set LONGITUDE = r1.NEW_LONGITUDE
                                    ,LATITUDE = r1.NEW_LATITUDE
                                    , LAST_UPDATED_BY =  TMCS_SEC_CTX.GET_USER
                                    , LAST_UPDATE_DATE = sysdate
                                    where COMPETITOR_ID = r1.ENTITY_ID;

                                    l_MESSAGE := 1;

                                When 'SC' then
                                    l_MESSAGE := 1;
                    --                Update TMCS_SHOPPING_CENTERS
                    --                set LONGITUDE = r1.NEW_LONGITUDE
                    --                ,LATITUDE = r1.NEW_LATITUDE
                    --                , LAST_UPDATED_BY =  TMCS_SEC_CTX.GET_USER
                    --                , LAST_UPDATE_DATE = sysdate
                    --                where SITE_ID = r1.ENTITY_ID;
                            End Case;

                 Exception
                     When others then
                    DBMS_OUTPUT.PUT_LINE(sqlerrm);
                    l_MESSAGE := 78;
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(' Approved Move Entity'
                                                                            , 'TMC_Approved_Move_Entity_EJOB'
                                                                            , l_MESSAGE
                                                                            , 'Error while moving  ' || r1.ENTITY_TYPE || ' : ' ||   r1.ENTITY_ID || ' (MOVE_ID = ' || r1.MOVE_ID || ')'
                                                                            , SQLERRM
                                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                            , TMCS_SEC_CTX.GET_USER
                                                                            );

                 End;

                If l_MESSAGE in ( 1, 60)  then

                        update TMCS_MOVE_ENTITY
                        set APPROVED_BY =  TMCS_SEC_CTX.GET_USER
                        , APPROVAL_DATE =  sysdate
                        , LAST_UPDATED_BY =  TMCS_SEC_CTX.GET_USER
                        , LAST_UPDATE_DATE = sysdate
                        , STATUS = 'Fixed'
                        where MOVE_ID = r1.MOVE_ID;

                        Commit;


                Else
                        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(r1.ENTITY_TYPE
                                                                , 'TMC_Approved_Move_Entity_EJOB'
                                                                , l_MESSAGE
                                                                ,  'Error while moving  ' || r1.ENTITY_TYPE || ' : ' ||   r1.ENTITY_ID || ' (MOVE_ID = ' || r1.MOVE_ID || ')'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );

                        update TMCS_MOVE_ENTITY
                        set APPROVED_BY =  TMCS_SEC_CTX.GET_USER
                        , APPROVAL_DATE =  sysdate
                        , LAST_UPDATED_BY =  TMCS_SEC_CTX.GET_USER
                        , LAST_UPDATE_DATE = sysdate
                        , STATUS = 'Failed'
                        where MOVE_ID = r1.MOVE_ID;

                        Commit;
                 End if;

        End  loop;

        l_MESSAGE := TMC_Move_Entity_Email( p_batchID, 'FIXED' );
        l_MESSAGE := TMC_Move_Entity_Email( p_batchID, 'FAILED' );

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    l_MESSAGE := 99;
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG(' Approved Move Entity'
                                                            , 'TMC_Approved_Move_Entity_EJOB'
                                                            , l_MESSAGE
                                                            ,  'General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
End;
PROCEDURE TMCS_TRUNCATE_TRADEAREAS(p_message OUT VARCHAR2
                                     ,p_geom  IN MDSYS.SDO_GEOMETRY
                                     ,p_json IN VARCHAR2
                                     ) As
l_package VARCHAR2(32000);
plsql_block VARCHAR2(500);
l_TMCbrand  VARCHAR2(10);
l_Client_ID VARCHAR2(32);
l_geom MDSYS.SDO_GEOMETRY;
l_description  VARCHAR2(32000);
l_param0  VARCHAR2(32000) := NULL ;
l_param1 VARCHAR2(32000) := NULL ;
l_param2 VARCHAR2(32000) := NULL ;
l_param3 VARCHAR2(32000) := NULL ;
l_param4 VARCHAR2(32000) := NULL ;
l_param5 VARCHAR2(32000) := NULL ;
l_param6 VARCHAR2(32000) := NULL ;
l_param7 VARCHAR2(32000) := NULL ;
l_param8 VARCHAR2(32000) := NULL ;
l_param9 VARCHAR2(32000) := NULL ;
l_param10 VARCHAR2(32000):= NULL ;
l_param11 VARCHAR2(32000):= NULL ;
l_param12 VARCHAR2(32000):= NULL ;
l_param13 VARCHAR2(32000):= NULL ;
l_param14 VARCHAR2(32000):= NULL ;
l_param15 VARCHAR2(32000):= NULL ;
l_primaryEntityNumber VARCHAR2(320);
l_truncateEntityNumber VARCHAR2(320);
l_default VARCHAR2(320) := NULL;
Begin
    -- INcoming JSON format
    /*
    {
    entitytype: TRUNCATE_ENTITY_TA,
    p_site_id: 160056,
    p_trade_area_type: TRUNCATE,
    p_description: ,
    p_user: ytest@ta.com,
    p_brand: 35,
    p_entityType : SITE, -- SITE/STORE/TARGET
    p_truncateAgainst : STORE, -- STORE/SITE
    p_truncateEntity_Sites : 1234, -- Always the  SITE_ID
    p_truncateEntity_Targets : 1234, -- Always the  TARGET_ID
    p_truncateEntity_Stores : 1234, -- Always the  STORE_ID
    p_truncateEntity_Territories : 1234, -- Always the  TID
    p_truncateEntity_Minimarkets : 1234, -- Always the  TID
    p_isPrimary : Yes -- Yes/No
    }
    */
    dbms_output.put_line('l_text  --> ' || plsql_block);
            l_param0 := json_ext.get_string(JSON(p_json),'p_entityType');


    dbms_output.put_line('l_param0  --> ' || l_param0);

             if Upper(l_param0) = 'SITE' then

                      BEGIN

                                Select TMC_PACKAGE
                                into l_package
                                from TMCS_GIS_CLIENT_SETUP
                                where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID()
                                and UPPER(TMC_Functionality) = 'TRUNCATE_SITE_TA';

                                plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';
                                dbms_output.put_line('l_text  --> ' || plsql_block);
                                IF l_package is not null then

                                     l_default := 'FALSE';
                                     EXECUTE IMMEDIATE plsql_block using OUT p_message, p_geom,p_json;

                               Else
                                     p_message := 14;
                                     l_default := 'TRUE';
                                End if;

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 42; --Error while updating Standard Attributes

                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TRUNCATE_SITE_TA'
                                                                , 'TMCS_TRUNCATE_TRADEAREAS'
                                                                , p_message
                                                                ,  'Configuration Not set for this client'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
                      END;

             Elsif Upper(l_param0) = 'TARGET' then

                      BEGIN

                                Select TMC_PACKAGE
                                into l_package
                                from TMCS_GIS_CLIENT_SETUP
                                where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID()
                                and UPPER(TMC_Functionality) = 'TRUNCATE_TARGET_TA';

                                plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';
                                dbms_output.put_line('l_text  --> ' || plsql_block);
                                IF l_package is not null then

                                     l_default := 'FALSE';
                                     EXECUTE IMMEDIATE plsql_block using OUT p_message, p_geom,p_json;

                               Else
                                     p_message := 14;
                                     l_default := 'TRUE';
                                End if;

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 42; --Error while updating Standard Attributes

                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TRUNCATE_TARGET_TA'
                                                                , 'TMCS_TRUNCATE_TRADEAREAS'
                                                                , p_message
                                                                ,  'Configuration Not set for this client'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
                      END;
             Elsif Upper(l_param0) = 'STORE' then

                      BEGIN

                                Select TMC_PACKAGE
                                into l_package
                                from TMCS_GIS_CLIENT_SETUP
                                where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID()
                                and UPPER(TMC_Functionality) = 'TRUNCATE_STORE_TA';

                                plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';
                                dbms_output.put_line('l_text  --> ' || plsql_block);
                                IF l_package is not null then

                                     l_default := 'FALSE';
                                     EXECUTE IMMEDIATE plsql_block using OUT p_message, p_geom,p_json;

                               Else
                                     p_message := 14;
                                     l_default := 'TRUE';
                                End if;

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 42; --Error while updating Standard Attributes

                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TRUNCATE_STORE_TA'
                                                                , 'TMCS_TRUNCATE_TRADEAREAS'
                                                                , p_message
                                                                ,  'Configuration Not set for this client'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
                      END;
             Elsif Upper(l_param0) = 'TERRITORY' then

                      BEGIN

                                Select TMC_PACKAGE
                                into l_package
                                from TMCS_GIS_CLIENT_SETUP
                                where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID()
                                and UPPER(TMC_Functionality) = 'TRUNCATE_TERRITORY';

                                plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';
                                dbms_output.put_line('l_text  --> ' || plsql_block);
                                IF l_package is not null then

                                     l_default := 'FALSE';
                                     EXECUTE IMMEDIATE plsql_block using OUT p_message, p_geom,p_json;

                               Else
                                     p_message := 14;
                                     l_default := 'TRUE';
                                End if;

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 42; --Error while updating Standard Attributes

                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TRUNCATE_TERRITORY'
                                                                , 'TMCS_TRUNCATE_TRADEAREAS'
                                                                , p_message
                                                                ,  'Configuration Not set for this client'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
                      END;
             Elsif Upper(l_param0) = 'MINIMARKET' then

                      BEGIN

                                Select TMC_PACKAGE
                                into l_package
                                from TMCS_GIS_CLIENT_SETUP
                                where UPPER(TMC_Brand) = TMCS_SEC_CTX.GET_CLIENT_ID()
                                and UPPER(TMC_Functionality) = 'TRUNCATE_MINIMARKET';

                                plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';
                                dbms_output.put_line('l_text  --> ' || plsql_block);
                                IF l_package is not null then

                                     l_default := 'FALSE';
                                     EXECUTE IMMEDIATE plsql_block using OUT p_message, p_geom,p_json;

                               Else
                                     p_message := 14;
                                     l_default := 'TRUE';
                                End if;

                      EXCEPTION
                            when others then null;
                            dbms_output.put_line('SQL ERROR ' || sqlerrm);
                            p_message := 42; --Error while updating Standard Attributes

                            TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('TRUNCATE_MINIMARKET'
                                                                , 'TMCS_TRUNCATE_TRADEAREAS'
                                                                , p_message
                                                                ,  'Configuration Not set for this client'
                                                                , SQLERRM
                                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                                , TMCS_SEC_CTX.GET_USER
                                                                );
                      END;

             End if;

   /*
    The below process is the default process for truncating. If the client uses TA Default truncation rules then default should be used.
   */
    if UPPER(l_default) = 'TRUE' then

                l_param1 :=  json_ext.get_string(JSON(p_json),'entitytype');                    --entitytype;
                l_param2 := json_ext.get_string(JSON(p_json),'p_site_id');                      --p_site_id;
                l_param3 := json_ext.get_string(JSON(p_json),'p_trade_area_type');        --p_trade_area_type;
                l_param4 := json_ext.get_string(JSON(p_json),'p_description');                --p_description;
                l_param5 := json_ext.get_string(JSON(p_json),'p_user');                         --p_user;
                l_param6 := json_ext.get_string(JSON(p_json),'p_brand');                       --p_brand;
                l_param7 := json_ext.get_string(JSON(p_json),'p_entityType');                 --p_entityType;
                l_param8 := json_ext.get_string(JSON(p_json),'p_truncateAgainst');          --p_truncateAgainst;


                Case Upper(l_param8)
                    When 'SITE' then
                        l_param9 := json_ext.get_string(JSON(p_json),'p_truncateEntity_Sites');            --p_truncateEntity;
                    When 'TARGET' then
                        l_param9 := json_ext.get_string(JSON(p_json),'p_truncateEntity_Targets');            --p_truncateEntity;
                    When 'STORE' then
                        l_param9 := json_ext.get_string(JSON(p_json),'p_truncateEntity_Stores');            --p_truncateEntity;
                    When 'TERRITORY' then
                        l_param9 := json_ext.get_string(JSON(p_json),'p_truncateEntity_Territories');            --p_truncateEntity;
                    When 'MINIMARKET' then
                        l_param9 := json_ext.get_string(JSON(p_json),'p_truncateEntity_Minimarkets');            --p_truncateEntity;
                End Case;

                l_param10 := json_ext.get_string(JSON(p_json),'p_isPrimary');                --p_isPrimary;

                -- Getting Truncate Entity Number
                 If UPPER(l_param8)  = 'SITE' then
                            Select Site_NUMBER
                            into l_truncateEntityNumber
                            from TMCS_SITES_B
                            where SITE_ID =  l_param9;
                 ElsIf UPPER(l_param8)  = 'Store' then
                            Select STORE_NUMBER
                            into l_truncateEntityNumber
                            from TMCS_ALL_STORES
                            where STORE_ID =  l_param9;
                 ElsIf UPPER(l_param8)  = 'TARGET' then
                            Select TARGET_NUMBER
                            into l_truncateEntityNumber
                            from TMCS_TARGETS_B
                            where TARGET_ID =  l_param9;
                 ElsIf UPPER(l_param8)  = 'TERRITORY' then
                            l_truncateEntityNumber := l_param9;
                 ElsIf UPPER(l_param8)  = 'MINIMARKET' then
                            l_truncateEntityNumber := l_param9;
                 End if;

                -- Getting Primary Entity Number  and Entity TA
--                Case UPPER(l_param7)
--                When 'SITE' THEN
--                    Select Geometry
--                    into l_geom
--                    from TMCS_TRADEAREAS_SITES
--                    where SITE_ID =  l_param2
--                    and TA_TYPE = 'RETAIL'
--                    and PRIMARY_FLAG = 'Y';
--
--                     Select Site_NUMBER
--                    into l_primaryEntityNumber
--                    from TMCS_SITES_B
--                    where SITE_ID =  l_param2;
--
--                When 'STORE' THEN
--                     Select Geometry
--                    into l_geom
--                    from TMCS_ALL_STORES_TA
--                    where STORE_ID =  l_param2
--                    and TA_TYPE = 'RETAIL'
--                    and PRIMARY_FLAG = 'Y';
--
--                    Select STORE_NUMBER
--                    into l_primaryEntityNumber
--                    from TMCS_ALL_STORES
--                    where STORE_ID =  l_param2;
--                When 'TARGET' THEN
--                     Select Geometry
--                    into l_geom
--                    from TMCS_TRADEAREAS_TARGETS
--                    where TARGET_ID =  l_param2
--                    and TA_TYPE = 'RETAIL'
--                    and PRIMARY_FLAG = 'Y';
--
--                    Select TARGET_NUMBER
--                    into l_primaryEntityNumber
--                    from TMCS_TARGETS_B
--                    where TARGET_ID =  l_param2;
--                When 'TERRITORY' THEN
--                     Select ID,Geometry
--                    into l_param2,l_geom
--                    from TMCS_TERRITORIES
--                    where TID =  l_param2;
--
--                    l_primaryEntityNumber := l_param2;
--
--                When 'MINIMARKET' THEN
--
--                     Select ID,Geometry
--                    into l_param2,l_geom
--                    from TMCS_DUKB_MINIMARKET
--                    where MM_ID =  l_param2;
--
--                    l_primaryEntityNumber := l_param2;
--
--                End Case;


                -- Seting up the Description for the new TA.
                 if  UPPER(l_param10) = 'YES'  then
                         l_description := 'Truncated against '|| l_param7  || ' #  '|| l_primaryEntityNumber;
                 Else
                         l_description := 'Truncated against '|| l_param8  || ' #  '|| l_truncateEntityNumber;
                 End if;

                if l_param9 is null then
                    p_message := 56;
                Else
                    TMCS_TRUNCATE_TA( l_param2
                                ,l_param7
                                ,l_param8
                                ,l_param9
                                ,l_geom
                                ,'RETAIL'
                                ,l_param10
                                ,l_description
                                ,p_message );
                End if;

    End if;

Exception
    When others then
     p_message := 99;
--    p_status := SQLERRM;
    dbms_output.put_line('TRUNCATE_TERRITORY SQL ERROR ' || sqlerrm);
     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Truncate TAs'
                                              , 'TRUNCATE_TERRITORY'
                                              , '99'
                                              , 'General Error'
                                              , sqlerrm
                                              , TMCS_SEC_CTX.GET_CLIENT_ID
                                              , TMCS_SEC_CTX.GET_USER
                                              );
End;
Procedure TMCS_TRUNCATE_TA( p_entity_id VARCHAR2
                        ,p_entityTYPE VARCHAR2
                        ,p_truncateAgainst VARCHAR2
                        ,p_truncateEntity VARCHAR2
                        ,p_entity_TA MDSYS.SDO_GEOMETRY
                        ,p_entityTAType VARCHAR2
                        ,p_primaryTA VARCHAR2
                        ,p_description VARCHAR2
                        ,p_message OUT VARCHAR2) AS

l_geom MDSYS.SDO_GEOMETRY;
l_ID VARCHAR2(320);
l_message NUMBER;

Cursor c1 is
Select STORE_ID,geometry from TMCS_ALL_STORES_TA where rownum <1;

Type C1_TAB_TYPE is table of c1%ROWTYPE;
c1_list c1_TAB_TYPE;


Begin

--    tmcs_sec_ctx.set_context ('ytest@ta.com','GBR',27,35);
--
--    p_truncateAgainst := 'SITE';
--    p_truncateEntity := 160046;
--    p_entityTAType := 'RETAIL';
--    p_primaryTA := 'YES';
--
--    Select GEOMETRY
--    into p_entity_TA
--    from TMCS_TRADEAREAS_SITES
--    where SITE_ID =  p_truncateEntity
--    and TA_TYPE = 'RETAIL'
--    and PRIMARY_FLAG = 'Y';




--    IF UPPER(p_truncateAgainst)='SITE' then
--
--        Select SITE_ID,geometry
--        BULK COLLECT INTO c1_list
--        from TMCS_TRADEAREAS_SITES
--        where  SDO_RELATE(Geometry, p_entity_TA,'mask=anyinteract') = 'TRUE'
--        and SITE_ID = p_truncateEntity
--        and PRIMARY_FLAG = 'Y'
--        and UPPER(TA_TYPE) = UPPER(p_entityTAType);
--
--    Elsif  UPPER(p_truncateAgainst)='STORE' then
--
--        Select STORE_ID,geometry
--        BULK COLLECT INTO c1_list
--        from TMCS_ALL_STORES_TA
--        where  SDO_RELATE(Geometry, p_entity_TA,'mask=anyinteract') = 'TRUE'
--        and STORE_ID = p_truncateEntity
--        and PRIMARY_FLAG = 'Y'
--        and UPPER(TA_TYPE) = UPPER(p_entityTAType);
--
--    Elsif  UPPER(p_truncateAgainst)='TARGET' then
--
--        Select TARGET_ID,geometry
--        BULK COLLECT INTO c1_list
--        from TMCS_TRADEAREAS_TARGETS
--        where  SDO_RELATE(Geometry, p_entity_TA,'mask=anyinteract') = 'TRUE'
--        and TARGET_ID = p_truncateEntity
--        and PRIMARY_FLAG = 'Y' and CURRENT_STATUS = 'TRUE';
--
--    Elsif  UPPER(p_truncateAgainst)='TERRITORY' then
--
--        Select ID,geometry
--        BULK COLLECT INTO c1_list
--        from TMCS_TERRITORIES
--        where  SDO_RELATE(Geometry, p_entity_TA,'mask=anyinteract') = 'TRUE'
--        and TID = p_truncateEntity;
--
--    Elsif  UPPER(p_truncateAgainst)='MINIMARKET' then
--
--        Select ID,geometry
--        BULK COLLECT INTO c1_list
--        from TMCS_DUKB_MINIMARKET
--        where  SDO_RELATE(Geometry, p_entity_TA,'mask=anyinteract') = 'TRUE'
--        and MM_ID = p_truncateEntity;
--
--    End if;

    DBMS_OUTPUT.PUT_LINE('Truncating ' || p_entityTYPE ||  ' with '|| p_truncateAgainst || ' : '||l_ID || ' as Primary '|| p_primaryTA );

    Begin

        For j in 1..c1_list.count loop


            case UPPER(p_entityTYPE)

            when 'SITE' then

                if UPPER(p_truncateAgainst)='SITE'  Then

                    if UPPER(p_primaryTA) ='YES' then
                        l_ID := c1_list(j).STORE_ID;
                        l_geom := SDO_GEOM.SDO_DIFFERENCE(c1_list(j).geometry,p_entity_TA ,0.001);
                    Else
                        l_ID := p_entity_id;
                        l_geom := SDO_GEOM.SDO_DIFFERENCE(p_entity_TA,c1_list(j).geometry ,0.001);
                    End if;
                    DBMS_OUTPUT.PUT_LINE('Truncating ' || p_entityTYPE ||  ' with '|| p_truncateAgainst || ' : '||l_ID || ' as Primary '|| p_primaryTA );
                    TMCS_GIS_SLM_PKG_VN.TMC_MAINTAIN_TRADEAREAS
                                        (l_message
                                         ,l_ID
                                         ,TMCS_SEC_CTX.GET_USER
                                         ,''
                                         ,p_description
                                         ,TMCS_SEC_CTX.GET_BRAND_ID
                                         ,l_geom
                                         ,p_entityTAType
                                         ,'TRUE'
                                         ) ;
                Elsif UPPER(p_truncateAgainst)='STORE' then

                    if UPPER(p_primaryTA) ='YES' then
                        l_ID := c1_list(j).STORE_ID;
                        l_geom := SDO_GEOM.SDO_DIFFERENCE(c1_list(j).geometry,p_entity_TA ,0.001);

                        DBMS_OUTPUT.PUT_LINE('Truncating ' || p_entityTYPE ||  ' with '|| p_truncateAgainst || ' : '||l_ID || ' as Primary '|| p_primaryTA );
                        TMCS_GIS_SLM_PKG_VN.TMCS_MAINTAIN_STORE_TRADEAREAS
                                        (l_message
                                         ,l_ID
                                         ,TMCS_SEC_CTX.GET_USER
                                         ,''
                                         ,p_description
                                         ,TMCS_SEC_CTX.GET_BRAND_ID
                                         ,l_geom
                                         ,p_entityTAType
                                         ,'TRUE'
                                         );
                    Else
                        l_ID := p_entity_id;
                        l_geom := SDO_GEOM.SDO_DIFFERENCE(p_entity_TA,c1_list(j).geometry ,0.001);
                        DBMS_OUTPUT.PUT_LINE('Truncating ' || p_entityTYPE ||  ' with '|| p_truncateAgainst || ' : '||l_ID || ' as Primary '|| p_primaryTA );
                        TMCS_GIS_SLM_PKG_VN.TMC_MAINTAIN_TRADEAREAS
                                        (l_message
                                         ,l_ID
                                         ,TMCS_SEC_CTX.GET_USER
                                         ,''
                                         ,p_description
                                         ,TMCS_SEC_CTX.GET_BRAND_ID
                                         ,l_geom
                                         ,p_entityTAType
                                         ,'TRUE'
                                         ) ;
                    End if;
                End IF;

            When 'STORE' then

                if UPPER(p_truncateAgainst)='STORE' Then

                    if UPPER(p_primaryTA) ='YES' then
                        l_ID := c1_list(j).STORE_ID;
                        l_geom := SDO_GEOM.SDO_DIFFERENCE(c1_list(j).geometry,p_entity_TA ,0.001);
                    Else
                        l_ID := p_entity_id;
                        l_geom := SDO_GEOM.SDO_DIFFERENCE(p_entity_TA,c1_list(j).geometry ,0.001);
                    End if;
                    DBMS_OUTPUT.PUT_LINE('Truncating ' || p_entityTYPE ||  ' with '|| p_truncateAgainst || ' : '||l_ID || ' as Primary '|| p_primaryTA );
                    TMCS_GIS_SLM_PKG_VN.TMCS_MAINTAIN_STORE_TRADEAREAS
                                        (l_message
                                         ,l_ID
                                         ,TMCS_SEC_CTX.GET_USER
                                         ,''
                                         ,p_description
                                         ,TMCS_SEC_CTX.GET_BRAND_ID
                                         ,l_geom
                                         ,p_entityTAType
                                         ,'TRUE'
                                         );
                End if;

            When 'TARGET' THEN

                if UPPER(p_truncateAgainst)='TARGET' then

                    if UPPER(p_primaryTA) ='YES' then
                        l_ID := c1_list(j).STORE_ID;
                        l_geom := SDO_GEOM.SDO_DIFFERENCE(c1_list(j).geometry,p_entity_TA ,0.001);
                    Else
                        l_ID := p_entity_id;
                        l_geom := SDO_GEOM.SDO_DIFFERENCE(p_entity_TA,c1_list(j).geometry ,0.001);
                    End if;

                    DBMS_OUTPUT.PUT_LINE('Truncating ' || p_entityTYPE ||  ' with '|| p_truncateAgainst || ' : '||l_ID || ' as Primary '|| p_primaryTA );
                    TMCS_GIS_SLM_PKG_VN.TMC_MAINTAIN_TARGETS_TA
                                        (l_message
                                         ,l_ID
                                         ,TMCS_SEC_CTX.GET_BRAND_ID
                                         ,TMCS_SEC_CTX.GET_USER
                                         ,null
                                         ,p_description
                                         ,l_geom
                                         ,'RETAIL'
                                         ,'Y'
                                         );
                End if;

            When 'TERRITORY' THEN

                if UPPER(p_truncateAgainst)='TERRITORY' then

                    if UPPER(p_primaryTA) ='YES' then
                        l_ID := c1_list(j).STORE_ID;
                        l_geom := SDO_GEOM.SDO_DIFFERENCE(c1_list(j).geometry,p_entity_TA ,0.001);
                    Else
                        l_ID := p_entity_id;
                        l_geom := SDO_GEOM.SDO_DIFFERENCE(p_entity_TA,c1_list(j).geometry ,0.001);
                    End if;

                    DBMS_OUTPUT.PUT_LINE('Truncating ' || p_entityTYPE ||  ' with '|| p_truncateAgainst || ' : '||l_ID || ' as Primary '|| p_primaryTA );

                    TMCS_GIS_SLM_PKG_VN.TMCS_UPDATE_MARKETS
                                        (l_message
                                         ,l_ID
                                         ,TMCS_SEC_CTX.GET_USER
                                         ,null
                                         ,p_description
                                         ,TMCS_SEC_CTX.GET_BRAND_ID
                                         ,l_geom
                                         ,'TERRITORY'
                                         );

                End if;

            When 'MINIMARKET' THEN

                if UPPER(p_truncateAgainst)='MINIMARKET' then

                    if UPPER(p_primaryTA) ='YES' then
                        l_ID := c1_list(j).STORE_ID;
                        l_geom := SDO_GEOM.SDO_DIFFERENCE(c1_list(j).geometry,p_entity_TA ,0.001);
                    Else
                        l_ID := p_entity_id;
                        l_geom := SDO_GEOM.SDO_DIFFERENCE(p_entity_TA,c1_list(j).geometry ,0.001);
                    End if;

                    DBMS_OUTPUT.PUT_LINE('Truncating ' || p_entityTYPE ||  ' with '|| p_truncateAgainst || ' : '||l_ID || ' as Primary '|| p_primaryTA );
                    TMCS_GIS_SLM_PKG_VN.TMCS_UPDATE_MARKETS
                                        (l_message
                                         ,l_ID
                                         ,TMCS_SEC_CTX.GET_USER
                                         ,null
                                         ,p_description
                                         ,TMCS_SEC_CTX.GET_BRAND_ID
                                         ,l_geom
                                         ,'MINIMARKET'
                                         );
                End if;

            End Case;


        End Loop;

    Exception
        When others then
        DBMS_OUTPUT.PUT_LINE(sqlerrm);
    End;
    p_message := l_message;
Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
End;
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
                            ) As
l_storeID NUMBER;
Begin
        TMC_CREATE_STORES(p_message
                        ,p_Store_name
                        ,p_longitude
                        ,p_latitude
                        ,p_address
                        ,p_city
                        ,p_state
                        ,p_country
                        ,p_zip_code
                        ,p_brand
                        ,l_storeID
                        ) ;
    dbms_output.put_line('STORE is created with StoreID: ' || l_storeID);
    dbms_output.put_line('p_message output ' || p_message);
Exception
    When others then
      p_message := 99;
        rollback;
     dbms_output.put_line('SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('STORE'
                                            , 'TMC_MAINTAIN_STORES'
                                            , '99'
                                            ,  'General Error '
                                            , SQLERRM
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER
                                            );
End;
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
                        ) AS
l_store_id NUMBER;
l_Client_ID NUMBER;
  plsql_block  VARCHAR2(500);
   l_package     VARCHAR2(500);
   l_source     VARCHAr2(320);
   l_CBSA   NUMBER;
   l_STORE NUMBER;
   l_regionID NUMBER;
   l_geometry MDSYS.SDO_GEOMETRY;
   l_error VARCHAR2(32000);
    l_distance NUMBER;
 l_tempRegionID NUMBER;
Begin

        l_geometry := SDO_GEOMETRY(2001, 8307,SDO_POINT_TYPE(p_longitude,p_latitude,NULL),NULL, NULL);

    Begin
        Select G_Client_ID
        into l_Client_ID
        from tmcs_glob_brand_access_tmp
        where G_Brand_ID = p_brand;
    Exception
        when no_data_found then
        p_message := 15;  -- USER Brand Security is not set
        l_error := sqlerrm;
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store '
                                                , 'TMC_CREATE_STORES'
                                                , '15'
                                                , 'Security Not Set Properly'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
      End;


    BEGIN

        Select TMC_PACKAGE
        into l_package
        from TMCS_GIS_CLIENT_SETUP
        where UPPER(TMC_Brand) =  l_Client_ID
        and UPPER(TMC_Functionality) = 'GET_CLASS';

        IF l_package is not null then
            plsql_block := 'BEGIN '||l_package||'(:a, :b, :c); END;';
            dbms_output.put_line(l_package||'l_text  --> ' || plsql_block);
            EXECUTE IMMEDIATE plsql_block using l_geometry,OUT l_CBSA,OUT l_STORE;
        End if;

    EXCEPTION
        when others then null;
        dbms_output.put_line('GET_CLASS SQL ERROR  --> '|| sqlerrm);
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store'
                                                , 'TMC_CREATE_STORES'
                                                , '6'
                                                ,  'GET_CLASS ' || ' Client Specific Procedure Not Found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );

    END;

    Begin
        Select REGION_ID
        into l_regionID
        from TMCS_REGIONS a
        where SDO_CONTAINS(a.geometry, l_geometry) = 'TRUE'
        and UPPER(COUNTRY) = UPPER(TMCS_SEC_CTX.GET_COUNTRY_CODE) ;
    Exception
        When others then

            Begin
                Select SDO_NN_DISTANCE(1), REGION_ID
                into l_distance,l_tempRegionID
                from TMCS_REGIONS
                where SDO_NN(geometry,l_geometry,'distance = 10 unit = mile',1) = 'TRUE'
                and UPPER(COUNTRY) = UPPER(TMCS_SEC_CTX.GET_COUNTRY_CODE);

                if l_distance <= 10 then
                    l_regionID := l_tempRegionID;
                Else
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                            , 'TMC_MAINTAIN_SITES'
                                                            , '7'
                                                            , 'Region not Found even within 10 miles'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
                End if;

            Exception
                When others then
                dbms_OUTPUT.Put_line('Get Region Error : -->  '||sqlerrm);
                l_error := sqlerrm;

                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Site'
                                                        , 'TMC_MAINTAIN_SITES'
                                                        , '7'
                                                        ,  'Region ID not Found'
                                                        , SQLERRM
                                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                                        , TMCS_SEC_CTX.GET_USER
                                                        );
            End;

    End;

     If p_message is  null then
            l_Store_id := TMCS_ALL_STORES_S.nextval;
            p_StoreID := l_Store_id;
            --dbms_output.put_line(l_Store_id);
              Begin


                   INSERT INTO TMCS_ALL_STORES (Store_id
                                          ,Store_name
                                          ,longitude
                                          ,latitude
                                          ,address
                                          ,city
                                          ,state
                                          ,country
                                          ,ZIP
                                          ,creation_date
                                          ,created_by
                                          ,last_update_date
                                          ,last_updated_by
                                          ,status
                                          ,BRAND_ID
                                          ,CLIENT_ID
                                          ,ORG_ID
                                          ,CBSA_CLASS
                                          ,STORE_CLASS
                                          ,geometry)
                                    VALUES (l_Store_id
                                          , p_Store_name
                                          , p_longitude
                                          , p_latitude
                                          , p_address
                                          , p_city
                                          , p_state
                                          , TMCS_SEC_CTX.GET_COUNTRY_CODE()
                                          , p_zip_code
                                          , sysdate
                                          , TMCS_SEC_CTX.GET_USER
                                          , sysdate
                                          , TMCS_SEC_CTX.GET_USER
                                          , TMCS_GET_DEFAULT_STATUS('OP','STORE')
                                          , p_brand
                                          , l_Client_ID
                                          , l_regionID
                                          , l_CBSA
                                          , l_STORE
                                          , l_geometry
                                          );
                dbms_output.put_line('Insert Sucessfull :'|| sqlerrm);
              EXCEPTION
                when others then null;
                p_message := 9; -- This mean there is a violation while creating the Store
                l_error := sqlerrm;
                dbms_output.put_line('Insert Error :'|| sqlerrm);
             TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store'
                                                    , 'TMC_CREATE_STORES'
                                                    , '9'
                                                    ,  'This mean there is a violation while creating the Store  '
                                                    , SQLERRM
                                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                                    , TMCS_SEC_CTX.GET_USER
                                                    );
              END;

            if p_message is null then

                BEGIN

                    TMCS_UPDATE_STD_ATTRIBUTES(p_message
                                               ,'Store'
                                               , l_Store_id
                                               , l_geometry);
                   dbms_output.put_line('Update Std Attributes ' || p_message);
                EXCEPTION
                    when others then null;
                    dbms_output.put_line('SQL ERROR ' || sqlerrm);
                    p_message := 14; --Error while updating Standard Attributes
                    l_error := sqlerrm;
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store'
                                                            , 'TMC_CREATE_STORES'
                                                            , '14'
                                                            ,  'STANDARD_ATTR_UPDATE ' || ' Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
                END;

                BEGIN
                    TMCS_SET_ENTITY_DEFAULTS(p_message
                                            ,'Store'
                                            ,l_Store_id);
                    dbms_output.put_line('Update Entity Defaults ' || p_message);
                EXCEPTION
                    when others then null;
                    dbms_output.put_line('SQL ERROR ' || sqlerrm);
                    p_message := 14; --Error while updating Standard Attributes
                    l_error := sqlerrm;
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store'
                                                            , 'TMC_CREATE_STORES'
                                                            , '14'
                                                            ,  'Set Entity Defaults ' || ' Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
                END;

                BEGIN
                    TMCS_UPDATE_CUST_ATTR(p_message
                                            ,'Store'
                                            ,l_Store_id
                                            ,p_CustomJson);
                    dbms_output.put_line('Update Custom Attributes ' || p_message);
                EXCEPTION
                    when others then null;
                    dbms_output.put_line('SQL ERROR ' || sqlerrm);
                    p_message := 13; --Error while updating Standard Attributes
                    l_error := sqlerrm;
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store'
                                                            , 'TMC_CREATE_STORES'
                                                            , '13'
                                                            ,  'CUSTOM_ATTR_UPDATE ' || ' Client Specific Procedure Not Found'
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
                END;

                If p_message is  null then
                        TMCS_CREATE_STORE_TA(l_Store_id
                                            ,p_brand
                                            ,TMCS_SEC_CTX.GET_USER
                                            ,null
                                            ,null
                                            ,null
                                            ,p_message);
                    dbms_output.put_line('Finished Running TAS ' || p_message);
                END IF;

                If p_message = 1 then
                    TMCS_UPDATE_ENCROACHMENT(p_message ,l_error ,'Store',l_Store_id);
                    dbms_output.put_line('Finished Running Encroachments ' || p_message);
                else
                    rollback;
                    dbms_output.put_line('rollback executed');
                end if;
            End if;
        End If;

     If p_message = 1 then
         COMMIT;
         l_package := null;
         plsql_block := null;
         /*Asynchronous call so doing it after commit*/
         BEGIN
            Select TMC_PACKAGE
            into l_package
            from TMCS_GIS_CLIENT_SETUP
            where UPPER(TMC_Brand) = l_Client_ID
            and UPPER(TMC_Functionality) = 'GET_STORE_NUMBER';
            plsql_block := 'BEGIN '||l_package||'(:a); END;';
         EXCEPTION
            when no_data_found then null;
            when too_many_rows then null;
         END;
         dbms_output.put_line('l_text  --> ' || plsql_block);

         if l_package is not null then
            EXECUTE IMMEDIATE plsql_block using l_Store_id;
         Else
            /*Added to update Store_number from Store_id by VKK*/
            Begin
               update tmcs_all_stores
               set    Store_number = l_Store_id
               where  Store_id = l_Store_id;
            End;
            commit;
            p_message := 1;
         End if;

     Else
         rollback;
         dbms_output.put_line('rollback executed');
     End if;
  dbms_output.put_line('p_message' || p_message);

 EXCEPTION
     WHEN OTHERS THEN
        p_message := 99;
        rollback;
     dbms_output.put_line('SQL ERROR ' || sqlerrm);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Store'
                                                            , 'TMC_CREATE_STORES'
                                                            , '99'
                                                            ,  'General Error '
                                                            , SQLERRM
                                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                                            , TMCS_SEC_CTX.GET_USER
                                                            );
END;
Procedure TMCS_CREATE_STORE_TA(p_STORE_id  IN NUMBER
                               ,p_brand IN VARCHAR2
                               ,p_user_name IN VARCHAR2
                               ,p_trade_area_type IN VARCHAR2
                               ,p_description IN VARCHAR2
                               ,p_ring_miles IN VARCHAR2
                               ,p_message OUT VARCHAR2) AS


plsql_block  VARCHAR2(320);
l_package VARCHAR2(320);
l_error VARCHAR2(320);
Begin


        BEGIN
                Select TMC_PACKAGE
                into l_package
                from TMCS_GIS_CLIENT_SETUP
                where UPPER(TMC_Brand) =  TMCS_SEC_CTX.GET_CLIENT_ID
                and UPPER(TMC_Functionality) = 'GET_STORE_TRADEAREA';

               plsql_block := 'BEGIN '||l_package||'(:a, :b, :c, :d, :e, :f, :g); END;';
               dbms_output.put_line('l_text  --> ' || plsql_block);

               IF l_package is not null then
                  EXECUTE IMMEDIATE plsql_block using p_STORE_id,p_brand, p_user_name, p_trade_area_type,p_description,p_ring_miles,OUT p_message;
               ELSE
                    p_message := 1;
                    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('STORE'
                                                , 'TMCS_CREATE_STORE_TA'
                                                , p_message
                                                ,  'Create STORE TA ' || ' Client Specific Procedure Not Set'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
               End if;
           dbms_output.put_line('p_message  ' || p_message);
        EXCEPTION
                when no_data_found then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                p_message := 1; --Error while updating Standard Attributes
                l_error := sqlerrm;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('STORE'
                                                , 'TMCS_CREATE_STORE_TA'
                                                , p_message
                                                , 'No Store TA configuration found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );

                when others then null;
                dbms_output.put_line('SQL ERROR ' || sqlerrm);
                p_message := 14; --Error while updating Standard Attributes
                l_error := sqlerrm;
                TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('STORE'
                                                , 'TMCS_CREATE_STORE_TA'
                                                , '14'
                                                ,  'Create STORE TA ' || ' Client Specific Procedure Not Found'
                                                , SQLERRM
                                                , TMCS_SEC_CTX.GET_CLIENT_ID
                                                , TMCS_SEC_CTX.GET_USER
                                                );
        END;

Exception
    When others then
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    p_message := 99; --Error while updating Standard Attributes
    l_error := sqlerrm;
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('STORE'
                            , 'TMCS_CREATE_STORE_TA'
                            , '99'
                            ,  'General Error'
                            , SQLERRM
                            , TMCS_SEC_CTX.GET_CLIENT_ID
                            , TMCS_SEC_CTX.GET_USER
                            );
End;
Procedure TMCS_CALL_OPTIMIZATION(P_SEND_REQUEST VARCHAR2,
                                 p_message out VARCHAR2) as

l_optimJobURL VARCHAR2(3200);
l_optimStatsURL VARCHAR2(3200);
l_jobStatus VARCHAR2(320);
obj json;
l_jobID  VARCHAR2(320);
l_processStatus  VARCHAR2(320);
l_RESPONSE VARCHAR2(32000);
l_header VARCHAR2(32000);
i NUMBER := 0;
l_statusChecks NUMBER;
l_start      NUMBER DEFAULT DBMS_UTILITY.get_time ;
Begin

    BEGIN
        SELECT DOMAIN
        INTO l_optimJobURL
        FROM TMCS_GIS_FUNCTIONALITY_SETUP
        WHERE CLIENT_ID       = 0
        AND TMC_FUNCTIONALITY = 'OPTIMIZATION';

        SELECT DOMAIN,NVL(WIZARD_NAME,60)
        INTO l_optimStatsURL,l_statusChecks
        FROM TMCS_GIS_FUNCTIONALITY_SETUP
        WHERE CLIENT_ID       = 0
        AND TMC_FUNCTIONALITY = 'OPTIM_STATUS';

    EXCEPTION
        WHEN no_data_found THEN
        NULL;
        p_message := 9; --User Brand Security Not Set
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Optimization'
                                        , 'TMCS_OPTIMIZATION'
                                        , '9'
                                        , 'Setup Not Complete'
                                        , sqlerrm
                                        , TMCS_SEC_CTX.GET_CLIENT_ID
                                        , TMCS_SEC_CTX.GET_USER );
    END;

    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Optimization'
                                            , 'TMCS_CALL_OPTIMIZATION'
                                            , 'Job Creation Service Request'
                                            , l_optimJobURL
                                            ,  round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...'   || P_SEND_REQUEST
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );
     DBMS_OUTPUT.PUT_LINE('P_SEND_REQUEST :'|| P_SEND_REQUEST);
    --1st call for creating Optimization Job
     TMCS_GIS_SLM_PKG_VN.TMCS_CALL_POST_REST_WEBSERVICE ( P_SEND_REQUEST, l_optimJobURL, l_RESPONSE,l_header );
    DBMS_OUTPUT.PUT_LINE('l_RESPONSE :'|| l_RESPONSE);
    DBMS_OUTPUT.PUT_LINE('l_header :'|| l_header);
    TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Optimization'
                                            , 'TMCS_CALL_OPTIMIZATION'
                                            , 'Job Creation Service Response'
                                            , l_optimJobURL
                                            ,  round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...'   || l_RESPONSE
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );

    -- Code when Database is 12.2 or higher
--    l_jobStatus := JSON_VALUE( l_RESPONSE,'$.ok') ;
--    DBMS_OUTPUT.PUT_LINE('l_jobStatus :'|| l_jobStatus);

--    Older version DB lower than 12.2
    obj := JSON(l_RESPONSE);
    l_jobStatus := json_ext.get_number(obj, 'ok');
    obj.print;

    if l_jobStatus = '1' then

        -- Code when Database is 12.2 or higher
--        l_jobID:= JSON_VALUE( l_RESPONSE,'$.jobid') ;
--        DBMS_OUTPUT.PUT_LINE('l_jobID :'|| l_jobID);

        --    Older version DB lower than 12.2
        l_jobID := json_ext.get_string(obj, 'jobid');

        DBMS_OUTPUT.PUT_LINE('l_jobID :'|| l_jobID);

        l_processStatus              := 'REST';

        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Optimization'
                                            , 'TMCS_CALL_OPTIMIZATION'
                                            , 'Job Status Service Initiation'
                                            , l_optimStatsURL||l_jobID
                                            ,  round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...'
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );

        WHILE UPPER(l_processStatus) not in ( 'DONE','FAILED','-3') LOOP
--            DBMS_LOCK.SLEEP(seconds => 5);

--            dbms_output.put_line ('Started Calling  Optim Check Status Service :  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );
            --2nd call for checking the job Status
            TMCS_GIS_SLM_PKG_VN.TMCS_call_GET_rest_webservice( l_jobID,l_optimStatsURL||l_jobID, l_RESPONSE );
--            dbms_output.put_line ('Finished Calling  Optim Check Status Service :  ' ||round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' );
            DBMS_OUTPUT.PUT_LINE('l_RESPONSE :'|| l_RESPONSE);

            -- Code when Database is 12.2 or higher
--            l_processStatus := JSON_VALUE( l_RESPONSE,'$.status') ;
--            DBMS_OUTPUT.PUT_LINE('l_processStatus :'|| l_processStatus);

--            Older version DB lower than 12.2
            obj := JSON(l_RESPONSE);
            l_processStatus := json_ext.get_string(obj, 'status');
            obj.print;


            DBMS_OUTPUT.PUT_LINE('Process Status :'||l_processStatus);

            i:= i+1;
            IF i >= l_statusChecks THEN
            l_processStatus := 'DONE';
            END IF;


        END LOOP;
        TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Optimization'
                                            , 'TMCS_CALL_OPTIMIZATION'
                                            , 'Job Status Service Completed'
                                            , l_optimStatsURL||l_jobID
                                            ,  round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' || i || ' iteration with 5 sec Interval'
                                            , TMCS_SEC_CTX.GET_CLIENT_ID
                                            , TMCS_SEC_CTX.GET_USER );
        p_message := 1;
    Else
         p_message := 23;
         TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Optimization'
                                    , 'TMCS_CALL_OPTIMIZATION'
                                    , 'Job Creation Service Failed '
                                    , l_optimJobURL
                                    ,  round((dbms_utility.get_time-l_start)/100, 2) || ' Seconds...' || SUBSTR(l_RESPONSE,1,2000)
                                    , TMCS_SEC_CTX.GET_CLIENT_ID
                                    , TMCS_SEC_CTX.GET_USER );
    End if;

Exception
    When others then
    p_message := 99;
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
     TMCS_GIS_SLM_PKG_VN.TMCS_INSERT_ERROR_LOG('Optimization'
                            , 'TMCS_CALL_OPTIMIZATION'
                            , 'Job Creation Service Failed '
                            , l_optimJobURL
                            , sqlerrm
                            , TMCS_SEC_CTX.GET_CLIENT_ID
                            , TMCS_SEC_CTX.GET_USER );
End;
End;
/

