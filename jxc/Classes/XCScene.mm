//
//  HelloWorldScene.mm
//  jxc
//
//  Created by Tom Fairfield on 9/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


// Import the interfaces
#import "XCScene.h"
#import "xc.h"
#import "xc_helpers.h"



// HelloWorld implementation
@implementation XC

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	XC *layer = [XC node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// initialize your instance here
-(id) init
{
	if( (self=[super init])) {
		
		the_scene = self;
		// enable touches
		self.isTouchEnabled = YES;
		
		// enable accelerometer
		self.isAccelerometerEnabled = YES;
		
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		CCLOG(@"Screen width %0.2f screen height %0.2f",screenSize.width,screenSize.height);
		run_js();
	//	[self schedule:@selector(run_xc:) interval:1.0/30];
	}
	return self;
}

-(void) visit
{
	static double lastTime = CACurrentMediaTime();
	
	double currentTime = CACurrentMediaTime();
	
	jsdouble d = currentTime - lastTime;
	jsval rval;
	jsval argv;
	JS_NewNumberValue(cx, d, &argv);
	JS_CallFunctionName(cx, JS_GetGlobalObject(cx), "xc_update", 1, &argv, &rval);	
	
	lastTime = currentTime;
	[super visit];
	
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		float x = location.x;
		float y = location.y;
		
		xc_touch_ended(x, y);
		//[self addNewSpriteWithCoords: location];
	}
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		lastLocation = location;
		float x = location.x;
		float y = location.y;
		
		xc_touch_began(x, y);
		//[self addNewSpriteWithCoords: location];
	}
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		float x = location.x;
		float y = location.y;
		
		float x_offset = location.x - lastLocation.x;
		float y_offset = location.y - lastLocation.y;
		
		lastLocation = location;
		
		xc_touch_moved(x, y, x_offset, y_offset);
		//[self addNewSpriteWithCoords: location];
	}
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
