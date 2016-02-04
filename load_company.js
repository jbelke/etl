var 
  path = require('path'),
  extract = require('./extract').extract,
  transform = require('./transform').transform,
  load = require('./load').load
  file = path.basename(__filename.replace(/.js$/,''))
  ; 

extract(file, function(data){
	transform(data, function(data){
		load(data, function(results){
  		console.log(results);					
		})
	})
});

