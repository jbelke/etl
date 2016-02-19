var 
  path = require('path'),
  extract = require('./../extract').extract,
  transform = require('./../transform').transform,
  load = require('./../load').load,
  source_db = require('./../lib/config/crostoli_db.js'),
  source_db_type = 'MSSQL',
  destination_db = require('./../lib/config/finance_db.js'),
  file = path.basename(__filename.replace(/.js$/,'')),
  emailjs = require('emailjs'), emailconfig = require('./../lib/config/email.js'), email = emailjs.server.connect(emailconfig)
  ; 

var sql = 'insert into transaction('+
    ' Date, PlatformId, Software, ParentAccountId, ParentName, ChildAccountId, ChildName, ' +
    ' Merchant_Id, TxnIdClassId, TransferLogIdClassId, Card_Number, Txn_Amount ' + 
    ' ) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';

extract(source_db_type, source_db, file, function(data){
	transform(data, function(data){
		load(data, destination_db, sql, function(){
  		console.log('Data inserted.');

      email.send({
        subject: file+' job ran.',
        text: file+' job ran.',
        from: 'John Skilbeck jskilbeck@yapstone.com',
        to: 'John Skilbeck jskilbeck@yapstone.com',
      });

		});
	});
});

