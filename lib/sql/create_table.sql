


create table transaction(
	Date date,
	PlatformId int,
	ChildAccountId varchar(45),
	Merchant_Id varchar(95),
	Transaction_Type varchar(45),
	Issuer_Type varchar(45),	
	Txn_Ref varchar(45),
	Draft_Locator varchar(45),
	Card_Number varchar(45),
	Txn_Amount decimal(48,2)
);

create table Parent (
	PlatformId int,
	ChildCompanyId varchar(45),
	ChildAccountId varchar(45),
	ChildName varchar(95),
	ChildAggregateId varchar(95),
	ParentCompanyId varchar(45),
	ParentAccountId  varchar(45),
	ParentName varchar(95),
	ParentAggregateId varchar(95),
	DateFirstSeen date,
	DateLastSeen date,
	SoftwareName varchar(45),
	Vertical varchar(45)
);

create table analytics (
	Year int,
	Month int,
	Date date,
	PlatformId int,
	Gateway varchar(45),
	Vertical varchar(45),
	PaymentType varchar(45),
	Network varchar(45),
	PaymentTypeGroup varchar(45),
	Currency varchar(45),
	TPV decimal(48,2),
	TPV_USD decimal(48,2),
	Txn_Count int, 
	Card_Volume decimal(48,2),
	Card_Txn_Count int,
	Card_Volume_USD decimal(48,2)
);

create table topdata (
	Year int,
	Month int,
	Date date,
	PlatformId int,
	Gateway varchar(45),
	Vertical varchar(45),
	SoftwareName varchar(45),
	ParentAccountId  varchar(45),
	ParentName varchar(95),
	Currency varchar(45),
	TPV_USD decimal(48,2),
	Card_Volume_USD decimal(48,2),
	Txn_Count int,
	Revenue_USD decimal(48,2)
);

create table mmf (
	Date date,
	PlatformId int,
	Vertical varchar(45),
	ParentAccountId  varchar(45),
	ParentName varchar(95),
	MMF decimal(48,2)
);

create table mpr_base (
	Year int,
	Month int,
	Date date,
	PlatformId int,
	Gateway varchar(45),
	Vertical varchar(45),
	SoftwareName varchar(45),
	ParentAccountId varchar(45),
	ParentName varchar(95),
	FeePaymentType varchar(45),
	PaymentTypeGroup varchar(45),
	Currency varchar(45),
	TPV decimal(48,2),
	TPV_Net decimal(48,2),
	TPV_USD decimal(48,2),
	TPV_Net_USD decimal(48,2),		
	TPV_Billing decimal(48,2),
	Card_Volume_USD decimal(48,2),
	Card_Volume_Net_USD decimal(48,2),
	Txn_Count int,
	Property_Fee decimal(48,2),
	Net_Settled_Fee_USD decimal(48,2),
	Convenience_Fee_USD decimal(48,2),
	Revenue_USD decimal(48,2),
	Revenue_Net_USD decimal(48,2),
	Net_Settled_Fee_Net_USD decimal(48,2),
	Convenience_Fee_Net_USD decimal(48,2),	
	Credit_Card_USD decimal(48,2),
	Debit_Card_USD decimal(48,2),
	Amex_Processing_USD decimal(48,2),
	Credit_Card_Net_USD decimal(48,2),
	Debit_Card_Net_USD decimal(48,2),
	Amex_Processing_Net_USD decimal(48,2)
);

create table company (
	PlatformId integer,
	AccountId varchar(45),
	Name varchar(45)
);