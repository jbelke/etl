var 
	fs = require('fs')		
	, path = require('path')
	, mssql = require('mssql')
	,	data = ''
	, db_config = require('./lib/config/source_db.js')
	;

var extract = function(file, cb){
	loadQuery(file, cb);
};

var loadQuery = function(file, cb) {
	var sqlFile = fs.createReadStream(path.join('./sql',file+'.sql'))
	sqlFile.on('data',function(chunk){data+=chunk;});
	sqlFile.on('end',function(){
		executeQuery(data, cb);		
	});
};

var executeQuery = function(sql, cb) {
	var connection 	= new mssql.Connection(db_config, function(err) {
		if (err) console.log(err);
		var r = new mssql.Request(connection);
		r.query(sql, function(err, results){
			if (err) console.log(err);
			cb(results);
		});
	});
};

exports.extract = extract;

