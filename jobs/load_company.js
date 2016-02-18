var 
  path = require('path'),
  extract = require('./extract').extract,
  transform = require('./transform').transform,
  load = require('./load').load,
  file = path.basename(__filename.replace(/.js$/,''))
  ; 

var sql = 'insert into company('+
    ' PlatformId, AccountId, Name '+ 
    ' ) values ($1,$2,$3)';

extract(file, function(data){
  transform(data, function(data){
    load(data, sql, function(results){
      console.log(results);         
    });
  });
});

