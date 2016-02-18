var 
	fs = require('fs')
	, path = require('path')
	, psql = require('./lib/config/destination_db.js')
	;

var load = function(data, sql, cb){
	insert(data, sql);
};

var insert = function(data, sql, cb){
	psql.connect();
	data.map(function(item,index){
		psql.query(sql, item, function(err,result){
			console.log(sql,item);
			if(err) console.log(err);
		});
	});
};

exports.load = load;


