xc.js - a Javascript framework for cross platform 2d games
==========================================================

[www.getxc.org](http://www.getxc.org)

Building xc.js
--------------
xc.js requires [node.js](http://www.nodejs.org), [coffeescript](http://jashkenas.github.com/coffee-script/) (0.9.5 or later), and [Ruby](http://www.ruby-lang.org/) for the build utility.

From the root directory, run cake:  
    `$ cake build  
    xc.js built.`

You can also run some unit tests:
    `$cake test`

Using xc.js
-----------

To create an xc.js project, use the xc.rb utility:  

`$ ruby xc.rb myProject create`
will create a directory named myProject. The directory contains:  

    myProject/  
	lib/  
	resources/  
	config.xc  
	index.html  
	main.js  
	xc.rb  

The **lib** directory contains the xc.js framework.  

The **resources** directory is where images and other media are stored. Images put in the resources directory will automatically be added to an xc.js project.  

**config.xc** is the project configuration file. You can specify a resolution when creating a project by appending it to the create command `myProject create 800x600`. If you don't, you can change the resolution in config.xc.  

**index.html** is the file where your canvas game will be loaded. It is automatically updated whenver you run the development server so any new resources or other changes will automatically be available.

**main.js** is the entrypoint of your xc.js game. It contains the main() function, which will be called to start the game.

xc.rb is a utility you can use to do various tasks. The most useful is

`$ ruby xc.rb server`
which will start a development server. You can then access your xc.js project with a webrowser at localhost:8000.  

Adding a new backend
--------------------
xc.js is designed to be easy to port to new platforms.  All that is required is a new xc_platform.coffee file for the new platform.  Platform compat source is in the src/compat directory.  

The canvas implementation, in `xc_canvas.coffee` is documented and should provide a good starting point for a new backend.   
