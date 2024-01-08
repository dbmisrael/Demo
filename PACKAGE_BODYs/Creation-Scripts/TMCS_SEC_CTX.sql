CREATE OR REPLACE EDITIONABLE PACKAGE BODY TMCS_SEC_CTX
IS
   w_name   VARCHAR2 (32767);

   PROCEDURE set_user (p_name IN VARCHAR2)
   AS
      l_user_name    VARCHAR2 (300);
	  l_client_id    VARCHAR2 (300);
	  l_country_cd   VARCHAR2 (300);
      l_session_id   VARCHAR2 (300);
      l_x_pos        NUMBER := INSTR (p_name, '!', 1, 1);
      l_brand_id     NUMBER;
      l_bu_id     NUMBER;
   BEGIN
      --insert into DEBUG_TABLE(log) select p_user_name from dual;
      --SELECT INSTR(p_user_name,'!', 1,1) into l_x_pos from dual;
      --dbms_output.put_line(L_X_POS);
      IF (l_x_pos > 2)
      THEN
         SELECT SUBSTR (p_name, 0, l_x_pos - 1) INTO l_session_id FROM DUAL;
      ELSE
         l_session_id := p_name;
      END IF;

      --dbms_output.put_line('l_session_id:'|| l_session_id);
      SELECT user_name,current_client_id,current_country_code, current_brand_id,current_bu_id
        INTO l_user_name,l_client_id,l_country_cd, l_brand_id,l_bu_id
        FROM tmcs_user_session_info
       WHERE user_session_info_id = l_session_id;

      --dbms_output.put_line('l_user_name:'|| l_user_name);
      w_name := LOWER (l_user_name);
      set_context (l_user_name,l_country_cd,l_client_id, l_brand_id,l_bu_id);
   END;

   PROCEDURE clear_user
   AS
   BEGIN
      --w_name := NULL;
      --set_context (w_name);
      DBMS_SESSION.CLEAR_CONTEXT('client_ctx', 'client_id');
      DBMS_SESSION.CLEAR_CONTEXT('country_ctx', 'country');
      DBMS_SESSION.CLEAR_CONTEXT('brand_ctx', 'brand_id');
      DBMS_SESSION.CLEAR_CONTEXT ('bu_ctx', 'bu_id');
   END;

   FUNCTION get_user
      RETURN VARCHAR2
   AS
   BEGIN
      RETURN w_name;
   END;

   PROCEDURE set_client_id (clientid NUMBER)
   IS
   BEGIN
      /* validate client ID */
      /* validate_client_id(clientid); /*
      /* set client_id attribute under namespace 'tmcs_ctx' */

      DBMS_SESSION.SET_CONTEXT ('client_ctx', 'client_id', clientid);
   END;

   /* function to set brand context */
   /*PROCEDURE set_context (p_user_name VARCHAR2, p_country varchar2 default null) IS
    l_brands varchar2(1000);
    l_client_id number;
    l_country varchar2(100);
   BEGIN
      delete from tmcs_glob_brand_access_tmp;

      insert into tmcs_glob_brand_access_tmp(g_client_id, g_client_name, g_brand_id, g_brand_name)
      select a.client_id, client_name, a.brand_id, brand_name
      from tmcs_user_brands a, tmcs_clients b, tmcs_client_brands c
      where a.user_name = p_user_name
      and   a.client_id = b.client_id
      and   a.brand_id = c.client_brand_id;

      Begin
       select distinct g_client_id
       into  l_client_id
       from tmcs_glob_brand_access_tmp a;
      Exception
       when others then null;
      End;

      DBMS_SESSION.SET_CONTEXT('client_ctx', 'client_id', l_client_id);

      If p_country is null Then
        Begin
          select default_country
          into   l_country
          from   tmcs_client_users
          where  user_name = p_user_name;
        Exception
          when others then null;
        End;
      Else
        l_country := p_country;
      End If;

      w_name := p_user_name;

      DBMS_SESSION.SET_CONTEXT('country_ctx', 'country', l_country);
   END;
   */

   PROCEDURE set_context (p_user_name    VARCHAR2,
                          p_country      VARCHAR2 DEFAULT NULL,
                          p_client_id    VARCHAR2 DEFAULT NULL,
                          p_brand_id	 NUMBER DEFAULT NULL,
                          p_bu_id        NUMBER DEFAULT NULL)
   IS
      l_user_name   VARCHAR2 (1000);
      l_brands      VARCHAR2 (1000);
      l_client_id   NUMBER;
      l_country     VARCHAR2 (100);
      l_brand_id	NUMBER;
      l_region_security VARCHAR2(10);
      l_brand_security_enabled VARCHAR2(10);
      l_apply_bu_policy VARCHAR2(10);
   BEGIN
      DELETE FROM tmcs_glob_brand_access_tmp;

      l_user_name := lower(p_user_name);

      DBMS_SESSION.CLEAR_CONTEXT('client_ctx', 'client_id');
      DBMS_SESSION.CLEAR_CONTEXT('country_ctx', 'country');
      DBMS_SESSION.CLEAR_CONTEXT('brand_ctx', 'brand_id');
      DBMS_SESSION.CLEAR_CONTEXT('bu_ctx', 'bu_id');

      IF P_BU_ID IS NOT NULL THEN
	     Begin
	        select apply_bu_policy
	        into   l_apply_bu_policy
	        from   tmcs_clients
	        where  client_id = p_client_id;
	     Exception
	       when others then null;
	     End;
      END IF;

      IF p_client_id IS NULL
      THEN
         BEGIN
            SELECT default_client
              INTO l_client_id
              FROM tmcs_users
             WHERE lower(user_name) = l_user_name;
         EXCEPTION
            WHEN OTHERS
            THEN
               NULL;
         END;
      ELSE
         l_client_id := p_client_id;
      END IF;

      BEGIN
        select is_brand_security_enable
        into   l_brand_security_enabled
        from   tmcs_clients
        where  client_id = l_client_id;
      EXCEPTION
            WHEN OTHERS THEN NULL;
      END;

      IF nvl(l_brand_security_enabled,'N') = 'Y' THEN
	      INSERT INTO tmcs_glob_brand_access_tmp (g_client_id,
	                                              g_client_name,
	                                              g_brand_id,
	                                              g_brand_name)
	         SELECT a.client_id,
	                client_name,
	                client_brand_id,
	                brand_name
	           FROM tmcs_clients a, tmcs_client_brands b
	          WHERE  a.client_id = b.client_id
	                AND a.client_id = l_client_id
	                AND b.client_brand_id = p_brand_id;

              l_brand_id := p_brand_id;

      ELSE
	      INSERT INTO tmcs_glob_brand_access_tmp (g_client_id,
	                                              g_client_name,
	                                              g_brand_id,
	                                              g_brand_name)
	         SELECT a.client_id,
	                client_name,
	                a.brand_id,
	                brand_name
	           FROM tmcs_user_brands a, tmcs_clients b, tmcs_client_brands c
	          WHERE     lower(a.user_name) = l_user_name
	                AND a.client_id = b.client_id
	                AND a.brand_id = c.client_brand_id
	                AND a.client_id = l_client_id;
      END IF;

      w_name := l_user_name;

      DBMS_SESSION.SET_CONTEXT ('client_ctx', 'client_id', l_client_id);

      DBMS_SESSION.SET_CONTEXT ('brand_ctx', 'brand_id', l_brand_id);

      IF nvl(l_apply_bu_policy,'N') = 'N' Then
	      IF p_country IS NULL THEN
	         BEGIN
	            SELECT default_country
	              INTO l_country
	              FROM tmcs_users
	             WHERE lower(user_name) = l_user_name;
	         EXCEPTION
	            WHEN OTHERS
	            THEN
	               NULL;
	         END;
	      ELSE
	         l_country := p_country;
	      END IF;

		  g_country_code := nvl(p_country,'USA');

          DBMS_SESSION.SET_CONTEXT ('country_ctx', 'country', NVL (l_country, 'USA'));
          DBMS_SESSION.SET_CONTEXT ('bu_ctx', 'bu_id', null);
      ELSE
          -------------------------------------
          --  Added by Naresh
          --  Need country code even if the bu policy is on
          -------------------------------------
          if (p_country is null)
          then
                l_country := null;
          else
             l_country := p_country;
             g_country_code := p_country;
          end if;

          --DBMS_SESSION.SET_CONTEXT ('country_ctx', 'country', l_country);
          -------------------------------------
          --  Added by Naresh
          -------------------------------------
          if p_country is not null then
	          DBMS_SESSION.SET_CONTEXT ('country_ctx', 'country', p_country);
  		  end if;
          DBMS_SESSION.SET_CONTEXT ('bu_ctx', 'bu_id', p_bu_id);
      END IF;

      DELETE FROM tmcs_glob_region_access_tmp;

      If nvl(l_apply_bu_policy,'N') = 'Y' Then
	      INSERT INTO tmcs_glob_region_access_tmp (g_user_name, g_region_id)
	        SELECT l_user_name,
	               a.region_id
	          FROM tmcs.tmcs_user_regions a, tmcs.tmcs_regions b, tmcs.tmcs_client_countries c
	         WHERE a.region_id = b.region_id
	         and   lower(a.user_name) = l_user_name
	         and   c.bu_id = p_bu_id
	         and   b.country = c.country_code
	         and   c.client_id = p_client_id
	         and   c.brand_id like nvl(p_brand_id,c.brand_id)
	         and   c.brand_id = b.brand_id
	         and   b.country like nvl(p_country,'%');
	  Else
	      INSERT INTO tmcs_glob_region_access_tmp (g_user_name, g_region_id)
	        SELECT l_user_name,
	               a.region_id
	          FROM tmcs.tmcs_user_regions a, tmcs.tmcs_regions b
	         WHERE a.region_id = b.region_id
	         and   lower(a.user_name) = l_user_name
             and   b.client_id = l_client_id
             and   b.country   = TMCS_SEC_CTX.get_country_code;
	  End If;
      --DBMS_SESSION.SET_CONTEXT ('region_ctx', 'region', NVL (l_country, 'USA'));
   END;
   /*
   PROCEDURE set_context1 (p_user_name    VARCHAR2,
                          p_country      VARCHAR2 DEFAULT NULL,
                          p_client_id    VARCHAR2 DEFAULT NULL,
                          p_brand_id	 NUMBER DEFAULT NULL,
                          x_client_id OUT NUMBER)
   IS
      l_brands      VARCHAR2 (1000);
      l_client_id   NUMBER;
      l_country     VARCHAR2 (100);
      l_region_security VARCHAR2(10);
   BEGIN
      DELETE FROM tmcs_glob_brand_access_tmp;

      IF p_client_id IS NULL
      THEN
         BEGIN
            SELECT default_client
              INTO l_client_id
              FROM tmcs_users
             WHERE user_name = p_user_name;
         EXCEPTION
            WHEN OTHERS
            THEN
               NULL;
         END;
      ELSE
         l_client_id := p_client_id;
      END IF;

      INSERT INTO tmcs_glob_brand_access_tmp (g_client_id,
                                              g_client_name,
                                              g_brand_id,
                                              g_brand_name)
         SELECT a.client_id,
                client_name,
                a.brand_id,
                brand_name
           FROM tmcs_user_brands a, tmcs_clients b, tmcs_client_brands c
          WHERE     a.user_name = p_user_name
                AND a.client_id = b.client_id
                AND a.brand_id = c.client_brand_id
                AND a.client_id = l_client_id;

      w_name := p_user_name;

      DBMS_SESSION.SET_CONTEXT ('client_ctx', 'client_id', l_client_id);

      IF p_country IS NULL
      THEN
         BEGIN
            SELECT default_country
              INTO l_country
              FROM tmcs_users
             WHERE user_name = p_user_name;
         EXCEPTION
            WHEN OTHERS
            THEN
               NULL;
         END;
      ELSE
         l_country := p_country;
      END IF;

      DBMS_SESSION.SET_CONTEXT ('country_ctx', 'country', NVL (l_country, 'USA'));

      DELETE FROM tmcs_glob_region_access_tmp;

      INSERT INTO tmcs_glob_region_access_tmp (g_user_name, g_region_id)
        SELECT p_user_name,
               a.region_id
          FROM tmcs_user_regions a, tmcs_regions b
         WHERE a.region_id = b.region_id
         and   a.user_name = p_user_name;

      x_client_id := l_client_id;
      --DBMS_SESSION.SET_CONTEXT ('region_ctx', 'region', NVL (l_country, 'USA'));
   END;
   */
   FUNCTION get_client_id
      RETURN NUMBER
   IS
      l_client_id   NUMBER;
   BEGIN
      BEGIN
         SELECT DISTINCT g_client_id
           INTO l_client_id
           FROM tmcs_glob_brand_access_tmp;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;

      RETURN (l_client_id);
   END;

   FUNCTION get_client_code (p_username VARCHAR2)
      RETURN VARCHAR2
   IS
      l_client_code   VARCHAR2 (20);
   BEGIN
      BEGIN
         SELECT tmc.client_code
           INTO l_client_code
           FROM TMCS_CLIENTS TMC, tmcs_client_users TMCU
          WHERE     TMC.CLIENT_ID = TMCU.CLIENT_ID
                AND UPPER (TMCU.USER_NAME) = UPPER (p_username);
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END;

      RETURN (l_client_code);
   END;

   FUNCTION get_country_code
      RETURN VARCHAR2
   IS
      l_country_code   VARCHAR2 (20);
   BEGIN
      RETURN (g_country_code);
   END;

   FUNCTION get_brand_id RETURN NUMBER
   IS
    l_default_brand_id number;
   BEGIN
     Begin
       select default_brand_id
       into   l_default_brand_id
       from   tmcs_clients
       where  client_id = sys_context('CLIENT_CTX', 'CLIENT_ID');
     Exception
       when others then null;
     End;
     If sys_context('BRAND_CTX', 'BRAND_ID') is null Then
      RETURN l_default_brand_id;
     Else
      RETURN (sys_context('BRAND_CTX', 'BRAND_ID'));
     END If;
   END;

   FUNCTION is_brand_security_enable RETURN VARCHAR2 IS
     l_brand_security_enabled varchar2(100);
   BEGIN
      BEGIN
        select is_brand_security_enable
        into   l_brand_security_enabled
        from   tmcs_clients
        where  client_id = get_client_id;
      EXCEPTION
            WHEN OTHERS THEN NULL;
      END;

      If l_brand_security_enabled = 'Y' Then
         return('Y');
      Else
         return('N');
      End If;
   END;

   FUNCTION get_bu_id
      RETURN number
   IS
      l_country_code   VARCHAR2 (20);
   BEGIN
      RETURN (sys_context('BU_CTX', 'BU_ID'));
   END;

   FUNCTION get_by_from_org(p_org_id number) return number is
     l_bu_id number;
   BEGIN
   	BEGIN
	  select bu_id
	  into  l_bu_id
	  from  tmcs_client_countries a, tmcs.tmcs_regions b
	  where a.client_id = tmcs_sec_ctx.get_client_id
	  and   b.brand_id = a.brand_id
      and   b.country = a.country_code
      and   b.region_id = p_org_id;
    Exception
      when others then null;
   	END;
   	return l_bu_id;
   END;

END TMCS_SEC_CTX;
/

