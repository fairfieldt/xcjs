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


JSBool xc_add_sprite(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	static unsigned int id = 0;
	CCSprite *sprite = nil;
	const char *file_name;
	int z;
	
	if (!JS_ConvertArguments(cx, argc, argv, "si", &file_name, &z))
		return JS_FALSE;
	
	sprite = [CCSprite spriteWithFile:[NSString stringWithCString:file_name]];
	[the_scene addChild:sprite z:z tag:id];
	
	jsdouble jid = id++;
	
	return JS_NewNumberValue(cx, jid, rval);
}

JSBool xc_draw(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	CCNode *sprite = nil;
	unsigned int id = 0;
	double x = 0;
	double y = 0;
	double scale = 0;
	double rotation = 0;
	printf("calling draw\n");
	if (!JS_ConvertArguments(cx, argc, argv, "udddd", &id, &x, &y, &scale, &rotation))
		return JS_FALSE;
	printf("id: %i x: %f y: %f scale: %f rotation: %f\n", id, x, y, scale, rotation);
	sprite = [the_scene getChildByTag:id];

	[sprite setPosition:ccp(x, y)];
	sprite.scale = scale;
	sprite.rotation = rotation;
		
	return JS_TRUE;
}

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
		jsdouble y = t.y;
		jsdouble ox = t.offset_x;
		jsdouble oy = t.offset_y;
		jsdouble count = t.tapCount;
		
		jsval xval, yval, oxval, oyval, countval;
		
		JS_NewNumberValue(cx, x, &xval);
		JS_NewNumberValue(cx, y, &yval);
		JS_NewNumberValue(cx, ox, &oxval);
		JS_NewNumberValue(cx, oy, &oyval);
		JS_NewNumberValue(cx, count, &countval);
		
		JSObject *tap = JS_NewObject(cx, NULL, NULL, NULL);
		
		JS_DefineProperty(cx, tap, "x", xval, NULL, NULL, 0);
		JS_DefineProperty(cx, tap, "y", yval, NULL, NULL, 0);
		JS_DefineProperty(cx, tap, "xMove", oxval, NULL, NULL, 0);
		JS_DefineProperty(cx, tap, "yMove", oyval, NULL, NULL, 0);
		JS_DefineProperty(cx, tap, "Number", countval, NULL, NULL, 0);


		ret = OBJECT_TO_JSVAL(tap);
	}
	else
	{
		ret = JSVAL_VOID;
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

void xc_touch_ended(float x, float y)
{
	tap tap;
	tap.x = x;
	tap.y = y;
	tap.offset_x = 0;
	tap.offset_y = 0;
	tap.tapCount = 0;
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
	taps.push(tap);
}