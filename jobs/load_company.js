var 
  path = require('path'),
  flag = (process.argv[2] ==='-f') ? true : false,  
  extract         = flag ? require('./../../extract').extract           : require('./../extract').extract,
  transform       = flag ? require('./../../transform').transform       : require('./../transform').transform, 
  load            = flag ? require('./../../load').load                 : require('./../load').load,   
  email           = flag ? require('./../../email').email               : require('./../email').email, 
  destination_db  = flag ? require('./../../lib/config/finance_db.js')  : require('./../lib/config/finance_db.js') ,   
  source_db = 'crostoli',  // crostoli or finance
  file = path.basename(__filename.replace(/.js$/,'')),
  dir = __dirname.split(path.sep),
  folder = flag ? dir[dir.length-2] : dir.pop() ,
  subfolder = flag ? subfolder = dir.pop() : null
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

