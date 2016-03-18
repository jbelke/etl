var 
	fs = require('fs')		
	, path = require('path')
	,	data = ''
	;

var extract = function(db, file, subfolder, cb){
	loadQuery(db, file, subfolder, cb);
};

var loadQuery = function(db, file, subfolder, cb) {
	var sqlFile = subfolder ? fs.createReadStream(path.join('./../../sql',file+'.sql')) : fs.createReadStream(path.join('./../sql',file+'.sql'));
	sqlFile.on('data',function(chunk){data+=chunk;});
	sqlFile.on('end',function(){
		if(db === 'crostoli') {
			executeMSSQL(data, subfolder, cb);		
		} else if (db === 'finance') {
			executePostgres(data, cb);
		}
	});
};

var executeMSSQL = function(sql, subfolder, cb) {
	var mssql = require('mssql'),
	  var source_db = subfolder ? require('./../lib/config/crostoli_db.js') : require('./lib/config/crostoli_db.js')
	  ;

	var connection 	= new mssql.Connection(source_db, function(err) {
		if (err) console.log(err);
		var r = new mssql.Request(connection);
		r.query(sql, function(err, results){
			if (err) console.log(err);
			cb(results);
		});
	});
};

var executePostgres = function(sql, subfolder, cb) {
	var source_db = subfolder ? require('./../lib/config/finance_db.js') : require('./lib/config/finance_db.js');
	source_db.connect(function(err){
		source_db.query(sql, function(err,result){
			if (err) console.log(err);
			cb(result.rows);
		});	
	});
};

exports.extract = extract;

