CREATE OR REPLACE EDITIONABLE PACKAGE TMCS_BK_SITE_INTF_PKG AS
   /*******************************************************************************
   * $Header$
   * Program Name : TMCS_BK_SITE_INTF_PKG
   * Language     : PL/SQL
   * Description  :
   *
   * History      :
   *
   * WHO            WHAT                                           WHEN
   * -------------- ---------------------------------------------- ---------------
   * Vinay Kapil     1.0                                           23-JUL-2012
   *******************************************************************************/
  FUNCTION Cmd (p_command IN VARCHAR2) RETURN NUMBER;
  --Inbound SITE Interface
  TYPE TMP_RECTYPE_IN IS RECORD
        (SITE_NO						VARCHAR2(50)
        ,BK_NUMBER						VARCHAR2(50)
		,A_NUMBER	       		    	VARCHAR2(500)
		,DEVELOPMENT_MANAGER	        VARCHAR2(500)
		,CONSTRUCTION_MANAGER			VARCHAR2(500)
		,REDCAT_STATUS             		VARCHAR2(500)
		,ESTIMATED_OPENING_DATE			VARCHAR2(500)
		);
  --Inbound SITE Interface
  PROCEDURE load_data_in(p_buffer  out varchar2);

  --Inbound SITE PAF Interface
  TYPE TMP_RECTYPE_PAF IS RECORD
        (SITE_NO						VARCHAR2(50)
        ,ENCR_TYPE						VARCHAR2(50)
        ,ENCR_NO						VARCHAR2(50)
        ,NOTIFICATION_SENT 				VARCHAR2(50)
		,DEADLINE_DATE	       			VARCHAR2(50)
		,OBJECTION_STATUS		        VARCHAR2(500)
		,ADR_RECEIVE_DATE				VARCHAR2(50)
		);
  --Inbound SITE PAF Interface
  PROCEDURE load_data_paf(p_buffer  out varchar2);

  PROCEDURE SITE_OUTBOUND_FILE(P_ERR       OUT     NUMBER,
                                 P_ERR_TXT   OUT     VARCHAR2);
  PROCEDURE SITE_PAF_OUTBOUND_FILE(P_ERR       OUT     NUMBER,
                                 P_ERR_TXT   OUT     VARCHAR2);
End;


/

