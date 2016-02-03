var 
	fs = require('fs')		
	, path = require('path')
	, f = require('./lib/format.js')
	;

var transform = function(data, cb){
	for(var record in data){ if (data.hasOwnProperty(record)){ // (records as objects)data[record]
		for(var item in data[record]){ if(data[record].hasOwnProperty(item)){ // (key)item : (values)data[record][item] 
			if (f.isDate(data[record][item])) { // format date
				data[record][item] = f.formatDate(data[record][item]);
			}

			if ( ( !f.isDateColumn(item) ) && ( !f.isExcludeColumn(item) ) && ( !isNaN(parseFloat(data[record][item])) ) && ( !f.hasPercentString(data[record][item]) ) ) { // format numbers
				data[record][item] = f.formatNumber(parseInt(data[record][item]));
			}	}
		}	}
	}
	cb(data);
};

