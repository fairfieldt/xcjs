#this is going to be the main commandline tool for xc
# it will have functions for creating new projects,
# running them, and other cool stuff.  Watch it go!
require 'sprockets'
require 'ftools'


def run()
	project = ARGV[0]
	command = ARGV[1]
	if command == 'create'
		if !File::directory?(project)
			new_project(project)
		else
			puts 'project directory already exists'
		end
	else
		puts 'unrecognized command ' + command
	end
end

def new_project(name)
	puts "Creating project " + name
	Dir.mkdir(name)
	Dir.mkdir(name + '/lib')
	Dir.mkdir(name +'/resources')
	
	File.copy('./lib/xc.js' , name + '/lib')
	File.copy('./lib/jquery-1.4.2.min.js' , name + '/lib')
	File.copy('./lib/xc_canvas.js' , name + '/lib')
	
	File.copy('./lib/resources/man.png', name + '/resources')
	
	File.copy('./lib/test.js' , name)
	
	make_HTML(name)
	
end

def make_HTML(directory)
	
	puts "This is gonna make a good HTML file"
	
	title = "XC Test"
		
	width = '320'
	height = '480'
	
	script = 'test.js'
	
	# lets get the images from the resources directory
	images = Dir[directory + '/resources/*'].find_all{|item| item =~ /.*\.png/}
	item_count = images.length.to_s()
	file_names = ''
	images.each {|image|image[directory]='';file_names += '<img src="' + image + '" onLoad="itemLoaded(this);"></img>'}

	
	#now read in the html tempate
	
	template = IO.read('lib/htmltemplate')
	
	template['@TITLE'] = title
	template['@ITEMCOUNT'] = item_count
	template['@WIDTH'] = width
	template['@HEIGHT'] = height
	template['@SCRIPT'] = script
	template['@IMAGES'] = file_names
	
	index = File.new(directory + '/index.html', 'w')
	if index
		index.syswrite(template)
	else
		puts 'unable to open index.html'
	end
end

run()

