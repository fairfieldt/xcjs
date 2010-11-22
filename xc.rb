#this is going to be the main commandline tool for xc
# it will have functions for creating new projects,
# running them, and other cool stuff.  Watch it go!
require 'ftools'
require 'webrick'

def run()
	if ARGV[0] == 'server'
		make_HTML('.')
		server('.')
	else
		project = ARGV[0]
		command = ARGV[1]
		if command == 'create'
			if !File::directory?(project)
				if ARGV.length > 2
					dimensions = ARGV[2].split('x')
				else
					dimensions = ['320','480']
				end
				new_project(project, dimensions[0], dimensions[1])
			else
				puts 'project directory already exists'
			end
		elsif command == 'server'
			make_HTML(project)
			server(project)
		else
			puts 'unrecognized command: ' + command
		end
	end
end

def new_project(name, width, height)
	puts "Creating project " + name
	Dir.mkdir(name)
	Dir.mkdir(name + '/lib')
	Dir.mkdir(name +'/resources')
	
	File.copy('./lib/htmltemplate', name + '/lib')
	File.copy('./lib/xc.js' , name + '/lib')
	File.copy('./lib/jquery-1.4.2.min.js' , name + '/lib')
	File.copy('./lib/xc_canvas.js' , name + '/lib')
	File.copy('./lib/xc_ios.js' , name + '/lib')
	
	
	File.copy('./lib/resources/man.png', name + '/resources')
	
	File.copy('./lib/main.js' , name)
	
	File.copy('./xc.rb', name)
	
	write_config(name, width, height)
	make_HTML(name)
	
end

def write_config(directory, width, height)
	contents = 'width=' + width +"\n" + 'height=' + height
	config = File.new(directory + '/config.xc', 'w')
	if config
		config.syswrite(contents)
	else
		puts 'unable to open config file.'
	end
end
	
def make_HTML(directory)
	
	config = IO.readlines(directory + '/config.xc')
	width = config[0].split('=')[1].strip
	height = config[1].split('=')[1].strip
	
	title = "XC Test"

	
	script = 'main.js'
	
	# lets get the images from the resources directory
	images = Dir[directory + '/resources/*'].find_all{|item| item =~ /.*\.png/}
	item_count = images.length.to_s()
	file_names = ''
	images.each {|image|image[directory]='';file_names += '<img src="' + image + '" onLoad="itemLoaded(this);"/>'}

	
	#now read in the html tempate
	
	template = IO.read('lib/htmltemplate')
	
	template['@TITLE'] = title
	template['@ITEMCOUNT'] = item_count
	template['@WIDTH'] = width
	template['@HEIGHT'] = height
	template['@SCRIPT'] = script
	template['@IMAGES'] = file_names
	template['@CANVASWIDTH'] = width
	template['@CANVASHEIGHT'] = height
	
	index = File.new(directory + '/index.html', 'w')
	if index
		index.syswrite(template)
	else
		puts 'unable to open index.html'
	end
end

def start_webrick(config = {})
  # always listen on port 8080
  config.update(:Port => 8000)     
  server = WEBrick::HTTPServer.new(config)
  yield server if block_given?
  ['INT', 'TERM'].each {|signal| 
    trap(signal) {server.shutdown}
  }
  server.start

end

def server(directory)
	start_webrick(:DocumentRoot => directory)
end 
run()

