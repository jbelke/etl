var 
  path = require('path'),
  extract = require('./extract').extract,
  transform = require('./transform').transform,
  load = require('./load').load,
  file = path.basename(__filename.replace(/.js$/,''))
  ; 

var sql = 'insert into transaction('+
    ' Date, PlatformId, Software, ParentAccountId, ParentName, ChildAccountId, ChildName, ' +
    ' Merchant_Id, TxnIdClassId, TransferLogIdClassId, Card_Number, Txn_Amount ' + 
    ' ) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';

extract(file, function(data){
	transform(data, function(data){
		load(data, sql, function(results){
  		console.log(results);					
		});
	});
});

