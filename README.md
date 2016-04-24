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
		````var sql = 'insert into transaction(All,My,Fields,Here) values ($1,$2,$3,$4)';
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


