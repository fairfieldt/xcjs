/*
 * Copyright (c) 2010 Noah Sloan <http://noahsloan.com>
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

/**
 * Simple webserver with logging. Serves whatever files are reachable from
 * the directory where node is running.
 */
var posix = require('fs'),
	sys = require('sys');

var DEBUG = 0, INFO = 1, WARN = 2, ERROR = 3;
var LOG_LEVEL = DEBUG;

var MAX_READ = 1024 * 1024 * 5; // 5MB - max bytes to request at a time
var TIMEOUT = 1000 * 30; // 30 seconds
var PORT = 8080;

var baseDir = "./";

require("http").createServer(function(req,resp) {
	// don't allow ../ in paths
	var file = req.uri.path.replace(/\.\.\//g,'').substring(1) || 'index.html';
	// try to get the content type right for html at least...
	var contentType = (/\.(.*?)$/.exec(file)||[])[1] == 'html' ? 
		'text/html' : null;
	log(DEBUG,"Got request for",file,contentType);
	streamFile(baseDir + file,resp,contentType);
}).listen(PORT);

log(INFO,"Server running on port",PORT);

function streamFile(file,resp,contentType) {
    var die = setTimeout(finish,TIMEOUT);
    posix.open(file,process.O_RDONLY,438).addCallback(function(fd) {
	    var position = 0;
	    log(DEBUG,"opened",fd);
	    if(fd) {
			log(DEBUG,"sendHeader 200");
			resp.sendHeader(200,{"Content-Type":contentType || "text/plain"});
			read();
			function read() {
			    posix.read(fd,MAX_READ,position).addCallback(function(data,bytes_read) {
				    log(DEBUG,"read",bytes_read,"bytes of",file);
				    if(bytes_read > 0) {
						resp.sendBody(data);
						position += bytes_read;
						read(); // read more
				    } else {				
						finish(fd);
				    }
			    }).addErrback(function() {
					log(ERROR,"Error reading from",file,"position:",position,
						">",arguments);
					resp.sendBody("*** Error reading from "+file+
						". Check the console for details. ***");
					finish(fd);
				});
			}
	    } else {
			log(WARN,"Invalid fd for file:",file);
			resp.sendHeader(500,{"Content-Type":"text/plain"});			
			resp.sendBody(file);
			resp.sendBody(" couldn't be opened.");
			finish(fd);
	    }
    }).addErrback(function() {
	    log(DEBUG,"404 opening",file,">",arguments);
		resp.sendHeader(404,{"Content-Type":"text/plain"});
		resp.sendBody("*** Error opening "+file+
			". Check the console for details. ***");
		finish();
    });
    function finish(fd) {	
		resp.finish();
		log(DEBUG,"finished",fd);
		clearTimeout(die);			
		if(fd) {
		    posix.close(fd);
		}
    }
}

/* Logging/Utility Functions */
function log(level) {
    if(level >= LOG_LEVEL) sys.puts(join(slice(arguments,1)));
}
function slice(array,start) {
	return Array.prototype.slice.call(array,start);
}
function isString(s) {
	return typeof s === "string" || s instanceof String;
}
function flatten(array) {
	var result = [], i, len = array && array.length;
	if(len && !isString(array)) {
		for(i = 0; i < len; i++) {
			result = result.concat(flatten(array[i]));
		}
	} else if(len !== 0) {
		result.push(array);
	}
	return result;
}
function join() {
	return flatten(slice(arguments,0)).join(" ");
}