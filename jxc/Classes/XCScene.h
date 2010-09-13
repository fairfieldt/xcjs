//
//  HelloWorldScene.h
//  jxc
//
//  Created by Tom Fairfield on 9/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"

extern id the_scene;
// HelloWorld Layer
@interface XC : CCLayer
{
	CGPoint lastLocation;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end
