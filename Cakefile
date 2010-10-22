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

fs = require('fs')
require('underscore')
{spawn, exec} = require 'child_process'


run = (args) ->
  proc =         spawn 'coffee', args
  proc.stderr.on 'data', (buffer) -> puts buffer.toString()
  proc.on        'exit', (status) -> process.exit(1) if status != 0




task 'build', 'build the xc library - final lib will be in lib/xc.js', (options) ->
	invoke 'concat'
	run(['-c', '--no-wrap', './lib/xc.coffee'])

task 'concat', 'concatenate .coffee files to a single source file while resolving dependencies', (options) ->
	concatenate('./src', './lib/xc.coffee', [''])




# Search through a file and find all class definitions,
# ignoring those in comments
#
findClasses = (file) ->
	#ugly ugly ugly hack but I must be doing something stupid with the regex
	file = '\n' + file
	classRegex = /\n[^#\n]*class\s([^\s]*)/g
	
	classNames = []
	while (result = classRegex.exec(file)) != null
		classNames.push(result[1])
	return classNames

# Search through a file and find all dependencies,
# which is be done by finding all 'exends'
# statements.  Ignore those in comments
#
findDependencies = (file) ->
	#ugly ugly ugly hack but I must be doing something stupid with the regex
	file = '\n' + file
	
	dependencyRegex = /\n[^#\n]*extends\s([^\s]*)/g
	
	dependencies = []
	while (result = dependencyRegex.exec(file)) != null
		dependencies.push(result[1])
		
	directiveRegex = /#=\s*require\s+([^\s]*)/g
	while (result = directiveRegex.exec(file)) != null
		console.log(result[1])
		dependencies.push(result[1])
	return dependencies

	
# Given a path to a directory and, optionally, a list of classes to ignore
# since they are defined elsewhere, create a list of all files with the
# classes they contain and the classes those classes depend on.
#	
mapDependencies = (path, ignoreList) ->
	files = fs.readdirSync(path)
	
	fileDefs = []
	for file in files when /\.coffee$/.test(file)
		contents = fs.readFileSync(path + '/' +  file).toString()
		classes = findClasses(contents)
		dependencies = findDependencies(contents)
		
		#filter out the dependencies in the same file.
		falseDeps = classes.concat(ignoreList)
		dependencies = _.select(dependencies, (d) -> _.indexOf(falseDeps, d) == -1)

		fileDef = {name: file, classes: classes, dependencies: dependencies, contents: contents}
		fileDefs.push(fileDef)
		
	return fileDefs

# Given a list of files and their class/dependency information,
# traverse the list and put them in an order that satisfies dependencies. 
# Walk through the list, taking each file and examining it for dependencies.
# If it doesn't have any it's fit to go on the list.  If it does, find the file(s)
# that contain the classes dependencies.  These must go first in the hierarchy.
#	
concatFiles = (fileDefs) ->	

	usedFiles = []
	allFileDefs = fileDefs.slice(0)

	# Given a class name, find the file that contains that
	# class definition.  If it doesn't exist or we don't know
	# about it, return null
	findFileDefByClass = (className) ->
		for fileDef in allFileDefs
			for c in fileDef.classes
				if c == className
					return fileDef
		return null
	
	# recursively resolve the dependencies of a file.  If it 
	# has no dependencies, return that file in an array.  Otherwise,
	# find the files with the needed classes and resolve their dependencies
	#
	resolveDependencies = (fileDef) ->
		dependenciesStack = []
		if _.indexOf(usedFiles, fileDef.name) != -1
			return null
		else if fileDef.dependencies.length == 0
			dependenciesStack.push(fileDef)
			usedFiles.push(fileDef.name)
		else
			for dependency in fileDef.dependencies
				depFileDef = findFileDefByClass(dependency)
				if depFileDef == null
				#	console.log("Error: couldn't find needed class: " + dependency)
				else
					nextStack = resolveDependencies(depFileDef)
					dependenciesStack = if nextStack then nextStack else []
				
				if _.indexOf(usedFiles, fileDef.name) == -1
					dependenciesStack.push(fileDef)
					usedFiles.push(fileDef.name)

		return dependenciesStack
			
	fileDefStack = []
	while fileDefs.length > 0
		nextFileDef = fileDefs.pop()
		resolvedDef = resolveDependencies(nextFileDef)
		if resolvedDef
			fileDefStack = fileDefStack.concat(resolvedDef)

	for f in fileDefStack
		console.log(f.name)
	output = ''
	for nextFileDef in fileDefStack
		output += nextFileDef.contents + '\n'

	return output
	
# Given a source directory, a relative filename to output
# to, and optionally a list of class names to ignore, 
# resolve the dependencies and put all classes in one file
#
concatenate = (directory, outputName, ignoreList) ->
	if ignoreList == null then ignoreList = ['']

	deps = mapDependencies(directory, ignoreList)
	output = concatFiles(deps)
	fs.writeFileSync(outputName, output)
	
