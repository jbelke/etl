


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

create table parenttable (
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

create table company (
	PlatformId integer,
	AccountId varchar(45),
	Name varchar(45)
);