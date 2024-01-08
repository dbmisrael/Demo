CREATE OR REPLACE FORCE EDITIONABLE VIEW STATESTATUS_V (NAME, STATE_CODE, STATUS_CODE, DISPLAY_SEQ) AS
  select a.name, a.state_code, b.status_code, b.display_seq
from TMCS_STATES a, tmcs.tmcs_entity_statuses b
where b.client_id = 19
and   b.entity_type = 'SITE'
order by a.name,b.display_seq;

