/*
 *  xc.c
 *  jxc
 *
 *  Created by Tom Fairfield on 9/13/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#import "xc.h"
#import <string.h>

#import "cocos2d.h"


#define XP_UNIX
#import "jsapi.h"

#import "xc_helpers.h"

id the_scene;
JSRuntime *rt;
JSObject  *global;
JSContext *cx;


static JSClass global_class = {
"global", JSCLASS_GLOBAL_FLAGS,
JS_PropertyStub, JS_PropertyStub, JS_PropertyStub, JS_PropertyStub,
JS_EnumerateStub, JS_ResolveStub, JS_ConvertStub, JS_FinalizeStub,
JSCLASS_NO_OPTIONAL_MEMBERS
};


void reportError(JSContext *cx, const char *message, JSErrorReport *report)
{
    fprintf(stderr, "%s:%u:%s\n",
            report->filename ? report->filename : "<no filename>",
            (unsigned int) report->lineno,
            message);
}

static JSFunctionSpec global_functions[] = 
{

	JS_FS("xc_load_sprite", xc_add_sprite, 2, 0, 0),
	JS_FS("xc_update_sprite", xc_update_sprite, 9, 0, 0),
	JS_FS("xc_get_sprite_width", xc_get_sprite_width, 1, 0, 0),
	JS_FS("xc_get_sprite_height", xc_get_sprite_height, 1, 0, 0),
	JS_FS("xc_get_tap", xc_get_tap, 0, 0, 0),
	JS_FS("xc_print", xc_print, 1, 0, 0),
		JS_FS("xc_gc", xc_gc, 0, 0, 0),
	JS_FS_END

};

int run_js()
{
    /* Create a JS runtime. */
    rt = JS_NewRuntime(8L * 1024L * 1024L);
    if (rt == NULL)
        return 1;
	
    /* Create a context. */
    cx = JS_NewContext(rt, 8192);
    if (cx == NULL)
        return 1;
    JS_SetOptions(cx, JSOPTION_VAROBJFIX);
    JS_SetVersion(cx, JSVERSION_LATEST);
    JS_SetErrorReporter(cx, reportError);
	
    /* Create the global object. */
    global = JS_NewObject(cx, &global_class, NULL, NULL);
    if (global == NULL)
        return 1;
	
    /* Populate the global object with the standard globals,
	 like Object and Array. */
    if (!JS_InitStandardClasses(cx, global))
        return 1;
	
	if (!JS_DefineFunctions(cx, global, global_functions))
		return JS_FALSE;
	
	jsval rval;
	//JSBool ok;
	NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
	
	JSScript *script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/xc_node.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);
	script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/xc_action.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);
	
	script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/xc_color.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);
	script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/xc_event.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);

	script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/xc.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);
	script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/GridEntity.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);
	
	script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/Alien.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);
	script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/DPad.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);
	script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/Man.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);
	script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/map.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);
	script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/HuntScene.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);
	script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/test.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);
	
	script = JS_CompileFile(cx, global,[[bundleRoot stringByAppendingString:@"/xc_ios.js"] cString]);
	JS_ExecuteScript(cx, global, script, &rval);
	
	JS_CallFunctionName(cx, JS_GetGlobalObject(cx), "xc_init", 0, NULL, &rval);

	return 0;
}

int close_js()
{
    /* Cleanup. */
    JS_DestroyContext(cx);
    JS_DestroyRuntime(rt);
	JS_ShutDown();
}