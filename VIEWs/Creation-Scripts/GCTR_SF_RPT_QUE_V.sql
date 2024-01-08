CREATE OR REPLACE FORCE EDITIONABLE VIEW GCTR_SF_RPT_QUE_V (QID, Q_SEQ_NO, ENTITY_ID, QUESTION, ANSWER, GROUP_ID) AS
  SELECT qid,
            q_seq_no,
            entity_id,
            question,
            DECODE (q_type,
                    'S', answer_label,
                    'M', answer_label,
                    'N', ANSWER_VALUE,
                    'E', ANSWER_VALUE,
                    'T', ANSWER_VALUE)
               answer,
            GROUP_ID
       FROM (  SELECT C.ENTITY_ANSWER_ID,
                      A.QID,
                      A.Q_SEQ_NO,
                      C.ENTITY_ID,
                      C.ENTITY_TYPE,
                      C.SELECTED,
                      A.QUESTION,
                      C.ANSWER_LABEL,
                      C.ANSWER_VALUE,
                      C.ANSWER_DESC,
                      A.Q_TYPE,
                      A.GROUP_ID,
                      C.ANSWER_ID,
                      a.used_in_model
                 FROM TMCS_SQ_ENTITY_QUESTIONS A, TMCS_SQ_ENTITY_ANSWERS C
                WHERE A.ENTITY_QID = C.ENTITY_QID    --AND A.used_in_model = 1
             ORDER BY A.Q_SEQ_NO)
      WHERE UPPER (entity_type) = 'SITE' AND UPPER (selected) = 'TRUE'
   ORDER BY Q_SEQ_NO ASC;

