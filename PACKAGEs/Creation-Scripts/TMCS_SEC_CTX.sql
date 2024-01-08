CREATE OR REPLACE EDITIONABLE PACKAGE TMCS_SEC_CTX IS
   PROCEDURE set_user (p_name IN VARCHAR2);
   PROCEDURE clear_user;
   FUNCTION  get_user RETURN VARCHAR2;
   PROCEDURE set_client_id (clientid NUMBER);
   FUNCTION  get_client_id RETURN NUMBER;
   --PROCEDURE set_context (p_user_name VARCHAR2, p_country varchar2 default null);
   PROCEDURE set_context (p_user_name VARCHAR2, p_country varchar2 default null, p_client_id varchar2 default null,p_brand_id	 NUMBER DEFAULT NULL, p_bu_id   NUMBER DEFAULT NULL);
   --PROCEDURE set_context1 (p_user_name VARCHAR2, p_country varchar2 default null, p_client_id varchar2 default null, p_brand_id	 NUMBER DEFAULT NULL, x_client_id OUT NUMBER);
   FUNCTION GET_CLIENT_CODE(P_USERNAME VARCHAR2) RETURN VARCHAR2;
   FUNCTION get_country_code RETURN varchar2;
   FUNCTION get_brand_id RETURN NUMBER;
   FUNCTION is_brand_security_enable RETURN VARCHAR2;
   FUNCTION get_bu_id RETURN number;
   g_country_code varchar2(50);
   FUNCTION get_by_from_org(p_org_id number) return number;
END;
/

