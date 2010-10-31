#this is going to be the main commandline tool for xc
# it will have functions for creating new projects,
# running them, and other cool stuff.  Watch it go!
require 'sprockets'
def makeHTML()
	puts "This is gonna make a good HTML file"
	
	secretary = Sprockets::Secretary.new(:asset_root => '.',
										:load_path => '.',
										:source_files => ['main.js'])
	concatenation = secretary.concatenation
	concatenation.save_to('.')
	
	#first lets get the images from the resources directory
	images = Dir['./resources/*'].find_all{|item| item =~ /.*\.png/}
	
	#now lets write a simple html file
	html = '<html><head><title>XC</title></head><body><div style:visibility="hidden">'
	images.each {|image| html += '<img src="' + image + '"></img>'}
	html += '</body></html>'
	
	puts html
		
end

makeHTML()