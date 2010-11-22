###
Copyright 2010 Tom Fairfield. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are

  1. Redistributions of source code must retain the above copyright notice, this list of
      conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright notice, this list
      of conditions and the following disclaimer in the documentation and/or other materials
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY Tom Fairfield ``AS IS'' AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those of the
authors and should not be interpreted as representing official policies, either expressed
or implied, of Tom Fairfield.
###


#option '-o', '--output [filename]', 'name for output file'

CoffeeScript  = require 'coffee-script'
fs = require('fs')
require('underscore')
sys = require('sys')
puts = sys.puts
{spawn, exec} = require 'child_process'


run = (args) ->
  proc =         spawn 'coffee', args
  proc.stderr.on 'data', (buffer) -> puts buffer.toString()
  proc.stdout.on 'data', (buffer) -> puts buffer.toString()
  proc.on        'exit', (status) -> process.exit(1) if status != 0
  
 runBuild = (args) ->
  proc =         spawn 'coffee', args
  proc.stderr.on 'data', (buffer) -> puts buffer.toString()
  proc.stdout.on 'data', (buffer) -> fs.writeFile('./lib/xc.coffee',  buffer.toString(),compile('./lib/xc.coffee', './lib'))
  proc.on        'exit', (status) -> process.exit(1) if status != 0

output = ''
runTest = (args) ->
  proc =         spawn 'coffee', args
  proc.stderr.on 'data', (buffer) -> console.log buffer.toString()
  proc.stdout.on 'data', (buffer) -> CoffeeScript.run(buffer.toString(), {'test'})
  proc.on        'exit', (status) -> process.exit(1) if status != 0
  
  return output

compile = (fileName, outputDir)  ->
	run(['-c', '--bare', '-o', outputDir, fileName])

addLicense = (fileName) -> 
	f = "###\n" + fs.readFileSync('./lib/license.txt').toString() + "\n###\n"
	f += fs.readFileSync(fileName).toString()
	fs.writeFileSync(fileName, f)

task 'test', 'run the xc test suite', (options) ->
	args = ['./tools/coffeescript-concat.coffee','-I', './src', '-I', './src/compat', '-I', './tools', '-I', './tests', './tests/runtests.coffee']
	runTest(args)
	console.log(output)


task 'build', 'build the xc library - final lib will be in lib/xc.js', (options) ->
	invoke('concat')
	compile('./src/compat/xc_canvas.coffee', './lib')

task 'concat_canvas', 'build the canvas compatability'
task 'concat', 'concat the xc library', (options) ->
	args = ['./tools/coffeescript-concat.coffee', '-I', './src', '-I', './src/compat']
	args.push('./src/' + fileName) for fileName in fs.readdirSync('./src')
	runBuild(args)






