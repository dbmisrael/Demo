CREATE OR REPLACE FORCE EDITIONABLE VIEW SITESSTATUS_V (STATE, STATUS, TOTAL_COUNT, FISCAL_YEAR, DMA_ID, DMA_NAME) AS
  select upper(s.state) state,s.status status,count(*) total_count, s.fiscal_year,s.dma_id,s.dma_name
from tmcs.TMCS_SITES_B s
where s.client_id = 19
--and s.dma_id = 911
group by upper(s.state),s.status ,s.fiscal_year,s.dma_id,s.dma_name
order by upper(s.state);

