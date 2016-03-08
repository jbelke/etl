var 
	fs = require('fs')
	, path = require('path')
	;

var load = function(data, destination_db, insert_sql, cb){
	insert(data, destination_db, insert_sql, cb);
};

var insert = function(data, destination_db, insert_sql, cb){
	destination_db.connect(function(err){
		data.map(function(item,index){
			destination_db.query(insert_sql, item, function(err,result){
				console.log(err || result);
				// setTimeout(function(){
				// 	destination_db.end();
				// }, 1 * 60 * 1000);
			});
		});

	});
	
	cb();

};

exports.load = load;


