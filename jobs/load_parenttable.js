var 
  path = require('path'),
  extract = require('./../extract').extract,
  transform = require('./../transform').transform,
  email = require('./../email').email,
  load = require('./../load').load,
  source_db = 'crostoli',  // crostoli or finance
  destination_db = require('./../lib/config/finance_db.js'),
  file = path.basename(__filename.replace(/.js$/,''))
  ;

var sql = 'insert into ParentTable('+
    ' PlatformId, ChildCompanyId, ChildAccountId, ChildName, ChildAggregateId, ' +
    ' ParentCompanyId, ParentAccountId, ParentName, ParentAggregateId, '+
    ' DateFirstSeen, DateLastSeen, SoftwareName, Vertical '+
    ' ) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13)';

extract(source_db, file, function(data){
	transform(data, function(data){
		load(data, destination_db, sql, function(){
      email(file, function(){
        console.log('Data inserted.');        
      });
		});
	});
});

