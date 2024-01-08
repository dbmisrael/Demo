CREATE GLOBAL TEMPORARY TABLE RUPD$_TMCS_UPDATE_MILESTONES
   (	MILESTONE_ID NUMBER,
	DMLTYPE$$ VARCHAR2(1),
	SNAPID NUMBER(*,0),
	CHANGE_VECTOR$$ RAW(255)
   ) ON COMMIT PRESERVE ROWS ;
-- COMMENT --

   COMMENT ON TABLE RUPD$_TMCS_UPDATE_MILESTONES  IS 'temporary updatable snapshot log';
