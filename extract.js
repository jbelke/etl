var 
	fs = require('fs')		
	, path = require('path')
	,	data = ''
	;

var extract = function(db_type, source_db, file, cb){
	loadQuery(db_type, source_db, file, cb);
};

var loadQuery = function(db_type, source_db, file, cb) {
	var sqlFile = fs.createReadStream(path.join('./../sql',file+'.sql'));
	sqlFile.on('data',function(chunk){data+=chunk;});
	sqlFile.on('end',function(){
		if(db_type === 'MSSQL') {
			executeMSSQL(source_db, data, cb);		
		} else if (db_type === 'PSQL') {
			executePSQL(source_db, data, cb);
		}
	});
};

var executeMSSQL = function(source_db, sql, cb) {
	var mssql = require('mssql');
	var connection 	= new mssql.Connection(source_db, function(err) {
		if (err) console.log(err);
		var r = new mssql.Request(connection);
		r.query(sql, function(err, results){
			if (err) console.log(err);
			cb(results);
		});
	});
};

var executePSQL = function(source_db, sql, cb) {
	// var connection 	= new mssql.Connection(db_config, function(err) {
	// 	if (err) console.log(err);
	// 	var r = new mssql.Request(connection);
	// 	r.query(sql, function(err, results){
	// 		if (err) console.log(err);
	// 		cb(results);
	// 	});
	// });
};

exports.extract = extract;

