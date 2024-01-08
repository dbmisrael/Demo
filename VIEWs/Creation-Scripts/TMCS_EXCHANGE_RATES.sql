CREATE OR REPLACE FORCE EDITIONABLE VIEW TMCS_EXCHANGE_RATES (EXCHG_RATE_ID, SOURCE_CURRENCY_CODE, TO_CURRENCY_CODE, EXCHANGE_RATE, EXCHG_RATE_DATE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY, LAST_UPDATE_LOGIN, OBJECT_VERSION_NUMBER, CLIENT_ID, COUNTRY, BRAND_ID, ORG_ID, EFFECTIVE_DATE, END_DATE, EXCHANGE_RATE_AVG) AS
  select EXCHG_RATE_ID,SOURCE_CURRENCY_CODE,TO_CURRENCY_CODE,EXCHANGE_RATE,EXCHG_RATE_DATE,CREATION_DATE,CREATED_BY,LAST_UPDATE_DATE,LAST_UPDATED_BY,LAST_UPDATE_LOGIN,OBJECT_VERSION_NUMBER,CLIENT_ID,COUNTRY,BRAND_ID,ORG_ID,EFFECTIVE_DATE,END_DATE,EXCHANGE_RATE_AVG from tmcs.tmcs_exchange_rates_cust;
