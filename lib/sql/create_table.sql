
create table transaction(
	Date date,
	Merchant_Id varchar(95),
	PlatformId int,
	ChildAccountId varchar(45),
	Transaction_Type varchar(45),
	Issuer_Type varchar(45),	
	TxnIdClassId varchar(45),
	TransferLogIdClassId varchar(45),
	Card_Number varchar(45),
	Txn_Amount decimal(48,2)
);


create table company (
	PlatformId integer,
	AccountId varchar(45),
	Name varchar(45)
);