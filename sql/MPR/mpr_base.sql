
declare @now date, @start date, @end date 

set @now = getdate()
set @start = dateadd(mm,(year(@now)- 1900) * 12 + month(@now) - 1 -1 , 0)
set @end   = dateadd(d,-1 , dateadd(mm,(year(@now)- 1900) * 12 + month(@now)- 1 , 0))  


select 
	*
from 
	ETLStaging..FinanceBaseMPR MPR
where
	Date between @start and @end

