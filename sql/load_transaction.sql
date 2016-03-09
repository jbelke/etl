
declare @now date, @start date, @end date 

set @now = getdate()
set @start = dateadd(mm,(year(@now)- 1900) * 12 + month(@now) - 1 -1 , 0)
set @end   = dateadd(d,-1 , dateadd(mm,(year(@now)- 1900) * 12 + month(@now)- 1 , 0))  

-- For inital load
set @start = '2016-01-01'
set @end = '2016-02-29'
--set @end = '2016-01-10'


if object_id('tempdb..#Prod') is not null drop table #Prod
select * into #Prod from (
select
	1 PlatformId, cast(t.id as varchar)+':'+cast(t.classId as varchar) IdClassId, cast(t.TransferLogId as varchar)+':'+cast(t.TransferLogClassId as varchar) Draft_Locator , '4445'+cast(t.merchantId as varchar) Merchant_Id , t.uiAccountNumber Card_Number
from
	rpReportsTemp.rp.Transfer t
	join rpReportsTemp.rp.CreditCardTransfer cct on t.id = cct.id and t.classId = cct.classId 
	join rpReportsTemp.rp.Invoice i on t.invoiceId = i.id and t.invoiceClassId = i.classId
where
	t.posted between @start and dateadd(s,-1,dateadd(d,1,cast(@end as datetime)))
	and i.ccProcessor in (13,14) -- Vantiv Bucket, Vantiv DirectFunded
	and i.classId in (47,105) -- Payments , Refunds
group by
	cast(t.id as varchar)+':'+cast(t.classId as varchar) , cast(t.TransferLogId as varchar)+':'+cast(t.TransferLogClassId as varchar) , '4445'+cast(t.merchantId as varchar) , t.uiAccountNumber 
union all 
select
	2 PlatformId, cast(t.id as varchar)+':'+cast(t.classId as varchar) IdClassId, cast(t.TransferLogId as varchar)+':'+cast(t.TransferLogClassId as varchar) Draft_Locator , '4445'+cast(t.merchantId as varchar) Merchant_Id , t.uiAccountNumber Card_Number
from
	ipReportsTemp..Transfer t
	join ipReportsTemp..CreditCardTransfer cct on t.id = cct.id and t.classId = cct.classId 
	join ipReportsTemp..Invoice i on t.invoiceId = i.id and t.invoiceClassId = i.classId
where
	t.posted between @start and dateadd(s,-1,dateadd(d,1,cast(@end as datetime)))
	and i.ccProcessor in (13,14) -- Vantiv Bucket, Vantiv DirectFunded
	and i.classId in (47,105) -- Payments , Refunds
group by
	cast(t.id as varchar)+':'+cast(t.classId as varchar) , cast(t.TransferLogId as varchar)+':'+cast(t.TransferLogClassId as varchar) ,  '4445'+cast(t.merchantId as varchar), t.uiAccountNumber 
union all
select
	3 PlatformId, cast(t.id as varchar)+':'+cast(t.classId as varchar) IdClassId, cast(t.TransferLogId as varchar)+':'+cast(t.TransferLogClassId as varchar) Draft_Locator, '4445'+cast(t.merchantId as varchar) Merchant_Id ,t.uiAccountNumber Card_Number
from
	haReportsTemp..Transfer t
	join haReportsTemp..CreditCardTransfer cct on t.id = cct.id and t.classId = cct.classId 
	join haReportsTemp..Invoice i on t.invoiceId = i.id and t.invoiceClassId = i.classId
where
	t.posted between @start and dateadd(s,-1,dateadd(d,1,cast(@end as datetime)))
	and i.ccProcessor in (13,14) -- Vantiv Bucket, Vantiv DirectFunded
	and i.classId in (47,105) -- Payments , Refunds
group by
	cast(t.id as varchar)+':'+cast(t.classId as varchar) , cast(t.TransferLogId as varchar)+':'+cast(t.TransferLogClassId as varchar) , '4445'+cast(t.merchantId as varchar), t.uiAccountNumber 
) src

if object_id('tempdb..#Data') is not null drop table #Data
select * into #Data from (
select
	txn.PostDate_R Date, txn.PlatformId,  c.ChildAccountId , Prod.Merchant_Id,
	case when txn.TransactionCycleId in (1) then 'Gross' else 'Refund' end as Transaction_Type , i.CardType as Issuer_Type ,
	txn.IdClassId Txn_Ref, Prod.Draft_Locator ,Prod.Card_Number ,	
	txn.Amount
from
	YapstoneDM..[Transaction] txn
	inner join ETLStaging..FinanceParentTable c on txn.PlatformId = c.PlatformId and txn.Ref_CompanyId = c.ChildCompanyId
	inner join ETLStaging..FinanceIssuerType i on txn.PlatformId = i.PlatformId  and txn.IdClassId = i.IdClassId
	inner join #Prod Prod on txn.PlatformId = Prod.PlatformId and txn.IdClassId = Prod.IdClassId  
where
	txn.TransactionCycleId in (1,9)
	and txn.PlatformId in (1,2,3)
	and txn.PostDate_R between @start and @end
	and txn.ProcessorId not in (14,16)
	and txn.ProcessorId in (22)
group by
	txn.PostDate_R ,txn.PlatformId,  c.ChildAccountId , Prod.Merchant_Id,
	case when txn.TransactionCycleId in (1) then 'Gross' else 'Refund' end ,  i.CardType  ,
	txn.IdClassId , Prod.Draft_Locator , Prod.Card_Number, txn.Amount
) src

select * from #Data






