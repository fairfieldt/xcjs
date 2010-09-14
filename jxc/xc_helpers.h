/*
 *  xc_helpers.h
 *  jxc
 *
 *  Created by Tom Fairfield on 9/13/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#define XP_UNIX
#import "jsapi.h"
#import <queue>

#define TAPDOWN 0
#define TAPMOVED 1
#define TAPUP 2

extern id the_scene;
extern JSRuntime *rt;
extern JSObject  *global;
extern JSContext *cx;


JSBool xc_add_sprite(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval);
JSBool xc_draw(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval);
JSBool xc_update_sprite(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval);
JSBool xc_get_sprite_width(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval);
JSBool xc_get_sprite_height(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval);

JSBool xc_get_tap(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval);
JSBool xc_print(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval);

void xc_touch_ended(float x, float y);
void xc_touch_began(float x, float y);
void xc_touch_moved(float x, float y, float offset_x, float offset_y);


typedef struct {
	float x;
	float y;
	float offset_x;
	float offset_y;
	int tapCount;
	int type;
} tap;
