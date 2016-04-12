var 
  path = require('path'),
  flag = (process.argv[2] ==='-f') ? true : false,  
  extract         = flag ? require('./../../extract').extract           : require('./../extract').extract,
  verify         = flag ? require('./../../extract').verify           : require('./../extract').verify, 
  transform       = flag ? require('./../../transform').transform       : require('./../transform').transform, 
  email           = flag ? require('./../../email').email               : require('./../email').email, 
  source_db = 'finance',  // crostoli or finance
  file = path.basename(__filename.replace(/.js$/,'')),
  dir = __dirname.split(path.sep),
  folder = flag ? dir[dir.length-2] : dir.pop() ,
  subfolder = flag ? subfolder = dir.pop() : null
  ;

var sql = 'select count(*) from parent';

verify(sql, function(data){
  transform(data, function(data){
    email(file, function(){
      console.log('Data inserted.');        
    }, data);
    process.exit(0);
  });
});


