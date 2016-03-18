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

var sql = 'insert into mpr_base('+
    ' Year, Month, Date, PlatformId, Gateway, Vertical, SoftwareName, ' +
    ' ParentAccountId, ParentName, FeePaymentType, PaymentTypeGroup, Currency, ' +
    ' TPV, TPV_Net, TPV_USD, TPV_Net_USD, TPV_Billing, Card_Volume_USD, Card_Volume_Net_USD, Txn_Count, ' +
    ' Property_Fee, Net_Settled_Fee_USD, Convenience_Fee_USD, Net_Settled_Fee_Net_USD, Convenience_Fee_Net_USD, Revenue_USD, Revenue_Net_USD, ' + 
    ' Credit_Card_USD, Debit_Card_USD, Amex_Processing_USD, Credit_Card_Net_USD, Debit_Card_Net_USD, Amex_Processing_Net_USD ' + 
    ' ) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33)';

extract(source_db, file, function(data){
	transform(data, function(data){
		load(data, destination_db, sql, function(){
      email(file, function(){
        console.log('Data inserted.');        
      });
		});
	});
});

