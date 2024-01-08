CREATE OR REPLACE FORCE EDITIONABLE VIEW GCTR_ANALOG_RPT_MAIN_V (SF_ID, SITE_ID, SITE_NUMBER, SITE_NAME, ADDRESS, CITY, STATE, ZIP_CODE, OPEN_DATE, SITE_TYPE, STUDIOS, GC_PRO, RENTAL, CENSUS_REGION, CENSUS_DIVISION, DMA_ID, DMA_NAME, CBSA_ID, CBSA_NAME, CBSA_CLASS, STORE_CLASS, TA_POP, TA_HH, ANNUAL_HH_GROWTH_RATE, TA_HH_DENSITY, PERSON_PER_HH, TA_MEDIAN_AGE, TA_MEDIAN_HH_INCOME, PCT_SEASONAL_POP, MILIRATY_GQ_POP, COLLEGE_GQ_POP, WORKPLACE_EMPLOYEES, CORE_SIC_BUSINESS, TA_SALES, TA_SALES_PER_EFFHH, TA_CAPTURE, BEYOND_SALES, TOTAL_SALES, SQ_FT, SALES_PER_SF, RETAIL_SALES, TOTAL_LIVE_DJ_SALES, TOTAL_STUDIO_SALES, TOTAL_GC_PRO_SALES, QUE1, QUE2, TA_EFF_HH_OVERALL, TA14, TA_QUALITY_OVERALL, TA_QUALITY_LIVE_DJ, TA17, TA18, TA19, TA20) AS
  SELECT snr.sf_id,
          site.site_id site_id,
          site.site_number site_number,
          site.site_name site_name,
          site.address address,
          site.city city,
          site.state,
          site.zip_code,
          TO_CHAR (site.PROPOSED_START_DATE, 'MM/DD/YYYY') open_date,
          tmcs_adf_pkg.get_lov_value (site.site_type, 'Site Type') site_type,
          tmcs_adf_pkg.get_lov_value (detail.C_EXT_LOV16, 'SITELOV16') studios,
          tmcs_adf_pkg.get_lov_value (detail.C_EXT_LOV17, 'SITELOV17') gc_pro,
          tmcs_adf_pkg.get_lov_value (detail.C_EXT_LOV18, 'SITELOV18') rental,
          site.census_region,
          site.census_division,
          site.dma_id,
          site.dma_name,
          site.cbsa_id,
          site.cbsa_name,
          site.cbsa_class,
          site.store_class,
          ta.n_ext_attr1 ta_pop,
          ta.n_ext_attr2 ta_hh,
          nvl(ta.n_ext_attr3,0)/100  annual_hh_growth_rate,
          ta.n_ext_attr4 ta_hh_density,
          ta.n_ext_attr5 person_per_hh,
          ta.n_ext_attr6 ta_median_age,
          ta.n_ext_attr7 ta_median_hh_income,
          decode(ta.n_ext_attr8,0,null, ta.n_ext_attr8/100) pct_seasonal_pop,
          ta.n_ext_attr9 miliraty_gq_pop,
          ta.n_ext_attr10 college_gq_pop,
          ta.n_ext_attr11 workplace_employees,
          ta.n_ext_attr12 core_sic_business,
       --   snr.n_ext_attr9 ta_eff_hh_overall,
          --snr.n_ext_attr10 ta_quality_overall,
         -- snr.n_ext_attr11 ta_quality_live_dj,
          snr.n_ext_attr5 ta_sales,
          snr.n_ext_attr7 ta_sales_per_effhh,
          decode(snr.n_ext_attr6,0,null,(snr.n_ext_attr6/100)) ta_capture,
          snr.n_ext_attr8 beyond_sales,
          snr.sales_forecast total_sales,
          --site.sq_ft sq_ft,
          site.N_EXT_ATTR19 sq_ft,
          snr.sales_forecast /nvl(site.N_EXT_ATTR19,1)  sales_per_sf,
          snr.n_ext_attr9 retail_sales,
          snr.n_ext_attr10 total_live_dj_sales,
          snr.n_ext_attr11 total_studio_sales,
          snr.n_ext_attr12 total_gc_pro_sales,
          que_answer1.answer que1,
         que_answer2.answer que2,
         ta.n_ext_attr13 ta_eff_hh_overall,
         ta.n_ext_attr14 ta14,
         ta.n_ext_attr15 ta_quality_overall,
         ta.n_ext_attr16 ta_quality_live_dj,
         ta.n_ext_attr17 ta17,
         ta.n_ext_attr18 ta18,
         ta.n_ext_attr19 ta19,
         ta.n_ext_attr20 ta20
     FROM tmcs_sites_b site, tmcs_site_sf_snr snr, tmcs_tradeareas_sites ta,tmcs_sites_b_detail detail,
    ( select entity_id,answer from gctr_sf_rpt_que_v where q_seq_no=1) que_answer1,
    ( select entity_id,answer from gctr_sf_rpt_que_v where q_seq_no=8) que_answer2
    WHERE     snr.SITE_ID = site.site_id(+)
           and site.site_id=detail.site_id(+)
          AND snr.trade_area_id = ta.tradearea_id(+)
          and site.site_id=que_answer1.entity_id(+)
          and site.site_id=que_answer2.entity_id(+);
