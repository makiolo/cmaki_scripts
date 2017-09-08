#!/usr/bin/env node
var os = require('os')
var fs = require('fs');
var path = require('path')
var shelljs = require('shelljs');
var exec = shelljs.exec;

if(!process.env.CMAKI_PWD)
{
	if (fs.existsSync(path.join("..", "..", "node_modules", "cmaki_identifier"))) {
		shelljs.env['CMAKI_PWD'] = path.join(process.cwd(), '..', '..');
		process.env['CMAKI_PWD'] = path.join(process.cwd(), '..', '..');
	} else {
		shelljs.env['CMAKI_PWD'] = path.join(process.cwd());
		process.env['CMAKI_PWD'] = path.join(process.cwd());
	}
}
if(!process.env.CMAKI_INSTALL)
{
	if (fs.existsSync(path.join("..", "..", "node_modules", "cmaki_identifier"))) {
		shelljs.env['CMAKI_INSTALL'] = path.join(process.cwd(), '..', '..', 'bin');
		process.env['CMAKI_INSTALL'] = path.join(process.cwd(), '..', '..', 'bin');
	} else {
		shelljs.env['CMAKI_INSTALL'] = path.join(process.cwd(), 'bin');
		process.env['CMAKI_INSTALL'] = path.join(process.cwd(), 'bin');
	}
}

function trim(s)
{
	return ( s || '' ).replace( /^\s+|\s+$/g, '' );
}

var is_win = (os.platform() === 'win32');
var dir_script;
var script = process.argv[2];
if (is_win)
{
	if(fs.existsSync(path.join(__dirname, script+".cmd")))
	{
		dir_script = __dirname;
	}
	else
	{
		dir_script = path.join(process.cwd(), '..', 'node_modules', 'cmaki_scripts');
	}
}
else
{
	if(fs.existsSync(path.join(__dirname, script+".sh")))
	{
		dir_script = __dirname;
	}
	else
	{
		dir_script = path.join(process.cwd(), '..', 'node_modules', 'cmaki_scripts');
	}
}

if (is_win)
{
	script_execute = path.join(dir_script, script+".cmd");
	exists = fs.existsSync(script_execute)
	caller_execute = "cmd /c "
	script_execute = script_execute.replace(/\//g, "\\");
}
else
{
	script_execute = path.join(dir_script, script+".sh");
	exists = fs.existsSync(script_execute)
	caller_execute = "bash "
	script_execute = script_execute.replace(/\\/g, "/");
}

if(exists)
{
	var child = exec(caller_execute + script_execute, {async:true, silent:true}, function(err, stdout, stderr) {
		process.exit(err);
	});
	child.stdout.on('data', function(data) {
		console.log(trim(data));
	});
	child.stderr.on('data', function(data) {
		console.log(trim(data));
	});
}
else
{
	console.log("[error] dont exits: " + script_execute);
}
