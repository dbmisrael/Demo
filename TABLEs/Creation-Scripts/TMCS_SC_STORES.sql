CREATE TABLE TMCS_SC_STORES
   (	SC_ID VARCHAR2(50),
	BB_WORKS VARCHAR2(50),
	T_AND_T VARCHAR2(50),
	FRAN_STORES VARCHAR2(50),
	HENRI_BENDEL VARCHAR2(50),
	WB_CANDLE VARCHAR2(50),
	VICT_SECRET VARCHAR2(50)
   ) ;
  CREATE UNIQUE INDEX TMCS_SC_STORES_PK ON TMCS_SC_STORES (SC_ID)
  ;
ALTER TABLE TMCS_SC_STORES ADD CONSTRAINT TMCS_SC_STORES_PK PRIMARY KEY (SC_ID)
  USING INDEX TMCS_SC_STORES_PK  ENABLE;
CREATE UNIQUE INDEX TMCS_SC_STORES_PK ON TMCS_SC_STORES (SC_ID)
  ;

