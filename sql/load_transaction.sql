
declare @now date, @start date, @end date 

set @now = getdate()
set @start = dateadd(mm,(year(@now)- 1900) * 12 + month(@now) - 1 -1 , 0)
set @end   = dateadd(d,-1 , dateadd(mm,(year(@now)- 1900) * 12 + month(@now)- 1 , 0))  

-- For inital load
set @start = '2016-01-01'
set @end = '2016-02-29'

select
	txn.PostDate_R Date, 	'4445'+cast(rp.merchantId as varchar) Merchant_Id, txn.PlatformId, c.ChildAccountId, 
	case when txn.TransactionCycleId in (1) then 'Gross' else 'Refund' end as Transaction_Type , i.CardType as Issuer_Type ,
	txn.IdClassId TxnIdClassId, cast(rp.TransferLogId as varchar)+':'+cast(rp.TransferLogClassId as varchar) TransferLogIdClassId , 	
	rp.uiAccountNumber Card_Number , txn.Amount
from
	YapstoneDM..[Transaction] txn
	inner join ETLStaging..FinanceParentTable c on txn.PlatformId = c.PlatformId and txn.Ref_CompanyId = c.ChildCompanyId
	inner join YapstoneDM..PaymentType pt on txn.PaymentTypeId = pt.PaymentTypeId
	inner join ETLStaging..FinanceIssuerType i on txn.PlatformId = i.PlatformId  and txn.IdClassId = i.IdClassId
  left join rpReportsTemp.rp.Transfer rp on rp.id = left(txn.IdClassId, charindex(':', txn.IdClassId) -1) and rp.classId = right(txn.IdClassId, (len(txn.idclassid) - charindex(':', txn.IdClassId)))
  left join ipReportsTemp..Transfer ip on ip.id = left(txn.IdClassId, charindex(':', txn.IdClassId) -1) and ip.classId = right(txn.IdClassId, (len(txn.idclassid) - charindex(':', txn.IdClassId)))
  left join haReportsTemp..Transfer ha on ha.id = left(txn.IdClassId, charindex(':', txn.IdClassId) -1) and ha.classId = right(txn.IdClassId, (len(txn.idclassid) - charindex(':', txn.IdClassId)))    
where
	txn.TransactionCycleId in (1,9)
	and txn.PlatformId in (1,2,3)
	and txn.PostDate_R between @start and @end
	and txn.ProcessorId not in (14,16)
	and txn.ProcessorId in (22)
group by
	txn.PostDate_R ,txn.PlatformId, c.SoftwareName,c.ParentAccountId,c.ParentName, c.ChildAccountId, c.ChildName ,
	'4445'+cast(rp.merchantId as varchar) ,
	case when txn.TransactionCycleId in (1) then 'Gross' else 'Refund' end ,  i.CardType as Issuer_Type ,
	txn.IdClassId , cast(rp.TransferLogId as varchar)+':'+cast(rp.TransferLogClassId as varchar)  , 	
	rp.uiAccountNumber  , txn.Amount




