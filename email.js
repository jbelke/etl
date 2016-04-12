 var 
	emailjs = require('emailjs'), 
	emailconfig = require('./lib/config/email.js'), 
	email_server = emailjs.server.connect(emailconfig)
	;
 
var email = function(file, cb, data){
	email_server.send({
	  subject: file+' job ran.',
	  text: file+'job ran',
	  from: 'John Skilbeck jskilbeck@yapstone.com',
	  to: 'John Skilbeck jskilbeck@yapstone.com',
	});

	cb();
};




exports.email = email;
