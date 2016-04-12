var 
	fs = require('fs')		
	, path = require('path')
	,	data = ''
	;

var extract = function(db, file, subfolder, cb){
	loadQuery(db, file, subfolder, cb);
};

var verify = function(sql, cb){
	executePostgres(sql, cb);
};

var loadQuery = function(db, file, subfolder, cb) {
	var sqlFile = subfolder ? fs.createReadStream(path.join('./../../sql',subfolder,file+'.sql')) : fs.createReadStream(path.join('./../sql',file+'.sql'));
	sqlFile.on('data',function(chunk){data+=chunk;});
	sqlFile.on('end',function(){
		if(db === 'crostoli') {
			executeMSSQL(data, cb);		
		} else if (db === 'finance') {
			executePostgres(data, cb);
		}
	});
};

var executeMSSQL = function(sql, cb) {
	var mssql = require('mssql'),
	  source_db = require('./lib/config/crostoli_db.js')
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

var executePostgres = function(sql, cb) {
	var source_db = require('./lib/config/finance_db.js');
	source_db.connect(function(err){
		source_db.query(sql, function(err,result){
			if (err) console.log(err);
			console.log(result);
			cb(result.rows);
		});	
	});
};

exports.extract = extract;
exports.verify = verify;

