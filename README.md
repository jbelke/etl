# ETL

## What 
Nightly ETL (extract, transform, load) data from a `MS SQL` database to a `postgres` database. 

Database agnostic. Configurable support for `MS SQL` OR `postgres`.

## Why
The first ETL program in `node.js` !

## Install
- `git clone git@github.com:skilbjo/aqtl.git ; cd aqtl`
- `npm install`

## Workflow
- Write & parameterize the SQL query of the data to extract, ie:
		````declare @start as date
		set @date = getdate()
		select * from [Transaction] where date = @date````
- Save the file in the directory path `sql/Finance` as `myquery.sql`
- Create a `myquery.js` file in the corresponding `jobs/Finance` path,
		````
		var sql = 'insert into mpr_base('+
		    ' Year, Month, Date, PlatformId, Gateway, Vertical, SoftwareName, ' +
		    ' ParentAccountId, ParentName, FeePaymentType, PaymentTypeGroup, Currency, ' +
		    ' TPV, TPV_Net, TPV_USD, TPV_Net_USD, TPV_Billing, Card_Volume_USD, Card_Volume_Net_USD, Txn_Count, ' +
		    ' Property_Fee, Net_Settled_Fee_USD, Convenience_Fee_USD, Revenue_USD, Revenue_Net_USD, Net_Settled_Fee_Net_USD, Convenience_Fee_Net_USD, ' + 
		    ' Credit_Card_USD, Debit_Card_USD, Amex_Processing_USD, Credit_Card_Net_USD, Debit_Card_Net_USD, Amex_Processing_Net_USD ' + 
		    ' ) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33)';

		extract(source_db, file, subfolder, function(data){
			transform(data, function(data){
				load(data, destination_db, sql, function(){
		      email(file, function(){
		        console.log('Data inserted.');        
		      });
				});
			});
		});
		````
- Schedule the report via cron in `lib/crontab`: `0 12 * * 2-6 skilbjo cd $FINANCE ; node myquery.js >/dev/null`
- Enjoy!


## Misc
### Local Postgres DB
- Start `postgres` locally! `$ postgres -D /usr/local/var/postgres9.5/ &`


