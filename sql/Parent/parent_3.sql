

select 
	distinct
	PlatformId, ChildCompanyId, ChildAccountId, ChildName, ChildAggregateId, 
	ParentCompanyId, ParentAccountId, ParentName, ParentAggregateId, 
	DateFirstSeen, DateLastSeen, SoftwareName, Vertical
from 
	ETLStaging..FinanceParentTable c
where
	PlatformId in (3)