/*
 *  xc_helpers.cpp
 *  jxc
 *
 *  Created by Tom Fairfield on 9/13/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#import "xc_helpers.h"
#import "cocos2d.h"

std::queue<tap> taps;
static unsigned int currentId = 0;



JSBool xc_add_sprite(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	CCSprite *sprite = nil;
	const char *file_name;
	int z;
	
	if (!JS_ConvertArguments(cx, argc, argv, "si", &file_name, &z))
		return JS_FALSE;
	NSString *name = [NSString stringWithCString:file_name];

	sprite = [CCSprite spriteWithFile:name];
	sprite.anchorPoint = ccp(0, 1);

	[the_scene addChild:sprite z:z tag:currentId];
	
	jsdouble jid = currentId++;
	
	return JS_NewNumberValue(cx, jid, rval);
}

JSBool xc_update_sprite(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	
	CCSprite *sprite = nil;
	unsigned int id = 0;
	double x = 0;
	double y = 0;
	double scaleX, scaleY = 0;
	double rotation = 0;
	double opacity = 0;
	double anchorX, anchorY = 0;
	
	if (!JS_ConvertArguments(cx, argc, argv, "udddddddd", &id, &x, &y, &scaleX, &scaleY, &rotation, &opacity, &anchorX, &anchorY))
		return JS_FALSE;
	
	sprite = (CCSprite*)[the_scene getChildByTag:id];
	
	[sprite setPosition:ccp(x, 480-y)];
	sprite.scaleX = scaleX;
	sprite.scaleY = scaleY;
	sprite.rotation = rotation;
	sprite.opacity = opacity * 255;
	sprite.anchorPoint = ccp(anchorX, 1.0 - anchorY);
	return JS_TRUE;
}
/*
JSBool xc_update_text(JSContext *cs, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	CCLabelTTF *text = nil;
	unsigned int id = 0;
	double x = 0;
	double y = 0;
	double scaleX, scaleY = 0;
	double rotation = 0;
	double opacity = 0;
	int red, green, blue = 0;
	int fontSize = 0;

	
	if (!JS_ConvertArguments(cx, argc, argv, "uddddddd", &id, &x, &y, &scaleX, &scaleY, &rotation, &opacity, &red, &green, &blue, &fontSize))
		return JS_FALSE;
		
	text = [the_scene getChildByTag:id];
	
	text.x = x;
	text.y = y;
	text.scaleX = scaleX;
	text.scaleY = scaleY;
	text.rotation = rotation;
	text.opacity = opacity;
	text.color = ccColor3B(red, green, blue);
	
	return JS_TRUE;
	
}
 */

JSBool xc_get_sprite_width(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	id sprite = nil;
	unsigned int id = 0;
	printf("getting width\n");
	if (!JS_ConvertArguments(cx, argc, argv, "u", &id))
		return JS_FALSE;
	printf("got the id: %i\n", id);
	sprite = [the_scene getChildByTag:id];
	jsdouble width = [sprite contentSize].width;
	printf("width is %f\n", [sprite contentSize].width);
	return JS_NewNumberValue(cx, width, rval);
}

JSBool xc_get_sprite_height(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	id sprite = nil;
	unsigned int id = 0;
	
	if (!JS_ConvertArguments(cx, argc, argv, "u", &id))
		return JS_FALSE;
	
	sprite = [the_scene getChildByTag:id];
	jsdouble height = [sprite contentSize].height;
	
	return JS_NewNumberValue(cx, height, rval);
}

JSBool xc_get_tap(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval ret;
	if (taps.size() > 0)
	{

		tap t = taps.front();
		taps.pop();
		
		jsdouble x = t.x;
		jsdouble y = 480 - t.y;
		jsdouble ox = t.offset_x;
		jsdouble oy = t.offset_y;
		jsdouble count = t.tapCount;
		const char *type;
		if (t.type == 0)
		{
			type = "tapDown";
		}
		else if (t.type == 1)
		{
			type = "tapUp";
		}
		else if (t.type == 2)
		{
			type = "tapMoved";
		}
		else
		{
			type = "undefined";
		}
		
		jsval xval, yval, oxval, oyval, countval;
		
		JS_NewNumberValue(cx, x, &xval);
		JS_NewNumberValue(cx, y, &yval);
		JS_NewNumberValue(cx, ox, &oxval);
		JS_NewNumberValue(cx, oy, &oyval);
		JS_NewNumberValue(cx, count, &countval);
		JSString *typeval = JS_NewString(cx, (char*)type, strlen(type));

		
		JSObject *tap = JS_NewObject(cx, NULL, NULL, NULL);
		
		JS_DefineProperty(cx, tap, "x", xval, NULL, NULL, 0);
		JS_DefineProperty(cx, tap, "y", yval, NULL, NULL, 0);
		JS_DefineProperty(cx, tap, "moveX", oxval, NULL, NULL, 0);
		JS_DefineProperty(cx, tap, "moveY", oyval, NULL, NULL, 0);
		JS_DefineProperty(cx, tap, "number", countval, NULL, NULL, 0);
		JS_DefineProperty(cx, tap, "name", STRING_TO_JSVAL(typeval), NULL, NULL, 0);

		ret = OBJECT_TO_JSVAL(tap);
	}
	else
	{
		ret = JSVAL_NULL;
	}
	*rval = ret;
	return JS_TRUE;
}

JSBool xc_print(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	const char *message;
	
	if (!JS_ConvertArguments(cx, argc, argv, "s", &message))
		return JS_FALSE;
	printf("%s\n", message);
	return JS_TRUE;
}

JSBool xc_gc(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	JS_MaybeGC(cx);
	return JS_TRUE;
}

void xc_touch_ended(float x, float y)
{
	tap tap;
	tap.x = x;
	tap.y = y;
	tap.offset_x = 0;
	tap.offset_y = 0;
	tap.tapCount = 0;
	tap.type = TAPUP;
	taps.push(tap);
}

void xc_touch_began(float x, float y)
{
	tap tap;
	tap.x = x;
	tap.y = y;
	tap.offset_x = 0;
	tap.offset_y = 0;
	tap.tapCount = 0;
	tap.type = TAPDOWN;
	taps.push(tap);
}

void xc_touch_moved(float x, float y, float offset_x, float offset_y)
{
	tap tap;
	tap.x = x;
	tap.y = y;
	tap.offset_x = offset_x;
	tap.offset_y = offset_y;
	tap.tapCount = 0;
	tap.type = TAPMOVED;
	taps.push(tap);
}
