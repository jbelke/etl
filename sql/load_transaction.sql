
declare @start as date = '2016-01-30', @end as date = '2016-01-30'

select 
	txn.PostDate_R Date,txn.PlatformId, c.SoftwareName,c.ParentAccountId,c.ParentName, c.ChildAccountId, c.ChildName ,
	'4445'+cast(rp.merchantId as varchar) Merchant_Id,
	txn.IdClassId TxnIdClassId, cast(rp.TransferLogId as varchar)+':'+cast(rp.TransferLogClassId as varchar) TransferLogIdClassId , 	
	rp.uiAccountNumber Card_Number , txn.Amount
from
	YapstoneDM..[Transaction] txn
	join ETLStaging..FinanceParentTable c on txn.PlatformId = c.PlatformId and txn.Ref_CompanyId = c.ChildCompanyId
    join YapstoneDM..PaymentType pt on txn.PaymentTypeId = pt.PaymentTypeId
    left join rpReportsTemp.rp.Transfer rp on rp.id = left(txn.IdClassId, charindex(':', txn.IdClassId) -1) and rp.classId = right(txn.IdClassId, (len(txn.idclassid) - charindex(':', txn.IdClassId)))
where
	txn.TransactionCycleId in (1,9)
	and txn.PlatformId in (1)
	and txn.PostDate_R between @start and @end
	and txn.ProcessorId not in (14,16)
	and txn.ProcessorId in (22)
group by
	txn.PostDate_R ,txn.PlatformId, c.SoftwareName,c.ParentAccountId,c.ParentName, c.ChildAccountId, c.ChildName ,
	'4445'+cast(rp.merchantId as varchar) ,
	txn.IdClassId , cast(rp.TransferLogId as varchar)+':'+cast(rp.TransferLogClassId as varchar)  , 	
	rp.uiAccountNumber  , txn.Amount




