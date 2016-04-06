var 
  path = require('path'),
  flag = (process.argv[2] ==='-f') ? true : false,  
  extract         = flag ? require('./../../extract').extract           : require('./../extract').extract,
  transform       = flag ? require('./../../transform').transform       : require('./../transform').transform, 
  load            = flag ? require('./../../load').load                 : require('./../load').load,   
  email           = flag ? require('./../../email').email               : require('./../email').email, 
  // destination_db  = flag ? require('./../../lib/config/localhost_db.js')  : require('./../lib/config/localhost_db.js') ,  
  destination_db  = flag ? require('./../../lib/config/finance_db.js')  : require('./../lib/config/finance_db.js') ,   
  source_db = 'crostoli',  // crostoli or finance
  file = path.basename(__filename.replace(/.js$/,'')),
  dir = __dirname.split(path.sep),
  folder = flag ? dir[dir.length-2] : dir.pop() ,
  subfolder = flag ? subfolder = dir.pop() : null
  ;

var sql = 'insert into mpr_base('+
    ' Date, PlatformId, Vertical, ' +
    ' ParentAccountId, ParentName, ' +
    ' MMF ' +
    ' ) values ($1,$2,$3,$4,$5,$6)';

extract(source_db, file, subfolder, function(data){
  // console.log(data);
	transform(data, function(data){
    // console.log(data);
		load(data, destination_db, sql, function(){
      email(file, function(){
        console.log('Data inserted.');        
      });
		});
	});
});

